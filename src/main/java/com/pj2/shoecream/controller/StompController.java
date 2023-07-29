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

	
	@GetMapping("chatHome")
	public String chatHome() {
		return "/inc/chat/chat_home";
	}
	
	@GetMapping("setSid")
	public String setSid(@RequestParam String sId, HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.setMaxInactiveInterval(0);
		session.setAttribute("sId", sId);
		session.setMaxInactiveInterval(36000);
		return "redirect:/chatHome";
	}
	
    //채팅방 목록 조회후 채팅 페이지로 이동
    @GetMapping("chatRooms")
    public ModelAndView chatRooms(@RequestParam Map<String,Object> map, 
    		@AuthenticationPrincipal PrincipalDetails principalDetails, HttpSession session){    	
    	ModelAndView mv = null;

        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        int idx = -1;
        PrincipalDetails mPrincipalDetails = null;
        try {        	
        	mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();
        	idx = mPrincipalDetails.getMember().getMem_idx(); // 세션에 저장된 mem_idx
        }
        catch(Exception e){
        
        }
		

    	// idx 값 있는지 체크
    	if(idx < 0) {    		
    			
    		mv = new ModelAndView("inc/fail_forward");
    		mv.addObject("msg","로그인이 필요 합니다!");
    		mv.addObject("targetURL","login");
    		return mv;
    	}
    	if(map.get("chat_area") == null || map.get("chat_area").equals("")) {    		
    		mv = new ModelAndView("inc/fail_back");
    		mv.addObject("msg","잘못된 url 입니다");
    		return mv;
    	}
        mv = new ModelAndView("/inc/chat/rooms");
        try {        	
        	
        	// 이 chat list 는 상품과 통합 되어서 반환됨
        	List<Map<String,Object>> chatRoomList 
        	= chatService.getChatRoomList(idx,Integer.parseInt((String)map.get("chat_area")));
        
        	mv.addObject("list",chatRoomList);
        	mv.addObject("myIdx", idx);
        }
        catch(NullPointerException e){
        	e.printStackTrace();
        	mv.addObject("list",null);
        }
        
        if(map.get("chat_room_idx") != null) {
        	String chat_room_idx = (String)map.get("chat_room_idx");
    		if(!chat_room_idx.equals("-1") && 
    				chatService.isChatMember(idx, 
    				Integer.parseInt(chat_room_idx))) {
    			mv.addObject("room", chatService.getChatRoom(Integer.parseInt(chat_room_idx)));
    			mv.addObject("chatList", chatService.getChatList(Integer.parseInt(chat_room_idx)));
    			mv.addObject("sId", chatService.getSid(idx));
    			
    		}
    		else {
    			mv.addObject("msg","채팅방 입장에 실패하였습니다!");
    			return new ModelAndView("/etc/fail_back");
    		}
        }

        return mv;
    }
	
	//RedirectAttributes 란? : 모델(Model) 의 확장형 객체
	// 흔히 post 후 redirect 시 사용됨
	@PostMapping("room")
	public String createRoom(@RequestParam ChatRoomVO chatRoom, RedirectAttributes rttr) {
		JungProductVO jProduct = jungProductService.getJungProduct(chatRoom.getProduct_idx());
		
		if(jProduct != null || jProduct.getProduct_title().equals("")) {
			chatRoom.setChat_room_area(1);
			if(chatService.makeChatRoom(chatRoom) > 0) {
				rttr.addFlashAttribute("createRoomMsg", jProduct.getProduct_title() + "방이 개설되었습니다.");
			}
		}
		else {
			rttr.addFlashAttribute("createRoomMsg", "방 개설에 문제가 발생하였습니다!");
			
		}
		return "redirect:rooms";			
	}
	
	@GetMapping("room")
	public String getRoom(@RequestParam(defaultValue = "-1") String chat_room_idx,
			 @AuthenticationPrincipal PrincipalDetails principalDetails,
			HttpSession session , Model model ){
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		PrincipalDetails mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();
		int idx = mPrincipalDetails.getMember().getMem_idx();
		
		if(!chat_room_idx.equals("-1") && 
				chatService.isChatMember(idx, 
				Integer.parseInt(chat_room_idx) )) {
			model.addAttribute("room", chatService.getChatRoom(Integer.parseInt(chat_room_idx)));
			model.addAttribute("chatList", chatService.getChatList(Integer.parseInt(chat_room_idx)));
			model.addAttribute("idx", chatService.getSIdIdx((String)session.getAttribute("sId")));
			return "/inc/chat/room";
		}
		else {
			model.addAttribute("msg","채팅방 입장에 실패하였습니다!");
			return "/etc/fail_back";
		}
	}
	
	@GetMapping("getRoomAjax")
	@ResponseBody
	public String getRoomAjax(@RequestParam Map<String, Object> map ,
			HttpSession session,
			Model model) {
		return "";
		
	}
	
}
