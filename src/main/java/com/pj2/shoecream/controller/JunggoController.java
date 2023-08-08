package com.pj2.shoecream.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.*;
import java.time.*;
import java.time.format.DateTimeFormatter;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.cassandra.CassandraProperties.Request;
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
import com.pj2.shoecream.service.MemberService;
import com.pj2.shoecream.vo.ChatRoomVO;
import com.pj2.shoecream.vo.JungGoNohVO;
import com.pj2.shoecream.vo.JungProductVO;
import com.pj2.shoecream.vo.LCategory;
import com.pj2.shoecream.vo.MemberVO;
import com.pj2.shoecream.vo.PageInfoVO;


@Controller
public class JunggoController {
	
	private static final Logger logger = LoggerFactory.getLogger(JunggoController.class);
	
	@Autowired
	private JungGoNohService jungGoNohService;
	
	@Autowired
	private MemberService memService;
	
	@Autowired
	private JungProductService jProductService;
	
	@Autowired
	private JsonHandler jHandler;

	@Autowired
	private JungHandler jungHandler;
	
	@Autowired
	private CategoryService cService;
	
	@Autowired
	private ChatService chatService;
	
	// 중고 항목 페이징 처리때 사용될 상수
	// 중고 리스트 불러올때 최대 리미트
	public static final int JUNG_PRODUCT_LIMIT = 20;
	
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
			List<Map<String, Object>> mc_list = cService.getMcList(0);
			model.addAttribute("mc_list",mc_list);
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
		return "redirect:makeJungChatRoom";
	}
	
	// payForm 사용시 필요한 파라미터
	/* 
	 * 중고 , 경매 또는 크림 중 하나 product_selector
	 * 
	 * 상품 번호 product_idx
	 * 상품 이름 product_title
	 * 상품 가격 product_price
	 * 상품 설명 product_info
	 * 
	 * 판매자 닉네임 mem_seller_nickname
	 * 판매자 유저 점수 mem_seller_rank
	 * 판매자 판매 횟수 mem_seller_sellCount
	 */
	@GetMapping("JunggoPay")
	public String junggoPay(@RequestParam Map<String,Object> map, Model model
			,RedirectAttributes redirectAttributes) {
		
		int idx = -1;
		MemberVO member = null;
		try {
			Authentication auth = SecurityContextHolder.getContext().getAuthentication();
			PrincipalDetails mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();
			

			// 구매자 회원번호
			idx = mPrincipalDetails.getMember().getMem_idx();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			System.out.println("error : JunggoPay");
			// 로그인 안되어있으면 로그인 화면으로 되돌려 보내기
			model.addAttribute("msg","권한이 없습니다 ! 로그인 해주세요");
			model.addAttribute("targetURL","login"); // 로그인 페이지 넘어갈 때 리다이렉트 할수있는거 있어야 될듯?
			return "inc/fail_forward";
		}
		// 현재 접속중 멤버 가져오기
		member = memService.getMemberByIdx(idx);
		
		Map<String,Object> productEx = jProductService.getJungProductExtend((String)map.get("product_idx"));
		String product_sell_status = (String)productEx.get("product_sell_status");
		String product_payment = (String)productEx.get("product_payment");
		// 현재 물품의 거래 상황과 예약중인 유저 체크
		if(productEx != null 
				&& (product_sell_status).equals("예약중")
				&& (product_payment.equals("안전페이") || product_payment.equals("안전페이,직거래"))
				&& (Integer)productEx.get("product_buyer_idx") == idx) {
			
			model.addAttribute("map",productEx);
			model.addAttribute("member",member);
			return "inc/pay/pay_form";
		} 
		// 만약 다른 거래 상황이면 ...
		else if(product_sell_status.equals("대기중")){
			model.addAttribute("msg","예약 진행중이 아닙니다 예약 진행 먼저 해주세요");
		}
		// 이미 자신이 아닌 다른 사람이 예약, 거래 중 이라면
		else if(product_sell_status.equals("예약중")
				|| product_sell_status.equals("거래대기중")){
			model.addAttribute("msg","다른 유저가 예약중에 있습니다!");
		}
		else if(product_sell_status.equals("거래완료")){
			model.addAttribute("msg","이미 거래가 완료된 상품입니다");
		}
		else {
			model.addAttribute("msg","잘못된 접근입니다");
		}
		return "inc/fail_back";
	}
	

	// 중고 거래 채팅에서 예약버튼을 눌렀을때
	@GetMapping("startRes")
	public String startRes(@RequestParam Map<String,Object> map, Model model
			,RedirectAttributes rttr) {
		
		// spring security 사용하여 idx 들고오기
		int idx = -1;

		try {
			Authentication auth = SecurityContextHolder.getContext().getAuthentication();
			PrincipalDetails mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();
			

			// 구매자 회원번호
			idx = mPrincipalDetails.getMember().getMem_idx();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			System.out.println("error : JunggoPay");
			// 로그인 안되어있으면 로그인 화면으로 되돌려 보내기
			model.addAttribute("msg","권한이 없습니다 ! 로그인 해주세요");
			model.addAttribute("targetURL","login"); // 로그인 페이지 넘어갈 때 리다이렉트 할수있는거 있어야 될듯?
			return "inc/fail_forward";
		}
		
		// 현재 채팅방 정보 가져오기
		Map<String,Object> chatRoom = chatService.getChatRoom(
				Integer.parseInt((String)map.get("chat_room_idx")),
				Integer.parseInt((String)map.get("chat_area"))
				);
		
		if(chatRoom == null) {
			model.addAttribute("msg","채팅방 불러오기가 실패하였습니다!");
			return "inc/fail_back";
		}
		
		// 중고 물품 정보 가져오기
		JungProductVO product = new JungProductVO();
		product.setProduct_idx((String)chatRoom.get("product_idx"));
		product = jProductService.getJungProduct(product);
		String product_sell_status = product.getProduct_sell_status();
		// 현재 물품의 거래 상황과 예약중인 유저 체크
		if(product != null 
				&& (product_sell_status).equals("대기중")) {
			
			if(jProductService.updateSellStatusNBuyerIdx((String)chatRoom.get("product_idx"), "예약중",idx) <= 0) {
				model.addAttribute("msg","상품 상태 업데이트에 실패하였습니다!");
				return "inc/fail_back";
			}
			
			rttr.addAttribute("chat_area",map.get("chat_area"));
			rttr.addAttribute("chat_room_idx",map.get("chat_room_idx"));
			return "redirect:chatRooms";
		} 
		// 이미 자신이 아닌 다른 사람이 예약, 거래 중 이라면
		else if(product_sell_status.equals("예약중")
				|| product_sell_status.equals("거래대기중")){
			model.addAttribute("msg","다른 유저가 예약중에 있습니다!");
		}
		else if(product_sell_status.equals("거래완료")){
			model.addAttribute("msg","이미 거래가 완료된 상품입니다");
		}
		else {
			model.addAttribute("msg","잘못된 접근입니다");
		}
		return "inc/fail_back";
	}
	
	// transForm 사용시 필요한 파라미터
	/* 
	 * 중고 , 경매 또는 크림 중 하나 product_selector
	 * 
	 * 상품 번호 product_idx
	 * 상품 이름 product_title
	 * 상품 가격 product_price
	 * 상품 설명 product_info
	 * 
	 * 판매자 닉네임 mem_seller_nickname
	 * 판매자 유저 점수 mem_seller_rank
	 * 판매자 판매 횟수 mem_seller_sellCount
	 */
	@GetMapping("transForm")
	public String transComplete(@RequestParam Map<String,Object> map, Model model
			,RedirectAttributes redirectAttributes) {
		
		int idx = -1;
		MemberVO member = null;
		try {
			Authentication auth = SecurityContextHolder.getContext().getAuthentication();
			PrincipalDetails mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();
			

			// 구매자 회원번호
			idx = mPrincipalDetails.getMember().getMem_idx();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			System.out.println("error : JunggoPay");
			// 로그인 안되어있으면 로그인 화면으로 되돌려 보내기
			model.addAttribute("msg","권한이 없습니다 ! 로그인 해주세요");
			model.addAttribute("targetURL","login"); // 로그인 페이지 넘어갈 때 리다이렉트 할수있는거 있어야 될듯?
			return "inc/fail_forward";
		}
		// 현재 접속중 멤버 가져오기
		member = memService.getMemberByIdx(idx);
		
		// 현재 채팅방 정보 가져오기
		Map<String,Object> chatRoom = chatService.getChatRoom(
				Integer.parseInt((String)map.get("chat_room_idx")),
				Integer.parseInt((String)map.get("chat_area"))
				);
		
		if(chatRoom == null) {
			model.addAttribute("msg","채팅방 불러오기가 실패하였습니다!");
			return "inc/fail_back";
		}
		
		
		Map<String,Object> productEx = jProductService.getJungProductExtend((String)chatRoom.get("product_idx"));
		String product_sell_status = (String)productEx.get("product_sell_status");
		String product_payment = (String)productEx.get("product_payment");
		// 현재 물품의 거래 상황과 예약중인 유저 체크
		if(productEx != null 
				&& (Integer)productEx.get("product_buyer_idx") == idx 
				&& (
						(product_sell_status.equals("예약중") && product_payment.equals("직거래"))
						|| (product_sell_status.equals("거래대기중") && 
								(product_payment.equals("안전페이") || product_payment.equals("안전페이,직거래"))
							)
					)	
			)
		{
			
			model.addAttribute("map",productEx);
			model.addAttribute("member",member);
			return "inc/pay/trans_form";
		} 
		// 만약 다른 거래 상황이면 ...
		else if(product_sell_status.equals("대기중")){
			model.addAttribute("msg","예약 진행중이 아닙니다 예약 진행 먼저 해주세요");
		}
		// 이미 자신이 아닌 다른 사람이 예약, 거래 중 이라면
		else if(product_sell_status.equals("예약중")
				|| product_sell_status.equals("거래대기중")){
			model.addAttribute("msg","다른 유저가 예약중에 있습니다!");
		}
		else if(product_sell_status.equals("거래완료")){
			model.addAttribute("msg","이미 거래가 완료된 상품입니다");
		}
		else {
			model.addAttribute("msg","잘못된 접근입니다");
		}
		return "inc/fail_back";
	}
	
	// 거래 완료 진행
	@GetMapping("transComPro")
	public String transComPro(@RequestParam Map<String,Object> map, Model model
			,RedirectAttributes rttr) {
		int idx = -1;
		MemberVO member = null;
		try {
			Authentication auth = SecurityContextHolder.getContext().getAuthentication();
			PrincipalDetails mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();
			

			// 구매자 회원번호
			idx = mPrincipalDetails.getMember().getMem_idx();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			System.out.println("error : JunggoPay");
			// 로그인 안되어있으면 로그인 화면으로 되돌려 보내기
			model.addAttribute("msg","권한이 없습니다 ! 로그인 해주세요");
			model.addAttribute("targetURL","login"); // 로그인 페이지 넘어갈 때 리다이렉트 할수있는거 있어야 될듯?
			return "inc/fail_forward";
		}
		// 현재 접속중 멤버 가져오기
		member = memService.getMemberByIdx(idx);
		
		// 현재 채팅방 정보 가져오기
		Map<String,Object> chatRoom = chatService.getChatRoom(
				Integer.parseInt((String)map.get("chat_room_idx")),
				Integer.parseInt((String)map.get("chat_area"))
				);
		
		if(chatRoom == null) {
			model.addAttribute("msg","채팅방 불러오기가 실패하였습니다!");
			return "inc/fail_back";
		}
		
		
		Map<String,Object> productEx = jProductService.getJungProductExtend((String)chatRoom.get("product_idx"));
		String product_sell_status = (String)productEx.get("product_sell_status");
		String product_payment = (String)productEx.get("product_payment");
		// 현재 물품의 거래 상황과 예약중인 유저 체크
		if(productEx != null 
				&& (Integer)productEx.get("product_buyer_idx") == idx 
				&& (
						(product_sell_status.equals("예약중") && product_payment.equals("직거래"))
						|| (product_sell_status.equals("거래대기중") && 
								(product_payment.equals("안전페이") || product_payment.equals("안전페이,직거래"))
							)
					)	
			)
		{
			// 상품 상태 업데이트
			if(jProductService.updateSellStatus((String)chatRoom.get("product_idx"), "거래완료") <= 0) {
				model.addAttribute("msg","상품 상태 업데이트에 실패하였습니다!");
				return "inc/fail_back";
			}
			
			rttr.addAttribute("chat_room_idx",(String)map.get("chat_room_idx"));
			rttr.addAttribute("chat_area",(String)map.get("chat_area"));
			return "redirect:chatRooms";
		} 
		// 만약 다른 거래 상황이면 ...
		else if(product_sell_status.equals("대기중")){
			model.addAttribute("msg","예약 진행중이 아닙니다 예약 진행 먼저 해주세요");
		}
		// 이미 자신이 아닌 다른 사람이 예약, 거래 중 이라면
		else if(product_sell_status.equals("예약중")
				|| product_sell_status.equals("거래대기중")){
			model.addAttribute("msg","다른 유저가 예약중에 있습니다!");
		}
		else if(product_sell_status.equals("거래완료")){
			model.addAttribute("msg","이미 거래가 완료된 상품입니다");
		}
		else {
			model.addAttribute("msg","잘못된 접근입니다");
		}
		return "inc/fail_back";
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
		System.out.println("중고 물품 총 갯수 구해서 페이지 최대 갯수 설정");
		pageInfo.setPageListLimit(JUNG_PRODUCT_LIMIT);
		pageInfo.setListCount(jProductService.getMaxJungProduct(jproduct));
		pageInfo.setMaxPage((pageInfo.getListCount() / pageInfo.getPageListLimit()) + 1);
				
		
		if(pageInfo.getStartPage() <= pageInfo.getMaxPage()) {
			pageInfo.setStartPage(pageInfo.getStartPage() + 1);
		}else {
			return null;
		}
		
		// 조건에 맞는 중고 리스트 가져오기
		System.out.println("조건에 맞는 중고 리스트 가져오기");
		// 리스트 받아올 객체 초기화
		List<JungProductVO> jungList = null;
		//에러처리
		try {			
			jungList = jProductService.getJungProductList(jproduct, pageInfo, orderMethod);
			map.put("jungList", jungList);
		}
		catch(Exception e){
			e.printStackTrace();
			return null;
		}
		System.out.println(" html 형태의 중고상품 리스트 담기");
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
		System.out.println("PageInfoVO 를 json 형태로 넣어주기");
		// PageInfoVO 를 json 형태로 넣어주기
		jHandler.pageInfo2JsonObj(jsonObj, pageInfo);
		// html 형태의 중고상품 리스트 json 객체에 넣기
		jsonObj.put("jungListHtml",joJungList);
		System.out.println(jsonObj);
		return jsonObj.toString();
		
	}

	
	
	

	//========================================================================================
	//==================================노용석================================================
	
	//------------------- 물건 등록 폼 이동---------------------
	//주소창에 RegisterForm
	
	//------------------ 물건 등록 프로 ---------------------------
	@PostMapping("registProductPro")
	public String writePro(JungGoNohVO jungGoNoh, HttpSession session, Model model, HttpServletRequest request) {


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
		//접속중인 아이디 VO저장
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		PrincipalDetails mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();
		int mem_idx = mPrincipalDetails.getMember().getMem_idx();
		jungGoNoh.setMem_idx(mem_idx);
		
		
		// 파일관련=============================================================================================================================
		
		// 이클립스 프로젝트 상에 업로드 폴더(upload) 생성 필요 
		// => 주의! 외부에서 접근하도록 하려면 resources 폴더 내에 upload 폴더 생성
		// 이클립스가 관리하는 프로젝스 상의 가상 업로드 경로에 대한 실제 업로드 경로 알아내기
		// => request.getRealPath() 대신 request.getServletContext.getRealPath() 메서드 또는
		//    세션 객체를 활용한 session.getServletContext().getRealPath() 메서드 사용
//				System.out.println(request.getRealPath("/resources/upload")); // Deprecated 처리된 메서드
		String uploadDir = "/resources/upload"; 
//				String saveDir = request.getServletContext().getRealPath(uploadDir); // 사용 가능
		String saveDir = session.getServletContext().getRealPath(uploadDir);
//				System.out.println("실제 업로드 경로 : "+ saveDir);
		// 실제 업로드 경로 : C:\STS4\workspace\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\ShoeCREAM\resources/upload/날짜

		String subDir = ""; // 서브디렉토리(날짜 구분)
		
		try {
			// ------------------------------------------------------------------------------
			// 업로드 디렉토리를 날짜별 디렉토리로 자동 분류하기
			// => 하나의 디렉토리에 너무 많은 파일이 존재하면 로딩 시간 길어지며 관리도 불편
			// => 따라서, 날짜별 디렉토리 구별 위해 java.util.Date 클래스 활용
			// 1. Date 객체 생성(기본 생성자 호출하여 시스템 날짜 정보 활용)
			Date date = new Date(); // Mon Jun 19 11:26:52 KST 2023
//				System.out.println(date);
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
		
		//파일 확장명 제한
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
//				System.out.println("uuid : " + uuid);
		
		// 생성된 UUID 값을 원본 파일명 앞에 결합(파일명과 구분을 위해 _ 기호 추가)
		// => 나중에 사용자 다운로드 시 원본 파일명 표시를 위해 분리할 때 구분자로 사용
		//    (가장 먼저 만나는 _ 기호를 기준으로 문자열 분리하여 처리)
		// => 단, 파일명 길이 조절을 위해 임의로 UUID 중 맨 앞자리 8자리 문자열만 활용
//				System.out.println(uuid.substring(0, 8));
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
		
		//---------------------------------product_idx 생성---------------------------------------
	
		jungGoNoh.setMem_idx(mem_idx);
		LocalDateTime localDateTime = LocalDateTime.now(); // 시스템의 현재 날짜 및 시각 정보 리턴
		
		// java.time.DateTimeFormatter 클래스를 활용하여 포맷 변경
		DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyyMMddHHmmss");
		
		
		jungGoNoh.setProduct_idx(Integer.toString(mem_idx) + localDateTime.format(dateTimeFormatter));
		
		//---------------------------------product_idx 생성---------------------------------------
		//--------------------------------파일 및 물품 등록 작업 시작-----------------------------------------
		
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
	public String productDetail(@RequestParam String product_idx, HttpSession session, Model model, JungGoNohVO jungGoNoh) {

		try {	
				Authentication auth = SecurityContextHolder.getContext().getAuthentication();
				PrincipalDetails mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();
				int buyier_idx = mPrincipalDetails.getMember().getMem_idx(); // 사는 사람(접속아이디 idx 세팅)
				jungGoNoh.setBuyier_idx(buyier_idx);
			}
			catch(Exception e) {

			}
//				Authentication auth = SecurityContextHolder.getContext().getAuthentication();
//				PrincipalDetails mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();

		//int buyier_idx = mPrincipalDetails.getMember().getMem_idx(); // 사는사람(접속 idx
		//jungGoNoh.setBuyier_idx(buyier_idx);
		
		//상품 정보, 찜정보, 판매자 정보===========================================	
		JungGoNohVO product = jungGoNohService.getProduct(product_idx); //상품정보
	
		System.out.println("+++++++++++++++++++++++jungGoNoh" + jungGoNoh);
		JungGoNohVO dibs = jungGoNohService.getDibs(jungGoNoh); //찜정보
		//JungGoNohVO reports = jungGoNohService.getReports(jungGoNoh);
		
		int mem_idx = product.getMem_idx();
		System.out.println("+++++++++++++++++++++++mem_idx" + mem_idx); //더 많은 정보 가져올 판매자 idx 세팅
		
		//판매자 관련 리뷰, 상품 정보 더 가져오기=====================================================
		List<JungGoNohVO> moreProductListSmall =jungGoNohService.moreProductListSmall(mem_idx);
		
		List<JungGoNohVO> moreReviewListSmall =jungGoNohService.moreReviewListSmall(mem_idx);
		
		
		
		
		// 상세정보 조회 결과 저장
		model.addAttribute("jungGoNoh", product);
		model.addAttribute("dibs", dibs);
		model.addAttribute("moreProductListSmall", moreProductListSmall);
		model.addAttribute("moreReviewListSmall", moreReviewListSmall);
	    return "junggo/product_detail";
	}

	//------------------ 찜 입력--------------------------------------------------------------------------
	
	@PostMapping("dibsPro")
	public String dibsPro(JungGoNohVO jungGoNoh, HttpSession session, Model model, HttpServletRequest request) {

		try {			
			Authentication auth = SecurityContextHolder.getContext().getAuthentication();
			PrincipalDetails mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();
			int mem_idx = mPrincipalDetails.getMember().getMem_idx();
			jungGoNoh.setMem_idx(mem_idx);
		}
		catch(Exception e) {
			// 로그인 안되어있으면 로그인 화면으로 되돌려 보내기
			model.addAttribute("msg","권한이 없습니다 ! 로그인 해주세요");
			model.addAttribute("targetURL","login"); // 로그인 페이지 넘어갈 때 리다이렉트 할수있는거 있어야 될듯?
			return "inc/fail_forward";
		}
		
		//==================================찜 해제, 등록 구현=====================================================
		String product_idx = jungGoNoh.getProduct_idx();
		int countReadCount =0;
		int countDibs = 0;
		if(jungGoNoh.getFavorite_check() =="Y" || jungGoNoh.getFavorite_check().equals("Y"))
		{	//해제
			countDibs = jungGoNohService.removeDibs(jungGoNoh);
			countReadCount =jungGoNohService.removeReadCount(jungGoNoh);
		}
		else
		{	//등록
			countDibs = jungGoNohService.registDibs(jungGoNoh);
			countReadCount =jungGoNohService.removeReadCount(jungGoNoh);
		}
		
		//작업 요청 결과 판별
		if(countDibs > 0 && countReadCount > 0) 
		{ // 성공
			try {
					
			} 
			catch (IllegalStateException e) {
				e.printStackTrace();
			}
			
			// 글쓰기 작업 성공 시 리다이렉트
			return "redirect:/productDetail?product_idx="+product_idx; 
		} else { // 실패
			model.addAttribute("msg", "글 쓰기 실패!");
			return "inc/fail_back";
		}
		
		
	}
	
	
	//------------------ 물건 삭제 프로 -----------------------------
	
	@GetMapping("productDelete")
	public String delete(@RequestParam String product_idx, @RequestParam(value="mem_idx", required=false) String mem_idx, @RequestParam(value="buyier_idx", required=false) String buyier_idx, HttpSession session, Model model, JungGoNohVO jungGoNoh) {
	
		if(mem_idx == null) //작성자 정보 유무 확인
		{
			if(buyier_idx == null) //로그인 한 아이디 정보 유무 확인
			{
				model.addAttribute("msg", "로그인 해주세요!");
				return "inc/fail_back";
			}
			else
			{
				model.addAttribute("msg", "작성자와 삭제 신청자가 다릅니다!");
				return "inc/fail_back";
			}
		}
		else
		{
			if(mem_idx.equals(buyier_idx))// 작성자와 삭제 신청자 동일 시 삭제 시작
			{
				int deleteCount = jungGoNohService.removeProduct(product_idx);
				
				// 삭제 실패 시 "삭제 실패!" 처리 후 이전페이지 이동
				// 아니면, BoardList 서블릿 요청(파라미터 : 페이지번호)
				if(deleteCount == 0) {
					model.addAttribute("msg", "삭제 실패!");
					return "inc/fail_back";
				} 
				
				return "redirect:/JunggoSearch";
			}
			else
			{
				model.addAttribute("msg", "null");
				return "inc/fail_back";
			}
		}
		
		
		
	}
	
	
	
	
//------------------ 신고 등록이동 폼 ---------------------------
	@GetMapping("registReportForm")
	public String registReportForm(@RequestParam String product_idx, @RequestParam(value="mem_idx", required=false) String mem_idx, @RequestParam(value="buyier_idx", required=false) String buyier_idx, HttpSession session, Model model, JungGoNohVO jungGoNoh) {
		
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
			model.addAttribute("msg", "상품 정보가 없습니다. 해당 판매글에서 다시 시도해주세요 !");
			return "inc/fail_back";
		}
		// 필요한 값 세팅
		jungGoNoh.setMem_idx(Integer.parseInt(mem_idx));
		jungGoNoh.setBuyier_idx(Integer.parseInt(buyier_idx));
		jungGoNoh.setProduct_idx(product_idx);			
		
		// 신고 시 현재 게시글에 관한 정보 수집
		JungGoNohVO jungGoNohReport = jungGoNohService.getProduct(product_idx);
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		PrincipalDetails mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();
		String buyier_nickname = mPrincipalDetails.getMember().getMem_nickname();
		jungGoNohReport.setBuyier_nickname(buyier_nickname);
		model.addAttribute("jungGoNohReport", jungGoNohReport);
		
		return "junggo/junggo_report_register";
		
	}
	//------------------------- 신고 등록프로---------------------
	@PostMapping("registReportPro")
	public String registReportPro(@RequestParam String product_idx, @RequestParam(value="mem_idx", required=false) String mem_idx, @RequestParam(value="buyier_idx", required=false) String buyier_idx, 
			JungGoNohVO jungGoNoh, HttpSession session, Model model, HttpServletRequest request) {
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
		// 신고 신청자 idx 가져옴
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		PrincipalDetails mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();
		int reporter_idx = mPrincipalDetails.getMember().getMem_idx();
		int subject_idx = Integer.parseInt(mem_idx);
		
		if(subject_idx == reporter_idx) {
			model.addAttribute("msg", "신고대상자 아이디와 신고 신청자 아이디가 동일합니다");
			return "inc/close";
		}

		//필요한 기초정보 불러올 idx 세팅
		jungGoNoh.setBuyier_idx(reporter_idx);
		jungGoNoh.setProduct_idx(product_idx);
		jungGoNoh.setMem_idx(subject_idx);	
		//System.out.println("^^^^^^^^^^^^^^^^^^^^^^^^^^"+jungGoNoh);
		
		//입력 전 중복신청 사항이 있는지 조회
		String ifReport = jungGoNohService.getReport(jungGoNoh);
		model.addAttribute("ifReport",ifReport);
		//System.out.println("&&&&&&&&&&jungGoNoh?"+jungGoNoh);
		//System.out.println("&&&&&&&&&&ifReport?"+ifReport+"끝");
		if(ifReport == null) { //조회 내역이 없을 때
		
				//입력 작업 시작	
				int insertReport = jungGoNohService.registReport(jungGoNoh);
			
				if(insertReport < 0) {
						model.addAttribute("msg", "신청 실패");
						return "inc/fail_back";
						} 	
					} 
				else { //조회 내역이 있을때
						model.addAttribute("msg", "이미 해당 건에 대해 신고 신청하신 기록이 있습니다. 고객센터를 통해 1:1 문의를 넣어주세요.");
						return "inc/fail_back";
				}
		
		
		return "inc/close";
	}
	
	//--------------------신고 조회--------------------------
	
	@GetMapping("reportCountTable")
	public String reportCountTable(@RequestParam String product_idx, @RequestParam(value="mem_idx", required=false) String mem_idx, HttpSession session, Model model, JungGoNohVO jungGoNoh) {
		
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
			model.addAttribute("msg", "상품 정보가 없습니다. 해당 판매글에서 다시 시도해주세요 !");
			return "inc/fail_back";
		}
		
		//관련 idx 세팅
		jungGoNoh.setMem_idx(Integer.parseInt(mem_idx));
	
		jungGoNoh.setProduct_idx(product_idx);
		int idx1 = jungGoNoh.getMem_idx();
		String idx2 =jungGoNoh.getProduct_idx();
		System.out.println("#####################################################"+ idx1 + "@" + idx2);
		
		// 관련 신고사항 정보리스트 불러옴
		List<JungGoNohVO> moreReportListSmall =jungGoNohService.moreReportListSmall(jungGoNoh);
		JungGoNohVO product = jungGoNohService.getProduct(product_idx);
		
		
//				JungGoNohVO jungGoNohReport = jungGoNohService.getProduct(product_idx);
//				Authentication auth = SecurityContextHolder.getContext().getAuthentication();
//				PrincipalDetails mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();
//				String buyier_nickname = mPrincipalDetails.getMember().getMem_nickname();
//				jungGoNohReport.setBuyier_nickname(buyier_nickname);
//				model.addAttribute("jungGoNohReport", jungGoNohReport);
		model.addAttribute("moreReportListSmall", moreReportListSmall);
		model.addAttribute("jungGoNoh", product);
		return "junggo/junggo_report_table";
		
	}
	//-----------------------리뷰 작성 폼 이동-------------------------
	@GetMapping("registJReviewForm")
	public String registReviewForm(@RequestParam String product_idx, 
			@RequestParam(value="mem_idx", required=false) String mem_idx, 
			@RequestParam(value="buyier_idx", required=false) String buyier_idx, 
			HttpSession session, Model model, JungGoNohVO jungGoNoh){
		
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
			model.addAttribute("msg", "상품 정보가 없습니다. 해당 판매글에서 다시 시도해주세요 !");
			return "inc/fail_back";
		}
		
		
		//관련 idx 세팅
		jungGoNoh.setMem_idx(Integer.parseInt(mem_idx));
		jungGoNoh.setBuyier_idx(Integer.parseInt(buyier_idx));
		jungGoNoh.setProduct_idx(product_idx);			
		
		//리뷰 작성할 상품 정보 세팅
		JungGoNohVO jungGoNohReview = jungGoNohService.getProduct(product_idx);
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		PrincipalDetails mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();
		String buyier_nickname = mPrincipalDetails.getMember().getMem_nickname();
		jungGoNohReview.setBuyier_nickname(buyier_nickname);
		model.addAttribute("jungGoNohReview", jungGoNohReview);
		

		return "junggo/review_write_form";
	}
	
	//-----------------------리뷰 작성----------------------------------
		@PostMapping("registJReviewPro")
		public String registJReviewPro(@RequestParam String product_idx, @RequestParam(value="mem_idx", required=false) String mem_idx, @RequestParam(value="buyier_idx", required=false) String buyier_idx, 
				JungGoNohVO jungGoNoh, HttpSession session, Model model, HttpServletRequest request) {
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
			
			//리뷰 작성자 idx 세팅
			Authentication auth = SecurityContextHolder.getContext().getAuthentication();
			PrincipalDetails mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();
			int writer_idx = mPrincipalDetails.getMember().getMem_idx();
			int subject_idx = Integer.parseInt(mem_idx);
			
			if(subject_idx == writer_idx) {
				model.addAttribute("msg", "리뷰대상자 아이디와 리뷰작성자 아이디가 동일합니다");
				return "inc/close";
			}
			
			//필요 idx 세팅
			jungGoNoh.setBuyier_idx(writer_idx);
			jungGoNoh.setProduct_idx(product_idx);
			jungGoNoh.setMem_idx(subject_idx);	
			System.out.println("^^^^^^^^^^^^^^^^^^^^^^^^^^"+jungGoNoh);
			
			// 별점 미입력시 재입력하도록
			int review_star = jungGoNoh.getReview_star();
			
			if(review_star == 0) {
				model.addAttribute("msg", "별점을 입력해주세요");
				return "inc/fail_back";
			} 			
			
			//입력 전 동일 건에 대한 리뷰 중복 조회
			String ifReview = jungGoNohService.getReview(jungGoNoh);
			model.addAttribute("ifReview",ifReview);
			System.out.println("&&&&&&&&&&jungGoNoh?"+jungGoNoh);
			System.out.println("&&&&&&&&&&ifReview?"+ifReview+"끝");
			if(ifReview == null) { //조회 내역이 없을 때
			
					//입력 작업 시작	
					int insertReview = jungGoNohService.registReview(jungGoNoh);
				
					if(insertReview < 0) {
							model.addAttribute("msg", "신청 실패");
							return "inc/fail_back";
						} 	
				
				}  else 
					{ //조회 내역이 있을때
					
							model.addAttribute("msg", "이미 해당 건에 대해 리뷰작성 기록이 있습니다. 고객센터를 통해 1:1 문의를 넣어주세요.");
							return "inc/fail_back";
					}

			
			return "inc/close";
		}
	
	
	//-------------------------- 리뷰 수정 폼 이동-------------------
	
		@GetMapping("modifyJReviewForm")
		//public String modifyReviewForm(@RequestParam String product_idx, @RequestParam(value="mem_idx", required=false) String mem_idx, @RequestParam(value="buyier_idx", required=false) String buyier_idx, HttpSession session, Model model, JungGoNohVO jungGoNoh){
		public String modifyReviewForm(@RequestParam String product_idx, @RequestParam String mem_idx, @RequestParam String buyier_idx, HttpSession session, Model model, JungGoNohVO jungGoNoh){
			
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
				model.addAttribute("msg", "상품 정보가 없습니다. 해당 판매글에서 다시 시도해주세요 !");
				return "inc/fail_back";
			}
			
			//관련 idx 세팅
			jungGoNoh.setMem_idx(Integer.parseInt(mem_idx));
			jungGoNoh.setBuyier_idx(Integer.parseInt(buyier_idx));
			jungGoNoh.setProduct_idx(product_idx);			
			
			
			
			//수정할 리뷰 데이터 수집
			JungGoNohVO jungGoNohReview = jungGoNohService.getReview2(jungGoNoh);
			Authentication auth = SecurityContextHolder.getContext().getAuthentication();
			PrincipalDetails mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();
			String buyier_nickname = mPrincipalDetails.getMember().getMem_nickname();
			jungGoNohReview.setBuyier_nickname(buyier_nickname);
			
			System.out.println("XXXXXXXXXXXXXXXX"+jungGoNohReview);
			
			model.addAttribute("jungGoNohReview", jungGoNohReview);
			
			return "junggo/review_modify_form";
		}
		
		
		
		
	//-------------------------리뷰 수정-----------------------------
		
		@PostMapping("modifyReviewPro")
		public String modifyReviewPro(@RequestParam String product_idx, @RequestParam(value="mem_idx", required=false) String mem_idx, @RequestParam(value="buyier_idx", required=false) String buyier_idx, 
				JungGoNohVO jungGoNoh, HttpSession session, Model model, HttpServletRequest request) {
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
			Authentication auth = SecurityContextHolder.getContext().getAuthentication();
			PrincipalDetails mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();
			int writer_idx = mPrincipalDetails.getMember().getMem_idx();

			jungGoNoh.setBuyier_idx(writer_idx);
			jungGoNoh.setProduct_idx(product_idx);
			jungGoNoh.setMem_idx(Integer.parseInt(mem_idx));	
			System.out.println("^^^^^^^^^^^^^^^^^^^^^^^^^^"+jungGoNoh);
			
			//별점 미입력시 재입력
			int review_star = jungGoNoh.getReview_star();
			
			if(review_star == 0) {
				model.addAttribute("msg", "별점을 입력해주세요");
				return "inc/fail_back";
			} 			
			// 기간 설정을 위한 현재 시간 저장
	        LocalDate now = LocalDate.now();
	        // 포맷 정의
	        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy/MM/dd");
	        
	        // 포맷 적용
	        String formatedNow = now.format(formatter);
	        System.out.println("formatedNow!!!!!!!!!!!!!!!!!!"+formatedNow);
			java.sql.Timestamp review_date = jungGoNoh.getReview_date();
			String reviewDateFormat = new SimpleDateFormat("yyyy/MM/dd").format(review_date);
			System.out.println("reviewDateFormat!!!!!!!!!!!!!!!!!!"+reviewDateFormat);
	        SimpleDateFormat format = new SimpleDateFormat("yyyy/MM/dd");
	        
	        //날짜 차이 구하기
	        try {
				Date a_parseDate = format.parse(formatedNow);
				Date b_parseDate = format.parse(reviewDateFormat);
				
				System.out.println("a_parseDate!!!!!!!!!!!!!!!!!!" + a_parseDate);
				System.out.println("b_parseDate!!!!!!!!!!!!!!!!!!" + b_parseDate);
				System.out.println("a_parseDate.getTime()!!!!!!!!!!!!!!!!!!" + a_parseDate.getTime());
				System.out.println("b_parseDate.getTime()!!!!!!!!!!!!!!!!!!" + b_parseDate.getTime());
				
				long resultTime = b_parseDate.getTime() - a_parseDate.getTime();
				
				System.out.println("resultTime !!!!!!!!!!!!!!!!!!: "+resultTime);
				
				System.out.println("초 : "+resultTime/1000);
				System.out.println("분 : "+resultTime/(60*1000));
				System.out.println("시 : "+resultTime/(60*60*1000));
				System.out.println("일 : "+resultTime/(24*60*60*1000));
				
				long resultTimeDay = resultTime/(24*60*60*1000);
			
				// 날짜 차이 계산 후 리뷰 수정	
				if(resultTimeDay < 3 )
				{ // 리뷰 수정
					int ModifySuccess = jungGoNohService.modifyReview(jungGoNoh);
					
					if(ModifySuccess < 0) {
							model.addAttribute("msg", "수정 실패, 접속하신 아이디와 작성자가 다를 수 있으니 재확인 부탁드립니다.");
							return "inc/fail_back";
					} 	
				}
				else
				{
					model.addAttribute("msg", "리뷰 수정 기간(3일)이 경과하였습니다.");
					return "inc/fail_back";
				}
				
				
				
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			
			
					
			
			return "inc/close";
		}
		
		//-------------------------리뷰 삭제-----------------------------
		@GetMapping("reviewDelete")
		public String reviewDelete(@RequestParam String product_idx, @RequestParam(value="mem_idx", required=false) String mem_idx, @RequestParam(value="buyier_idx", required=false) String buyier_idx, HttpSession session, Model model, JungGoNohVO jungGoNoh) {
		
		
			int countReview = 0;
			countReview = jungGoNohService.deleteReview(jungGoNoh);
			
			
			if(countReview > 0) 
			{ // 성공
				
				// 글쓰기 작업 성공 시 글목록(BoardList)으로 리다이렉트
				return "redirect:/productDetail?product_idx="+product_idx; 
			} else { // 실패
				model.addAttribute("msg", "글 쓰기 실패!");
				return "inc/fail_back";
			}
		}
		
		

		
	
		
//		------------------------- 완료 뷰어 연습 이동---------------------
		@GetMapping("cancelOrComplete")
		public String cancelOrComplete(@RequestParam String product_idx, HttpSession session, Model model, JungGoNohVO jungGoNoh) {
			try {			
				Authentication auth = SecurityContextHolder.getContext().getAuthentication();
				PrincipalDetails mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();
				int buyier_idx = mPrincipalDetails.getMember().getMem_idx(); // 사는사람(접속 idx
				jungGoNoh.setBuyier_idx(buyier_idx);
			}
			catch(Exception e) {

			}
			
			JungGoNohVO payInfo = jungGoNohService.getPayInfo(product_idx);
			model.addAttribute("jungGoNoh", payInfo);
			
			return "junggo/cancel_complete";
			
		}
	
		
	//------------------------- 예약취소 폼 이동---------------------
		@GetMapping("resCancel")
		public String resCancel(@RequestParam String product_idx, HttpSession session, Model model, JungGoNohVO jungGoNoh) {
			try {			
				Authentication auth = SecurityContextHolder.getContext().getAuthentication();
				PrincipalDetails mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();
				int buyier_idx = mPrincipalDetails.getMember().getMem_idx(); // 사는사람(접속 idx
				jungGoNoh.setBuyier_idx(buyier_idx);
			}
			catch(Exception e) {

			}
			
			JungGoNohVO payInfo = jungGoNohService.getPayInfo(product_idx);
			model.addAttribute("jungGoNoh", payInfo);
			
			return "junggo/res_cancel";
			
		}
	
	//------------------------- 예약완료 폼 이동---------------------
		@GetMapping("resComplete")
		public String resComplete(@RequestParam String product_idx, HttpSession session, Model model, JungGoNohVO jungGoNoh) {
			try {			
				Authentication auth = SecurityContextHolder.getContext().getAuthentication();
				PrincipalDetails mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();
				int buyier_idx = mPrincipalDetails.getMember().getMem_idx(); // 사는사람(접속 idx
				jungGoNoh.setBuyier_idx(buyier_idx);
			}
			catch(Exception e) {

			}
			
			JungGoNohVO payInfo = jungGoNohService.getPayInfo(product_idx);
			model.addAttribute("jungGoNoh", payInfo);
			
			return "junggo/res_complete";
			
		}
	
		
	//------------------------- 결제취소 폼 이동---------------------
		@GetMapping("payCancel")
		public String payCancel(@RequestParam String product_idx, HttpSession session, Model model, JungGoNohVO jungGoNoh) {
			try {			
				Authentication auth = SecurityContextHolder.getContext().getAuthentication();
				PrincipalDetails mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();
				int buyier_idx = mPrincipalDetails.getMember().getMem_idx(); // 사는사람(접속 idx
				jungGoNoh.setBuyier_idx(buyier_idx);
			}
			catch(Exception e) {

			}
			
			JungGoNohVO payInfo = jungGoNohService.getPayInfo(product_idx);
			model.addAttribute("jungGoNoh", payInfo);
			
			return "junggo/pay_cancel";
			
			}
		
		
	//------------------------- 결제완료 폼 이동---------------------
		@GetMapping("payComplete")
		public String payComplete(@RequestParam String product_idx, HttpSession session, Model model, JungGoNohVO jungGoNoh) {
			try {			
				Authentication auth = SecurityContextHolder.getContext().getAuthentication();
				PrincipalDetails mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();
				int buyier_idx = mPrincipalDetails.getMember().getMem_idx(); // 사는사람(접속 idx
				jungGoNoh.setBuyier_idx(buyier_idx);
			}
			catch(Exception e) {

			}
			
			JungGoNohVO payInfo = jungGoNohService.getPayInfo(product_idx);
			model.addAttribute("jungGoNoh", payInfo);
			
			return "junggo/pay_complete";
				
		}
	
	//------------------------- 거래취소 폼 이동---------------------
		@GetMapping("tradeCancel")
		public String tradeCancel(@RequestParam String product_idx, HttpSession session, Model model, JungGoNohVO jungGoNoh) {
			try {			
				Authentication auth = SecurityContextHolder.getContext().getAuthentication();
				PrincipalDetails mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();
				int buyier_idx = mPrincipalDetails.getMember().getMem_idx(); // 사는사람(접속 idx
				jungGoNoh.setBuyier_idx(buyier_idx);
			}
			catch(Exception e) {

			}
			
			JungGoNohVO payInfo = jungGoNohService.getPayInfo(product_idx);
			model.addAttribute("jungGoNoh", payInfo);
			
			return "junggo/trade_cancel";
			
		}

	//------------------------- 거래완료 폼 이동---------------------
		@GetMapping("tradeComplete")
		public String resCancelCom(@RequestParam String product_idx, HttpSession session, Model model, JungGoNohVO jungGoNoh) {
			try {			
				Authentication auth = SecurityContextHolder.getContext().getAuthentication();
				PrincipalDetails mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();
				int buyier_idx = mPrincipalDetails.getMember().getMem_idx(); // 사는사람(접속 idx
				jungGoNoh.setBuyier_idx(buyier_idx);
			}
			catch(Exception e) {

			}
			
			JungGoNohVO payInfo = jungGoNohService.getPayInfo(product_idx);
			model.addAttribute("jungGoNoh", payInfo);
			
			return "junggo/trade_complete";
		}
	
	
	
}