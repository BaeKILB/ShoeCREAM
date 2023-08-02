package com.pj2.shoecream.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.*;
import org.springframework.security.core.context.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.pj2.shoecream.config.*;
import com.pj2.shoecream.handler.JsonHandler;
import com.pj2.shoecream.handler.JungHandler;
import com.pj2.shoecream.service.CategoryService;
import com.pj2.shoecream.service.ChatService;
import com.pj2.shoecream.service.JungGoNohService;
import com.pj2.shoecream.service.JungProductService;
import com.pj2.shoecream.vo.JungGoNohVO;
import com.pj2.shoecream.vo.JungProductVO;
import com.pj2.shoecream.vo.LCategory;
import com.pj2.shoecream.vo.PageInfoVO;


@Controller
public class JunggoController {
	
	private static final Logger logger = LoggerFactory.getLogger(JunggoController.class);
	
	@Autowired
	private JungGoNohService jungGoNohService;
	
	@Autowired
	private ChatService chatService;

	@Autowired
	private JungProductService jProductService;
	
	@Autowired
	private JsonHandler jHandler;

	@Autowired
	private JungHandler jungHandler;
	
	@Autowired
	private CategoryService cService;
	
	// 중고 항목 페이징 처리때 사용될 상수
	// 중고 리스트 불러올때 최대 리미트
	public static final int JUNG_PRODUCT_LIMIT = 8;
	
	@GetMapping("JunggoSearch")
	public String junggoSearch(
			@RequestParam Map<String,Object> map, 
			Model model) {
		JungProductVO jproduct = new JungProductVO();
		if(map.get("lc_code") != null) {
			jproduct.setLc_code(Integer.parseInt(((String)map.get("lc_code")).trim()));			
		}
		if(map.get("mc_code") != null) {
			jproduct.setMc_code(Integer.parseInt(((String)map.get("mc_code")).trim()));			
		}
		
		// 카테고리 리스트 받아오기
		// 카테고리 리스트 받아올 변수 초기화
		List<Map<String, Object>> lc = null;
		
		// 에러처리
		try {			
			lc = cService.getLcList();
			model.addAttribute("lc_list", lc);
			
			// 카테고리 중 리스트 담기
			List<List<Map<String, Object>>> mc_list = new ArrayList<List<Map<String, Object>>>();
	
			
			for(Map<String,Object> e : lc) {				
				List<Map<String, Object>> mc = cService.getMcList((Integer)e.get("lc_code"));
				mc_list.add( mc);
			}
			model.addAttribute("mc_list", mc_list);
		}
		catch(Exception e) {
			
		}
		
		// 페이징 처리를 위한 pageInfo
		PageInfoVO pageInfo = new PageInfoVO();
		//페이지 정보 현황 초기화
		pageInfo.setEndPage(1); // 여기선 필요 x
		pageInfo.setListCount(0); // 항목의 총 갯수
		pageInfo.setPageListLimit(JUNG_PRODUCT_LIMIT); // 항목수 제한
		
		// 페이지 로드 된 뒤에 ajax로 값을 받아올때 해당 값에 +1을 시켜줌으로 -1로 초기값 지정
		pageInfo.setStartPage(-1);   // 현재 페이지 값 sql limit 문의 시작 번호는 배열처럼 0 이 시작
		pageInfo.setMaxPage(8); // 마지막 페이지
		
		// 중고 물품 총 갯수 구해서 페이지 최대 갯수 설정
		pageInfo.setListCount(jProductService.getMaxJungProduct(jproduct));
		pageInfo.setMaxPage((pageInfo.getListCount() / pageInfo.getPageListLimit()) + 1);
		
		JSONObject jo = new JSONObject();
		jHandler.pageInfo2JsonObj(jo, pageInfo);
		jo.put("lc_code", (String)map.get("lc_code"));
		jo.put("mc_code", (String)map.get("mc_code"));
		
		model.addAttribute("jsonObj",jo);
		
		return "/junggo/junggo_product_search";
	}
	
	
	@PostMapping("JungChat")
	public String jungChat(@RequestParam String product_idx, Model model
			,RedirectAttributes redirectAttributes) {
		
		// 로그인 되어있는지 확인하기
		try {			
			Authentication auth = SecurityContextHolder.getContext().getAuthentication();
			PrincipalDetails mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();
		}
		catch(Exception e) {
			// 로그인 안되어있으면 로그인 화면으로 되돌려 보내기
			model.addAttribute("msg","권한이 없습니다 ! 로그인 해주세요");
			model.addAttribute("targetURL","login"); // 로그인 페이지 넘어갈 때 리다이렉트 할수있는거 있어야 될듯?
			return "inc/fail_forward";
		}
		
		// product_idx 는 무조건 받아와야함
		if(product_idx == null) {
			model.addAttribute("msg", "올바르지 않는 값입니다 다시 시도해주세요 !");
			return "inc/fail_back";
		}
		
		// redirectAttributes : redirect 할때 파라미터값을 넘겨주게 하는 객체
		// product_idx , chat_room_area 담아서 보내기
		redirectAttributes.addAttribute("product_idx",product_idx);
		// chat_room_area 중고 물품은 값 0 이 들어가야함!
		redirectAttributes.addAttribute("chat_room_area",0);
		
		// makeChatRoom 으로 넘어가기
		return "redirect:makeChatRoom";
	}
	@GetMapping("JunggoPay")
	public String junggoPay(@RequestParam Map<String,Object> map, Model model) {
		return "";
	}
	@GetMapping("JunggoResults")
	public String junggoResults(@RequestParam Map<String,Object> map, Model model) {
		return "";
	}
	
	
	//========================= ajax ========================
	
	// 중고 페이지 열었을때 처음 셋팅값들을 ajax로 보내주는 코드
	@ResponseBody
	@RequestMapping(
			value = "junggoSearchInit.ajax",
			method = RequestMethod.POST,
			produces = "application/text; charset=UTF-8"
	)	
	public String junggoSearchInit(
			@RequestParam Map<String,Object> map) {
		
		JungProductVO jproduct = new JungProductVO();
		
		if(map.get("lc_code") != null) {
			jproduct.setLc_code(Integer.parseInt(((String)map.get("lc_code")).trim()));			
		}
		if(map.get("mc_code") != null) {
			jproduct.setMc_code(Integer.parseInt(((String)map.get("mc_code")).trim()));			
		}
	
		// 페이징 처리를 위한 pageInfo
		PageInfoVO pageInfo = new PageInfoVO();
		//페이지 정보 현황 초기화
		pageInfo.setEndPage(1); // 여기선 필요 x
		pageInfo.setListCount(0); // 항목의 총 갯수
		pageInfo.setPageListLimit(JUNG_PRODUCT_LIMIT); // 항목수 제한
		
		// 페이지 로드 된 뒤에 ajax로 값을 받아올때 해당 값에 +1을 시켜줌으로 -1로 초기값 지정
		pageInfo.setStartPage(-1);   // 현재 페이지 값 sql limit 문의 시작 번호는 배열처럼 0 이 시작
		pageInfo.setMaxPage(8); // 마지막 페이지
		
		// 중고 물품 총 갯수 구해서 페이지 최대 갯수 설정
		pageInfo.setListCount(jProductService.getMaxJungProduct(jproduct));
		pageInfo.setMaxPage((pageInfo.getListCount() / pageInfo.getPageListLimit()) + 1);
		
		JSONObject jo = new JSONObject();
		jHandler.pageInfo2JsonObj(jo, pageInfo);
		jo.put("lc_code", (String)map.get("lc_code"));
		jo.put("mc_code", (String)map.get("mc_code"));
		
		// 정렬 메소드 가져오기
		jo.put("orderMethod", (String)map.get("orderMethod"));
		
		// PageInfoVO 를 json 형태로 넣어주기
		jHandler.pageInfo2JsonObj(jo, pageInfo);
		
		return jo.toString();
	}
	// 중고 리스트 받기 ajax
	@ResponseBody
	@RequestMapping(
			value = "jungProductList.ajax",
			method = RequestMethod.POST,
			produces = "application/text; charset=UTF-8"
			)	
	public String getJproduct(
			@RequestParam Map<String,Object> map) {
		
		//JSON 데이터 형태로 담는 객체
		JSONObject jsonObj = new JSONObject();	
		JungProductVO jproduct = new JungProductVO();
		String orderMethod = (String)map.get("orderMethod");
		System.out.println("getJproduct : map :" + map);
		
		// 카테고리 들고오기
		if(map.get("lc_code") != null) {
			jproduct.setLc_code(Integer.parseInt(((String)map.get("lc_code")).trim()));			
		}
		if(map.get("mc_code") != null) {
			jproduct.setMc_code(Integer.parseInt(((String)map.get("mc_code")).trim()));			
		}
		
		//정렬 기준 들고오기
		// null 이거나 비어있으면 기본 설정(최신순) 으로
		
		if(orderMethod == null || orderMethod.equals("")) {
			orderMethod = "newest";
		}
		
		// 페이징 처리를 위한 pageInfo		
		PageInfoVO pageInfo = new PageInfoVO();
		try {
			jHandler.jsonMap2PageInfo(map, pageInfo);
		}catch(Exception e){
			logger.error("error getJproduct - jsonMap2PageInfo : map pageInfo param is null");
			return null;
		}
		
		// 중고 물품 총 갯수 구해서 페이지 최대 갯수 설정
		pageInfo.setPageListLimit(JUNG_PRODUCT_LIMIT);
		pageInfo.setListCount(jProductService.getMaxJungProduct(jproduct));
		pageInfo.setMaxPage((pageInfo.getListCount() / pageInfo.getPageListLimit()) + 1);
				
		
		if(pageInfo.getStartPage() <= pageInfo.getMaxPage()) {
			pageInfo.setStartPage(pageInfo.getStartPage() + 1);
		}else {
			return null;
		}
		
		// 조건에 맞는 중고 리스트 가져오기
		
		// 리스트 받아올 객체 초기화
		List<JungProductVO> jungList = null;
		//에러처리
		try {			
			jungList = jProductService.getJungProductList(jproduct, pageInfo, orderMethod);
			map.put("jungList", jungList);
		}
		catch(Exception e){
			return null;
		}
		
		// html 형태의 중고상품 리스트 담기
		JSONArray joJungList = new JSONArray();
		
		jungList.forEach((e) -> {
			joJungList.put(jungHandler.makeProductHtml(e));
		});
		// for 문 활용하여 jsonObj에 값 넣어주기
			
		for(Map.Entry<String,Object> et : map.entrySet()) {
			String key = et.getKey();
			Object value = et.getValue();
			jsonObj.put(key, value);
		}		
		
		// PageInfoVO 를 json 형태로 넣어주기
		jHandler.pageInfo2JsonObj(jsonObj, pageInfo);
		// html 형태의 중고상품 리스트 json 객체에 넣기
		jsonObj.put("jungListHtml",joJungList);
		
		return jsonObj.toString();
		
	}

	
	
	
	//========================================================================================
	//==================================노용석================================================
	
	//------------------- 물건 등록 폼 이동---------------------
	//주소창에 RegisterForm
	
	//------------------ 물건 등록 프로 ---------------------------
	@PostMapping("registProductPro")
	public String writePro(JungGoNohVO jungGoNoh, HttpSession session, Model model, HttpServletRequest request) {


		//String sId = "admin";
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		PrincipalDetails mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();
		int mem_idx = mPrincipalDetails.getMember().getMem_idx();
		jungGoNoh.setMem_idx(mem_idx);
	//	String sId = (String)session.getAttribute("sId");
//		if(sId == null) {
//			model.addAttribute("msg", "잘못된 접근입니다!");
//			return "fail_back";
//		}
		
	//System.out.println(jungGoNoh);
		
		// 이클립스 프로젝트 상에 업로드 폴더(upload) 생성 필요 
		// => 주의! 외부에서 접근하도록 하려면 resources 폴더 내에 upload 폴더 생성
		// 이클립스가 관리하는 프로젝스 상의 가상 업로드 경로에 대한 실제 업로드 경로 알아내기
		// => request.getRealPath() 대신 request.getServletContext.getRealPath() 메서드 또는
		//    세션 객체를 활용한 session.getServletContext().getRealPath() 메서드 사용
//		System.out.println(request.getRealPath("/resources/upload")); // Deprecated 처리된 메서드
		String uploadDir = "/resources/upload"; 
//		String saveDir = request.getServletContext().getRealPath(uploadDir); // 사용 가능
		String saveDir = session.getServletContext().getRealPath(uploadDir);
//		System.out.println("실제 업로드 경로 : "+ saveDir);
		// 실제 업로드 경로 : C:\STS4\workspace\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\ShoeCREAM\resources/upload/날짜

		String subDir = ""; // 서브디렉토리(날짜 구분)
		
		try {
			// ------------------------------------------------------------------------------
			// 업로드 디렉토리를 날짜별 디렉토리로 자동 분류하기
			// => 하나의 디렉토리에 너무 많은 파일이 존재하면 로딩 시간 길어지며 관리도 불편
			// => 따라서, 날짜별 디렉토리 구별 위해 java.util.Date 클래스 활용
			// 1. Date 객체 생성(기본 생성자 호출하여 시스템 날짜 정보 활용)
			Date date = new Date(); // Mon Jun 19 11:26:52 KST 2023
//		System.out.println(date);
			// 2. SimpleDateFormat 클래스를 활용하여 날짜 형식을 "yyyy/MM/dd" 로 지정
			// => 디렉토리 구조로 바로 활용하기 위해 날짜 구분 기호를 슬래시(/)로 지정
			// => 디렉토리 구분자를 가장 정확히 표현하려면 File.pathSeperator 또는 File.seperator 상수 활용
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
			// 3. 기존 업로드 경로에 날짜 경로 결합하여 저장
			subDir = sdf.format(date);
			saveDir += "/" + subDir;
			// --------------------------------------------------------------
			// java.nio.file.Paths 클래스의 get() 메서드를 호출하여
			// 실제 경로를 관리하는 java.nio.file.Path 타입 객체 리턴받기
			// => 파라미터 : 실제 업로드 경로
			Path path = Paths.get(saveDir);
			
			// Files 클래스의 createDirectories() 메서드를 호출하여
			// Path 객체가 관리하는 경로 생성(존재하지 않으면 거쳐가는 경로들 중 없는 경로 모두 생성)
			Files.createDirectories(path);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		// JungGoNohVO 객체에 전달된 MultipartFile 객체 꺼내기
		MultipartFile mFile1 = jungGoNoh.getFile1();
		MultipartFile mFile2 = jungGoNoh.getFile2();
		MultipartFile mFile3 = jungGoNoh.getFile3();
		MultipartFile mFile4 = jungGoNoh.getFile4();

		String filename1 = mFile1.getOriginalFilename();
		String filename2 = mFile2.getOriginalFilename();
		String filename3 = mFile3.getOriginalFilename();
		String filename4 = mFile4.getOriginalFilename();
		String fileext1 = filename1.substring(filename1.lastIndexOf(".") + 1);
		String fileext2 = filename2.substring(filename2.lastIndexOf(".") + 1);
		String fileext3 = filename3.substring(filename3.lastIndexOf(".") + 1);
		String fileext4 = filename4.substring(filename3.lastIndexOf(".") + 1);
		
		if((fileext1 == null || fileext1.length() == 0))
		{	
		}
		else
		{	
			if(fileext1.equals("png") || fileext1.equals("jpg") || fileext1.equals("jpeg"))
			{
			}
			else 
			{
				model.addAttribute("msg", "첫번째 파일 업로드는 이미지만 업로드 가능합니다.");
				return "inc/fail_back";
			}
		}
		
		if((fileext2 == null || fileext2.length() == 0))
		{	
		}
		else
		{	
			if(fileext2.equals("png") || fileext2.equals("jpg") || fileext2.equals("jpeg"))
			{
			}
			else 
			{
				model.addAttribute("msg", "두번째 파일 업로드는 이미지만 업로드 가능합니다.");
				return "inc/fail_back";
			}
		}
		
		if((fileext3 == null || fileext3.length() == 0))
		{	
		}
		else
		{	
			if(fileext3.equals("png") || fileext3.equals("jpg") || fileext3.equals("jpeg"))
			{
			}
			else 
			{
				model.addAttribute("msg", "세번째 파일 업로드는 이미지만 업로드 가능합니다.");
				return "inc/fail_back";
			}
		}
		
		if((fileext4 == null || fileext4.length() == 0))
		{	
		}
		else
		{	
			if(fileext4.equals("png") || fileext4.equals("jpg") || fileext3.equals("jpeg"))
			{
			}
			else 
			{
				model.addAttribute("msg", "세번째 파일 업로드는 이미지만 업로드 가능합니다.");
				return "inc/fail_back";
			}
		}
		
		
		// 파일명 중복 방지를 위한 대첵
		// 현재 시스템(서버)에서 랜덤ID 값을 추출하여 파일명 앞에 붙여서
		// "랜덤ID값_파일명.확장자" 형식으로 중복 파일명 처리
		// => 랜덤ID 생성은 java.util.UUID 클래스 활용(UUID = 범용 고유 식별자)
		String uuid = UUID.randomUUID().toString();
//		System.out.println("uuid : " + uuid);
		
		// 생성된 UUID 값을 원본 파일명 앞에 결합(파일명과 구분을 위해 _ 기호 추가)
		// => 나중에 사용자 다운로드 시 원본 파일명 표시를 위해 분리할 때 구분자로 사용
		//    (가장 먼저 만나는 _ 기호를 기준으로 문자열 분리하여 처리)
		// => 단, 파일명 길이 조절을 위해 임의로 UUID 중 맨 앞자리 8자리 문자열만 활용
//		System.out.println(uuid.substring(0, 8));
		// 생성된 UUID 값(8자리 추출)과 업로드 파일명을 결합하여 JungGoNohVO 객체에 저장(구분자로 _ 기호 추가)
		// => 단, 파일명이 존재하는 경우에만 파일명 생성(없을 경우를 대비하여 기본 파일명 널스트링으로 처리)
		jungGoNoh.setImage1("");
		jungGoNoh.setImage2("");
		jungGoNoh.setImage3("");
		jungGoNoh.setImage4("");
		
		// 파일명을 저장할 변수 선언
		String fileName1 = uuid.substring(0, 8) + "_" + mFile1.getOriginalFilename();
		String fileName2 = uuid.substring(0, 8) + "_" + mFile2.getOriginalFilename();
		String fileName3 = uuid.substring(0, 8) + "_" + mFile3.getOriginalFilename();
		String fileName4 = uuid.substring(0, 8) + "_" + mFile4.getOriginalFilename();
		
		if(!mFile1.getOriginalFilename().equals("")) {
			jungGoNoh.setImage1(subDir + "/" + fileName1);
		}
		
		if(!mFile2.getOriginalFilename().equals("")) {
			jungGoNoh.setImage2(subDir + "/" + fileName2);
		}
		
		if(!mFile3.getOriginalFilename().equals("")) {
			jungGoNoh.setImage3(subDir + "/" + fileName3);
		}
		
		if(!mFile4.getOriginalFilename().equals("")) {
			jungGoNoh.setImage4(subDir + "/" + fileName4);
		}
		System.out.println("실제 업로드 파일명1 : " + jungGoNoh.getImage1());
		System.out.println("실제 업로드 파일명2 : " + jungGoNoh.getImage2());
		System.out.println("실제 업로드 파일명3 : " + jungGoNoh.getImage3());
		System.out.println("실제 업로드 파일명3 : " + jungGoNoh.getImage4());
	
	
		// -----------------------------필터링-------------------------------------------
		String product_info = jungGoNoh.getProduct_info();
		
		String trashArr[] = jungGoNoh.getTrashArr();

		int len = trashArr.length;   
		System.out.println("=====================trashArr.length"+trashArr.length);
		
		int i=0;
		for (i=0;i<=len-1;i++)
		{
			product_info = product_info.replaceAll(trashArr[i], "*");
		}
		jungGoNoh.setProduct_info(product_info);
		System.out.println("==========================================product_info" + product_info);
		
		// BoardService - registBoard() 메서드를 호출하여 게시물 등록 작업 요청
		// => 파라미터 : JungGoNohVO 객체    리턴타입 : int(insertCount)
	
		int session_idx = 1;
		//int session_idx = chatService.getSIdIdx(sId);
		jungGoNoh.setMem_idx(session_idx);
		LocalDateTime localDateTime = LocalDateTime.now(); // 시스템의 현재 날짜 및 시각 정보 리턴
		
		// java.time.DateTimeFormatter 클래스를 활용하여 포맷 변경
		DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyyMMddHHmmss");
		
		
		jungGoNoh.setProduct_idx(Integer.toString(session_idx) + localDateTime.format(dateTimeFormatter));
		
		
		int insertProductImage = jungGoNohService.registProductImage(jungGoNoh);
		int insertCountJung = jungGoNohService.registJungProduct(jungGoNoh);
		
		String product_idx = jungGoNoh.getProduct_idx();
		
		
		// 게시물 등록 작업 요청 결과 판별
		// => 성공 시 업로드 파일을 실제 디렉토리에 이동시킨 후 BoardList 서블릿 리다이렉트
		// => 실패 시 "글 쓰기 실패!" 메세지 출력 후 이전페이지 돌아가기 처리
		if(insertCountJung > 0) { // 성공
			try {
				// 업로드 된 파일은 MultipartFile 객체에 의해 임시 디렉토리에 저장되어 있으며
				// 글쓰기 작업 성공 시 임시 디렉토리 -> 실제 디렉토리로 이동 작업 필요
				// MultipartFile 객체의 transferTo() 메서드를 호출하여 실제 위치로 이동(업로드)
				// => 비어있는 파일은 이동할 수 없으므로(= 예외 발생) 제외
				// => File 객체 생성 시 지정한 디렉토리에 지정한 이름으로 파일이 이동(생성)됨
				//    따라서, 이동할 위치의 파일명도 UUID 가 결합된 파일명을 지정해야한다!
				if(!mFile1.getOriginalFilename().equals("")) {
					mFile1.transferTo(new File(saveDir, fileName1));
				}
				
				if(!mFile2.getOriginalFilename().equals("")) {
					mFile2.transferTo(new File(saveDir, fileName2));
				}
				
				if(!mFile3.getOriginalFilename().equals("")) {
					mFile3.transferTo(new File(saveDir, fileName3));
				}
				
				if(!mFile4.getOriginalFilename().equals("")) {
					mFile4.transferTo(new File(saveDir, fileName4));
				}
				
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
			
			// 글쓰기 작업 성공 시 글목록(BoardList)으로 리다이렉트
			return "redirect:/productDetail?product_idx="+product_idx;
		} else { // 실패
			model.addAttribute("msg", "글 쓰기 실패!");
			return "inc/fail_back";
		}
		
	}
	
			
	
	//------------------ 물건 상세 안내 폼 이동---------------------
	@GetMapping("productDetail")
	public String productDetail(
		@RequestParam String product_idx, HttpSession session, Model model, JungGoNohVO jungGoNoh) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		PrincipalDetails mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();

		int buyier_idx = mPrincipalDetails.getMember().getMem_idx(); // 사는사람(접속 idx
		jungGoNoh.setBuyier_idx(buyier_idx);
		
		System.out.println("+++++++++++++++++++++++buyier_idx" + buyier_idx);
	
	
		JungGoNohVO product = jungGoNohService.getProduct(product_idx);
	
		System.out.println("+++++++++++++++++++++++jungGoNoh" + jungGoNoh);
		JungGoNohVO dibs = jungGoNohService.getDibs(jungGoNoh);
		
		int mem_idx = product.getMem_idx();
		System.out.println("+++++++++++++++++++++++mem_idx" + mem_idx);
		
		List<JungGoNohVO> moreProductListSmall =jungGoNohService.moreProductListSmall(mem_idx);
		
	
		// 상세정보 조회 결과 저장
		model.addAttribute("jungGoNoh", product);
		model.addAttribute("dibs", dibs);
		model.addAttribute("moreProductListSmall", moreProductListSmall);
	    return "junggo/product_detail";
	}

	//------------------ 찜 입력---------------------
	
	@PostMapping("dibsPro")
	public String dibsPro(JungGoNohVO jungGoNoh, HttpSession session, Model model, HttpServletRequest request) {
				
		String product_idx = jungGoNoh.getProduct_idx();
		int countReadCount =0;
		int countDibs = 0;
		if(jungGoNoh.getFavorite_check() =="Y" || jungGoNoh.getFavorite_check().equals("Y"))
		{
			countDibs = jungGoNohService.removeDibs(jungGoNoh);
			countReadCount =jungGoNohService.removeReadCount(jungGoNoh);
		}
		else
		{	
			countDibs = jungGoNohService.registDibs(jungGoNoh);
			countReadCount =jungGoNohService.removeReadCount(jungGoNoh);
		}
		
		// 게시물 등록 작업 요청 결과 판별
		// => 성공 시 업로드 파일을 실제 디렉토리에 이동시킨 후 BoardList 서블릿 리다이렉트
		// => 실패 시 "글 쓰기 실패!" 메세지 출력 후 이전페이지 돌아가기 처리
		if(countDibs > 0 && countReadCount > 0) 
		{ // 성공
			
			
			try {
				
				
			} 
			catch (IllegalStateException e) {
				e.printStackTrace();
			}
			
			// 글쓰기 작업 성공 시 글목록(BoardList)으로 리다이렉트
			return "redirect:/productDetail?product_idx="+product_idx; 
		} else { // 실패
			model.addAttribute("msg", "글 쓰기 실패!");
			return "inc/fail_back";
		}
		
		
	}
	
	
	//------------------ 물건 삭제 프로 -----------------------------
	
	@GetMapping("productDelete")
	public String delete(@RequestParam String product_idx, HttpSession session, Model model, JungGoNohVO jungGoNoh) {
		// 세션 아이디가 존재하지 않으면(미로그인) "잘못된 접근입니다!" 출력 후 이전 페이지 돌아가기 처리
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		PrincipalDetails mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();
		String sId = mPrincipalDetails.getMember().getMem_id();
		String mId = jungGoNoh.getMem_id();
		//String sId = (String)session.getAttribute("sId");
		if(sId == null && sId == mId) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			return "inc/fail_back";
		}
		
		// BoardService - isBoardWriter() 메서드 호출하여 작성자 판별 요청
		// => 파라미터 : 글번호, 세션아이디   리턴타입 : boolean(isBoardWriter)
		// => 단, 세션아이디가 "admin" 이 아닐 경우에만 수행
//		if(!sId.equals("admin")) {
//			boolean isProductWriter = jungGoNohService.isProductWriter(product_idx, sId);
//			
//			if(!isProductWriter) {
//				model.addAttribute("msg", "권한이 없습니다!");
//				return "inc/fail_back";
//			}
//		}
		
		// BoardService - removeBoard() 메서드 호출하여 글 삭제 요청
		// => 파라미터 : 글번호   리턴타입 : int(deleteCount)
		int deleteCount = jungGoNohService.removeProduct(product_idx);
		
		// 삭제 실패 시 "삭제 실패!" 처리 후 이전페이지 이동
		// 아니면, BoardList 서블릿 요청(파라미터 : 페이지번호)
		if(deleteCount == 0) {
			model.addAttribute("msg", "삭제 실패!");
			return "inc/fail_back";
		} 
		
		return "redirect:/JunggoSearch";
	}
	
	
	//------------------------- 예약취소 폼 이동---------------------
	@GetMapping("resCancel")
	public String resCancel() {
		return "junggo/res_cancel";
		
	}
	
	//------------------------- 예약완료 폼 이동---------------------
	@GetMapping("resComplete")
	public String resComplete() {
		return "junggo/res_complete";
		
	}
	
	//------------------------- 결제완료 폼 이동---------------------
	@GetMapping("payComplete")
	public String payComplete() {
		return "junggo/pay_complete";
			
	}
	
	//------------------------- 거래취소 폼 이동---------------------
	@GetMapping("tradeCancel")
	public String tradeCancel() {
		return "junggo/trade_cancel";
		
	}

	//------------------------- 거래완료 폼 이동---------------------
	@GetMapping("tradeComplete")
	public String resCancelCom() {
		return "junggo/trade_complete";
	}
	
	
	
}