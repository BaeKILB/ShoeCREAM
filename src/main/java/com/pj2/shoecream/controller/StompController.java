package com.pj2.shoecream.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
		session.setAttribute("sId", sId);
		session.setMaxInactiveInterval(36000);
		return "redirect:/chatHome";
	}
	
    //채팅방 목록 조회
    @GetMapping("rooms")
    public ModelAndView rooms(HttpServletRequest request){
    	HttpSession session = request.getSession();
    	ModelAndView mv = null;
//    	if(session.getAttribute("sId") == null || session.getAttribute("sId").equals("")) {    		
//    		return new ModelAndView("/home");
//    	}
        mv = new ModelAndView("/inc/chat/rooms");
//        mv.addObject("list",chatService.getChatRoomList());

        return mv;
    }
	
	//RedirectAttributes 란? : 모델(Model) 의 확장형 객체
	// 흔히 post 후 redirect 시 사용됨
	@PostMapping("room")
	public String createRoom(@RequestParam ChatRoomVO chatRoom, RedirectAttributes rttr) {
		JungProductVO jProduct = jungProductService.getJungProduct(chatRoom.getProduct_idx());
		
		if(jProduct != null || jProduct.getProduct_title().equals("")) {
			chatRoom.setChat_room_area("중고");
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
	public String getRoom(@RequestParam(defaultValue = "-1") String chat_room_idx, Model model ){
		if(!chat_room_idx.equals("-1")) {
			model.addAttribute("room", chatService.getChatRoom(Integer.parseInt(chat_room_idx)));
			model.addAttribute("chatList", chatService.getChatList(Integer.parseInt(chat_room_idx)));
			return "/inc/chat/room";
		}
		else {
			model.addAttribute("msg","채팅방 입장에 실패하였습니다!");
			return "/etc/fail_back";
		}
	}
	
}
