package com.pj2.shoecream.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.pj2.shoecream.config.PrincipalDetails;
import com.pj2.shoecream.service.ChatService;
import com.pj2.shoecream.service.JungProductService;
import com.pj2.shoecream.vo.ChatRoomVO;
import com.pj2.shoecream.vo.JungProductVO;





@Controller
public class StompController {
	
	@Autowired
	private ChatService chatService;
	
	@Autowired
	private JungProductService jungProductService;

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
    		if(!chat_room_idx.equals("-1") && 
    				chatService.isChatMember(idx, 
    				Integer.parseInt(chat_room_idx))) {
    			model.addAttribute("room", chatService.getChatRoom(Integer.parseInt(chat_room_idx)));
    			model.addAttribute("chatList", chatService.getChatList(Integer.parseInt(chat_room_idx)));
    			model.addAttribute("sId", chatService.getSid(idx));
    			
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
	@GetMapping("makeChatRoom")
	public String makeChatRoom(@RequestParam Map<String,Object> map, Model model
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
			model.addAttribute("msg","권한이 없습니다 ! 로그인 해주세요");
			model.addAttribute("targetURL","login"); // 로그인 페이지 넘어갈 때 리다이렉트 할수있는거 있어야 될듯?
			return "inc/fail_forward";
		}
		
		// 만약 위 코드가 통과 되었지만
		// idx 가 초기화된 값 그대로이거나 map 파라미터 못 가져올때 
		// 다시 돌려보내기
		if(idx == -1 || map == null) {

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
			model.addAttribute("msg","현 제품 번호에 해당하는 상품이 없습니다!");
			model.addAttribute("targetURL","productDetail?product_idx=" + (String)map.get("product_idx"));
			return "inc/fail_forward";
		}
		
		// 판매자 idx 넣기
		chatRoom.setMem_seller_idx(jProduct.getMem_idx());
		
		// 현재 product idx 와 현재 접속 아이디의 idx 로 만들어진 방이 있을때 체크 
		ChatRoomVO checkRoom = chatService.getChatRoom(chatRoom.getProduct_idx(),idx);
		
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
				rttr.addAttribute("msg", "본인의 판매글에 대한 채팅방은 만들 수 없습니다!");
				rttr.addAttribute("targetURL", "productDetail?product_idx=" + (String)map.get("product_idx"));
				return "inc/fail_forward"; 
		}
		
		System.out.println("makeChatRoom - jProduct : " + jProduct);
		
		// 방 만들기 시작
		if(jProduct != null) {
			// 만들어진 ChatRoomVO 틀로 채팅방 만들기
			if(chatService.makeChatRoom(chatRoom) > 0) {
				
				// 넣고 난 뒤 채팅방으로 바로 리다이렉트 하기 때문에
				// chat_room_idx 가 필요함으로 채팅방 다시 받아오기
				ChatRoomVO resultRoom = chatService.getChatRoom(chatRoom.getProduct_idx(),idx);
				
				// 채팅방 제대로 받아왔는지 체크
				if(resultRoom != null) {					
					rttr.addAttribute("chat_area", resultRoom.getChat_room_area());
					rttr.addAttribute("chat_room_idx", resultRoom.getChat_room_idx());
					System.out.println("chatService.makeChatRoom(chatRoom) > 0  - chatRoom : " + chatRoom);
					return "redirect:chatRooms";
				}
			}		
		}
		
		//만약 방이 안만들어 졌다면 되돌려 보내기
		rttr.addAttribute("msg", "채팅방 개설에 문제가 발생하였습니다!");
		rttr.addAttribute("targetURL", "productDetail?product_idx=" + (String)map.get("product_idx"));
		return "inc/fail_forward"; 
		
		
	}
	
//	@GetMapping("room")
//	public String getRoom(@RequestParam(defaultValue = "-1") String chat_room_idx,
//			 @AuthenticationPrincipal PrincipalDetails principalDetails,
//			HttpSession session , Model model ){
//		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
//		PrincipalDetails mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();
//		int idx = mPrincipalDetails.getMember().getMem_idx();
//		
//		if(!chat_room_idx.equals("-1") && 
//				chatService.isChatMember(idx, 
//				Integer.parseInt(chat_room_idx) )) {
//			model.addAttribute("room", chatService.getChatRoom(Integer.parseInt(chat_room_idx)));
//			model.addAttribute("chatList", chatService.getChatList(Integer.parseInt(chat_room_idx)));
//			model.addAttribute("idx", chatService.getSIdIdx((String)session.getAttribute("sId")));
//			return "/inc/chat/room";
//		}
//		else {
//			model.addAttribute("msg","채팅방 입장에 실패하였습니다!");
//			return "/etc/fail_back";
//		}
//	}
	
	
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
