package com.pj2.shoecream.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.pj2.shoecream.config.PrincipalDetails;
import com.pj2.shoecream.handler.ChatHandler;
import com.pj2.shoecream.service.ChatService;
import com.pj2.shoecream.service.JungProductService;
import com.pj2.shoecream.vo.ChatRoomVO;
import com.pj2.shoecream.vo.JungProductVO;




@Controller
public class StompController {
	
	private static final Logger logger = LoggerFactory.getLogger(StompController.class);
	
	@Autowired
	private ChatService chatService;
	
	@Autowired
	private JungProductService jungProductService;

	@Autowired
	private ChatHandler chatHandler;
	
	// 웹 소켓(stomp) 받을 경로
	// StompHandler 에서 설정한 setApplicationDestinationPrefixes 경로가 병합 
//	@MessageMapping("/hello")
//	//구독 경로 설정
//	// queue 방식으로 받을 경우는 1:1 방식임으로 SendToUser로 어노테이션 설정 
//	@SendTo("/topic/testQueue")
	// SimpMessageHeaderAccessor : 기본 메시징 패턴을 지원하는
	// 			메시징 프로토콜의 헤더작업을 위한 기본 클래스
	//			메시지 유형(예: 게시, 구독 등), 세션 ID 등과 같은 프로토콜 전체에서 
	//			공통적인 특정 값에 대한 균일한 액세스를 제공.
	
	//	요약 : 아까 Handshake 핸들러에서 넣은 세션을 불러올수있게 하는 객체
//	public String testQueue(String message, SimpMessageHeaderAccessor messageHeaderAccessor) {
//		
//		return message;
//	}
//	

	
//	@GetMapping("chatHome")
//	public String chatHome() {
//		return "/inc/chat/chat_home";
//	}
//	
//	@GetMapping("setSid")
//	public String setSid(@RequestParam String sId, HttpServletRequest request) {
//		HttpSession session = request.getSession();
//		session.setMaxInactiveInterval(0);
//		session.setAttribute("sId", sId);
//		session.setMaxInactiveInterval(36000);
//		return "redirect:/chatHome";
//	}
	
    //채팅방 목록 조회후 채팅 페이지로 이동
    @GetMapping("chatRooms")
    public String chatRooms(@RequestParam Map<String,Object> map, 
    		@AuthenticationPrincipal PrincipalDetails principalDetails, 
    		Model model){    	
    	
    	
    	//spring security
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        int idx = -1;
        PrincipalDetails mPrincipalDetails = null;
        try {        	
        	mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();
        	idx = mPrincipalDetails.getMember().getMem_idx(); // 세션에 저장된 mem_idx
        }
        catch(Exception e){
    		model.addAttribute("msg","로그인이 필요 합니다!");
    		model.addAttribute("targetURL","login");
    		return "inc/fail_forward";
        }
		

    	// idx 값 있는지 체크
    	if(idx < 0) {    		
    			
    		model.addAttribute("msg","로그인이 필요 합니다!");
    		model.addAttribute("targetURL","login");
    		return "inc/fail_forward";
    	}
    	if(map.get("chat_area") == null || map.get("chat_area").equals("")) {    		
    		model.addAttribute("msg","잘못된 url 입니다");
    		return "inc/fail_back";
    	}

        try {        	
        	
        	// 이 chat list 는 상품과 통합 되어서 반환됨
        	List<Map<String,Object>> chatRoomList 
        	= chatService.getChatRoomList(idx,Integer.parseInt((String)map.get("chat_area")));
        
        	model.addAttribute("list",chatRoomList);
        	model.addAttribute("myIdx", idx);
        }
        catch(NullPointerException e){
        	e.printStackTrace();
        	model.addAttribute("list",null);
        }
        
        if(map.get("chat_room_idx") != null) {
        	String chat_room_idx = (String)map.get("chat_room_idx");
        	Integer chat_room_area = Integer.parseInt((String)map.get("chat_area"));
    		if(!chat_room_idx.equals("-1") && 
    				chatService.isChatMember(idx, 
    				Integer.parseInt(chat_room_idx))) {
    			model.addAttribute("room", chatService.getChatRoom(Integer.parseInt(chat_room_idx),chat_room_area));
    			model.addAttribute("chatList", chatService.getChatList(Integer.parseInt(chat_room_idx)));
    			model.addAttribute("sId", chatService.getSid(idx));
    			model.addAttribute("userNickname", mPrincipalDetails.getMember().getMem_nickname());
    			
    		}
    		else {
    			System.out.println("chat_room_idx.equals(\"-1\")  - 채팅방 입장에 실패하였습니다 : " );
    			model.addAttribute("msg","채팅방 입장에 실패하였습니다!");
    			return "/etc/fail_back";
    		}
        }

        return "/inc/chat/rooms";
    }
	
	//RedirectAttributes 란? : 모델(Model) 의 확장형 객체
	// 흔히 post 후 redirect 시 사용됨
//	@PostMapping("room")
//	public String createRoom(@RequestParam ChatRoomVO chatRoom, RedirectAttributes rttr) {
//		JungProductVO jProduct = jungProductService.getJungProductChat(chatRoom.getProduct_idx());
//		
//		if(jProduct != null || jProduct.getProduct_title().equals("")) {
//			chatRoom.setChat_room_area(1);
//			if(chatService.makeChatRoom(chatRoom) > 0) {
//				rttr.addFlashAttribute("createRoomMsg", jProduct.getProduct_title() + "방이 개설되었습니다.");
//			}
//		}
//		else {
//			rttr.addFlashAttribute("createRoomMsg", "방 개설에 문제가 발생하였습니다!");
//			
//		}
//		return "redirect:rooms";			
//	}
	
	// junggo - JungChat 에서 넘어옴
	// product_idx, idx 받아 채팅방 개설
	@GetMapping("makeJungChatRoom")
	public String makeJungChatRoom(@RequestParam Map<String,Object> map, Model model
			, RedirectAttributes rttr) {
		
		
		// 현재 로그인 된 아이디의 idx 번호 받을 변수
		int idx = -1;
		
		// try catch 로 오류 처리
		try {
			// spring security 이용 idx 받아오기
			Authentication auth = SecurityContextHolder.getContext().getAuthentication();
			PrincipalDetails mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();
			idx = mPrincipalDetails.getMember().getMem_idx();
		}
		catch(Exception e) {
			// 만약 idx 못받아오면 다시 로그인
			logger.error("makeJungChatRoom - not login");
			model.addAttribute("msg","권한이 없습니다 ! 로그인 해주세요");
			model.addAttribute("targetURL","login"); // 로그인 페이지 넘어갈 때 리다이렉트 할수있는거 있어야 될듯?
			return "inc/fail_forward";
		}
		
		// 만약 위 코드가 통과 되었지만
		// idx 가 초기화된 값 그대로이거나 map 파라미터 못 가져올때 
		// 다시 돌려보내기
		if(idx == -1 || map == null) {

			logger.error("makeJungChatRoom - param error");
			model.addAttribute("msg","올바르지 않는 값입니다 다시 시도해주세요 !");
			model.addAttribute("targetURL","productDetail?product_idx=" + (String)map.get("product_idx"));
			return "inc/fail_forward";
		}
		
		// 채팅 방 만들때 사용할 chatRoomVO 준비 
		ChatRoomVO chatRoom = new ChatRoomVO();
		
		// map 으로 가져온 파라미터 넣어주기
		chatRoom.setProduct_idx((String)map.get("product_idx"));
		chatRoom.setChat_room_area(Integer.parseInt((String)map.get("chat_room_area")) );
		// 채팅방은 구매자만 만들기 가능 !
		chatRoom.setMem_buyer_idx(idx);

		// 파라미터로 가져온 product_idx 를 이용 중고 가져오기
		JungProductVO jProduct = null;
		try {			
			// 에러처리
			jProduct = jungProductService.getJungProductChat(chatRoom.getProduct_idx());
		} catch(Exception e) {
			// 만약 idx 못받아오면 다시 로그인
			logger.error("makeJungChatRoom - getJungProductChat error");
			model.addAttribute("msg","현 제품 번호에 해당하는 상품이 없습니다!");
			model.addAttribute("targetURL","productDetail?product_idx=" + (String)map.get("product_idx"));
			return "inc/fail_forward";
		}
		
		// 판매자 idx 넣기
		chatRoom.setMem_seller_idx(jProduct.getMem_idx());
		
		// 현재 product idx 와 현재 접속 아이디의 idx 로 만들어진 방이 있을때 체크 
		ChatRoomVO checkRoom = chatService.getChatRoomIdx(chatRoom.getProduct_idx(),idx);
		
		if(checkRoom != null  
				&& (checkRoom.getMem_seller_idx() == idx
				|| checkRoom.getMem_buyer_idx() == idx)) {
			
			// 방을 만들지않고 해당 채팅방으로 바로 들어감
			rttr.addAttribute("chat_area", checkRoom.getChat_room_area());
			rttr.addAttribute("chat_room_idx", checkRoom.getChat_room_idx());
			System.out.println("checkRoom != null - checkRoom : " + checkRoom);
			return "redirect:chatRooms";		
		}
		// 만약 해당 방이 없지 만 지금 클릭한게 자기가 쓴 판매글이라면 되돌아 감
		else if(chatRoom.getMem_seller_idx() == idx) {
				logger.error("makeJungChatRoom - already make chat room");
				model.addAttribute("msg", "본인의 판매글에 대한 채팅방은 만들 수 없습니다!");
				model.addAttribute("targetURL", "productDetail?product_idx=" + (String)map.get("product_idx"));
				return "inc/fail_forward"; 
		}
		
		// 만약 이미 자신이 아닌 다른사람과 예약중이라면 ? 
		// 이것도 되돌려 보내기
		if(jProduct.getProduct_buyer_idx() < 0) {
			logger.error("makeJungChatRoom - already res chat room");
			model.addAttribute("msg", "이미 다른사람과 예약중에 있습니다. 찜 기능을 이용하시면 현황을 쉽게 확인 할 수 있습니다.");
			model.addAttribute("targetURL", "productDetail?product_idx=" + (String)map.get("product_idx"));
			return "inc/fail_forward"; 
		}
		
		
		System.out.println("makeJungChatRoom - jProduct : " + jProduct);
		
		// 방 만들기 시작
		if(jProduct != null) {
			// 만들어진 ChatRoomVO 틀로 채팅방 만들기
			if(chatService.makeChatRoom(chatRoom) > 0) {
				
				// 넣고 난 뒤 채팅방으로 바로 리다이렉트 하기 때문에
				// chat_room_idx 가 필요함으로 채팅방 다시 받아오기
				ChatRoomVO resultRoom = chatService.getChatRoomIdx(chatRoom.getProduct_idx(),idx);
				
				// 채팅방 제대로 받아왔는지 체크
				if(resultRoom != null) {					
					rttr.addAttribute("chat_area", resultRoom.getChat_room_area());
					rttr.addAttribute("chat_room_idx", resultRoom.getChat_room_idx());
					System.out.println("chatService.makeJungChatRoom(chatRoom) > 0  - chatRoom : " + chatRoom);
					return "redirect:chatRooms";
				}
			}		
		}

		logger.error("makeJungChatRoom - error already make chat room");
		//만약 방이 안만들어 졌다면 되돌려 보내기
		model.addAttribute("msg", "채팅방 개설에 문제가 발생하였습니다!");
		model.addAttribute("targetURL", "productDetail?product_idx=" + (String)map.get("product_idx"));
		return "inc/fail_forward"; 
		
		
	}
	
	
	// 채팅방 나가기 기능
	@GetMapping("chatRoomOut")
	public String chatRoomOut(@RequestParam Map<String,Object> map, Model model
			, RedirectAttributes rttr) {
		
		// 현재 로그인 된 아이디의 idx 번호 받을 변수
		int idx = -1;
		String id = "";
		// try catch 로 오류 처리
		try {
			// spring security 이용 idx 받아오기
			Authentication auth = SecurityContextHolder.getContext().getAuthentication();
			PrincipalDetails mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();
			idx = mPrincipalDetails.getMember().getMem_idx();
			id = mPrincipalDetails.getMember().getMem_id();
		}
		catch(Exception e) {
			// 만약 idx 못받아오면 다시 로그인
			model.addAttribute("msg","권한이 없습니다 ! 로그인 해주세요");
			model.addAttribute("targetURL","login"); // 로그인 페이지 넘어갈 때 리다이렉트 할수있는거 있어야 될듯?
			return "inc/fail_forward";
		}
		
		// 파라미터 받기
		String chatRoomIdxStr = (String)map.get("chat_room_idx");
		String chatAreaStr = (String)map.get("chat_area");
		
		// 파라미터 들어왔는지 체크
		if(chatRoomIdxStr == null || chatAreaStr == null) {
			model.addAttribute("msg","잘못된 주소값 입니다!");
			return "inc/fail_back";
		}
		
		
		
		int chatRoomIdx = Integer.parseInt(chatRoomIdxStr);
		int chatArea = Integer.parseInt(chatAreaStr);
		
		// 지금 접속한 유저가 실제 채팅방 유저인지 또는 관리자인지 체크
		if(!chatService.isChatMember(idx,chatRoomIdx) && !id.equals("admin")) {
			model.addAttribute("msg","권한이 없습니다!");
			return "inc/fail_back";
		}
		
		//채팅방 정보 들고오기
		Map<String,Object> chatRoom = null;
		chatRoom = chatService.getChatRoom(chatRoomIdx, chatArea);
		if(chatRoom == null) {			
			model.addAttribute("msg","채팅방이 존재하지 않습니다!");
			return "inc/fail_back";
		}
		
		// 현재 채팅방의 상품정보가 거래대기중이면 나가기가 안되게 막기
		if(chatRoom.get("product_sell_status").equals("거래대기중") && !id.equals("admin")) {
			model.addAttribute("msg","페이결제를 진행한상태 입니다! 결제 취소후 또는 요청후 진행해주세요");
			return "inc/fail_back";
		}
		
		// 채팅방 나가기
		// 본인이 판매자인지 구매자인지 확인해서 채팅방의 유저 idx 를 다른 번호로 바꾸기
		
		boolean checkResult = false;
		// 관리자인 경우부터 체크
		if(id.equals("admin")) {
			// chatRoomIdx 를 9 로 변경하기
			if(chatService.changeChatRoomArea(chatRoomIdx, 9)) {
				checkResult = true;
			}
		}
		else if((Integer)chatRoom.get("mem_seller_idx") == idx) {
			if(chatService.changeChatRoomSeller(chatRoomIdx,-1)) {
				checkResult = true;
			}
		}
		else if((Integer)chatRoom.get("mem_buyer_idx") == idx) {
			if(chatService.changeChatRoomBuyer(chatRoomIdx,-1)) {
				checkResult = true;
			}
		}
		else {
			model.addAttribute("msg","권한이 없습니다!");
			return "inc/fail_back";
		}
		
		if(checkResult) {			
			return "redirect:chatRooms?chat_area=" + chatArea;	
		}
		else {
			model.addAttribute("msg","채팅방 나가기 중 문제가 발생했습니다!");
			return "inc/fail_back";
		}
	}
	
	
	//=========== ajax ==============
	
	@RequestMapping(
			value = "checkChatRoomStatus.ajax",
			method = RequestMethod.POST,
			produces = "application/text; charset=UTF-8"
	)	
	@ResponseBody
	public String checkChatRoomStatus(@RequestParam Map<String, Object> map) { 
		System.out.println("checkChatRoomStatus : in");
		// 현재 로그인 된 아이디의 idx 번호 받을 변수
		int idx = -1;
		
		// 채팅 방 정보 받을 객체
		Map<String,Object> chatMap = null;
		
		// 반환 해 줄 변수 
		JSONObject jsonObj = new JSONObject();	
		
		// html 받을 문자열
		String result = null;
		
		// try catch 로 오류 처리
		try {
			// spring security 이용 idx 받아오기
			Authentication auth = SecurityContextHolder.getContext().getAuthentication();
			PrincipalDetails mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();
			idx = mPrincipalDetails.getMember().getMem_idx();
		}
		catch(Exception e) {
			return null;
		}
		System.out.println("checkChatRoomStatus :  get idx");
		// 가져온 chat_room_idx 와 chat_room_area 로 채팅방 정보 검색
       if(map.get("chat_room_idx") != null) {
        	String chat_room_idx = (String)map.get("chat_room_idx");
        	Integer chat_room_area = Integer.parseInt((String)map.get("chat_room_area"));
    		if(!chat_room_idx.equals("-1") && 
    				chatService.isChatMember(idx, 
    				Integer.parseInt(chat_room_idx))) {
    			chatMap = chatService.getChatRoom(Integer.parseInt(chat_room_idx),chat_room_area);
    			
    		}
    		else {
    			return null;
    		}
        }
       System.out.println("checkChatRoomStatus : getchatroom");
       
	   	// 아래 html 에 넣을 신고시 사용할 파라미터 문자열 셋업
	   	String registReport = 
	   			chatMap.get("product_idx")
	   			+"," + chatMap.get("mem_seller_idx")
	   			+"," + idx
	   			;
	   	chatMap.put("registReport", registReport);
	   	// 현재 상품 판매 상태 따라서 채팅창 정보바 레이아웃 설정
		switch ((String)chatMap.get("product_sell_status")) {
		case "대기중":
			if(idx == (Integer)chatMap.get("mem_buyer_idx")) {
				result = chatHandler.buyerWaitingHtml(chatMap);
			}
			else {
				result = chatHandler.sellerWaitingHtml(chatMap);				
			}
			break;
		case "예약중":
			if(idx == (Integer)chatMap.get("mem_buyer_idx")) {
				result = chatHandler.buyerResHtml(chatMap);
			}
			else {
				result = chatHandler.sellerResHtml(chatMap);				
			}
			
			break;
		case "거래대기중":
			if(idx == (Integer)chatMap.get("mem_buyer_idx")) {
				result = chatHandler.buyerWaitTakeHtml(chatMap);
			}
			else {
				result = chatHandler.sellerWaitTakeHtml(chatMap);				
			}
			
			break;
		case "거래완료":
			if(idx == (Integer)chatMap.get("mem_buyer_idx")) {
				result = chatHandler.buyerCompleteHtml(chatMap);
			}
			else {
				result = chatHandler.sellerCompleteHtml(chatMap);				
			}
			
			break;

		default:
			result = "문제가 발생했습니다 !";
			
			break;
		}
		
		System.out.println("checkChatRoomStatus : result" + result);
		jsonObj.put("html", result);
		return jsonObj.toString();
	}
	
	// 채팅방 ajax 방식으로 불러오기 
	// 추후 작성 ...
	@GetMapping("getRoomAjax")
	@ResponseBody
	public String getRoomAjax(@RequestParam Map<String, Object> map ,
			HttpSession session,
			Model model) {
		return "";
		
	}
	
}
