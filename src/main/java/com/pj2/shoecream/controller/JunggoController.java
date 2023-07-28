package com.pj2.shoecream.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.pj2.shoecream.service.JungGoNohService;
import com.pj2.shoecream.vo.JungGoNohVO;


@Controller
public class JunggoController {
	
	@Autowired
	private JungGoNohService jungGoNohService;
	
	@GetMapping("JunggoSearch")
	public String junggoSearch(@RequestParam Map<String,Object> map, Model model) {
		return "/junggo/junggo_product_search";
	}
	@GetMapping("JungChat")
	public String jungChat(@RequestParam Map<String,Object> map, Model model) {
		return "";
	}
	@GetMapping("JunggoPay")
	public String junggoPay(@RequestParam Map<String,Object> map, Model model) {
		return "";
	}
	@GetMapping("JunggoResults")
	public String junggoResults(@RequestParam Map<String,Object> map, Model model) {
		return "";
	}
	
	
	
	
	//========================================================================================
	//==================================노용석================================================
	
	//------------------- 물건 등록 폼 이동---------------------
	//주소창에 RegisterForm
	
	//------------------ 물건 등록 프로 ---------------------------
	@PostMapping("registProductPro")
	public String writePro(JungGoNohVO jungGoNoh, HttpSession session, Model model, HttpServletRequest request) {
/*//		String sId = (String)session.getAttribute("sId");
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
		// 실제 업로드 경로 : D:\Shared\Spring\workspace_spring5\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Spring_MVC_Board\resources\ upload
		
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
//		System.out.println("원본파일명1 : " + mFile1.getOriginalFilename());
//		System.out.println("원본파일명2 : " + mFile2.getOriginalFilename());
//		System.out.println("원본파일명3 : " + mFile3.getOriginalFilename());
		
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
		jungGoNoh.setProduct_image1("");
		jungGoNoh.setProduct_image2("");
		jungGoNoh.setProduct_image3("");
		jungGoNoh.setProduct_image4("");
		
		// 파일명을 저장할 변수 선언
		String fileName1 = uuid.substring(0, 8) + "_" + mFile1.getOriginalFilename();
		String fileName2 = uuid.substring(0, 8) + "_" + mFile2.getOriginalFilename();
		String fileName3 = uuid.substring(0, 8) + "_" + mFile3.getOriginalFilename();
		String fileName4 = uuid.substring(0, 8) + "_" + mFile4.getOriginalFilename();
		
		if(!mFile1.getOriginalFilename().equals("")) {
			jungGoNoh.setProduct_image1(subDir + "/" + fileName1);
		}
		
		if(!mFile2.getOriginalFilename().equals("")) {
			jungGoNoh.setProduct_image2(subDir + "/" + fileName2);
		}
		
		if(!mFile3.getOriginalFilename().equals("")) {
			jungGoNoh.setProduct_image3(subDir + "/" + fileName3);
		}
		
		if(!mFile4.getOriginalFilename().equals("")) {
			jungGoNoh.setProduct_image4(subDir + "/" + fileName4);
		}
		System.out.println("실제 업로드 파일명1 : " + jungGoNoh.getProduct_image1());
		System.out.println("실제 업로드 파일명2 : " + jungGoNoh.getProduct_image2());
		System.out.println("실제 업로드 파일명3 : " + jungGoNoh.getProduct_image3());
		System.out.println("실제 업로드 파일명3 : " + jungGoNoh.getProduct_image4());
*/		
		// -----------------------------------------------------------------------------------
		// BoardService - registBoard() 메서드를 호출하여 게시물 등록 작업 요청
		// => 파라미터 : JungGoNohVO 객체    리턴타입 : int(insertCount)
	
		
		int insertCountJung = jungGoNohService.registJungProduct(jungGoNoh);
		
		
		
		
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
/*				if(!mFile1.getOriginalFilename().equals("")) {
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
*/				
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} /*catch (IOException e) {
				e.printStackTrace();
			}*/
			
			// 글쓰기 작업 성공 시 글목록(BoardList)으로 리다이렉트
			return "junggo/junggo_product_search";
		} else { // 실패
			model.addAttribute("msg", "글 쓰기 실패!");
			return "inc/fail_back";
		}
		
	}
	
	
	
	//------------------ 물건 상세 안내 폼 이동---------------------
	@GetMapping("productDetail")
	public String productDetail(
			@RequestParam int product_idx, HttpSession session, Model model) {
		
		JungGoNohVO jungGoNoh = jungGoNohService.getProduct(product_idx);
		
		// 상세정보 조회 결과 저장
		model.addAttribute("jungGoNoh", jungGoNoh);
		
	    return "junggo/product_detail";
	}

	
	//------------------ 물건 삭제 프로 -----------------------------
	
	@GetMapping("productDelete")
	public String delete(@RequestParam int product_idx, HttpSession session, Model model) {
		// 세션 아이디가 존재하지 않으면(미로그인) "잘못된 접근입니다!" 출력 후 이전 페이지 돌아가기 처리
		String sId = (String)session.getAttribute("sId");
		if(sId == null) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			return "inc/fail_back";
		}
		
		// BoardService - isBoardWriter() 메서드 호출하여 작성자 판별 요청
		// => 파라미터 : 글번호, 세션아이디   리턴타입 : boolean(isBoardWriter)
		// => 단, 세션아이디가 "admin" 이 아닐 경우에만 수행
		if(!sId.equals("admin")) {
			boolean isProductWriter = jungGoNohService.isProductWriter(product_idx, sId);
			
			if(!isProductWriter) {
				model.addAttribute("msg", "권한이 없습니다!");
				return "inc/fail_back";
			}
		}
		
		// BoardService - removeBoard() 메서드 호출하여 글 삭제 요청
		// => 파라미터 : 글번호   리턴타입 : int(deleteCount)
		int deleteCount = jungGoNohService.removeProduct(product_idx);
		
		// 삭제 실패 시 "삭제 실패!" 처리 후 이전페이지 이동
		// 아니면, BoardList 서블릿 요청(파라미터 : 페이지번호)
		if(deleteCount == 0) {
			model.addAttribute("msg", "삭제 실패!");
			return "inc/fail_back";
		} 
		
		return "";
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
