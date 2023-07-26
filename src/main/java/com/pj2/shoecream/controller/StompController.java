package com.pj2.shoecream.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
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
		session.setMaxInactiveInterval(0);
		session.setAttribute("sId", sId);
		session.setMaxInactiveInterval(36000);
		return "redirect:/chatHome";
	}
	
    //채팅방 목록 조회후 채팅 페이지로 이동
    @GetMapping("rooms")
    public ModelAndView rooms(@RequestParam Map<String,Object> map, HttpServletRequest request, Model model){
    	HttpSession session = request.getSession();
    	ModelAndView mv = null;
    	String sId = (String)session.getAttribute("sId");
 
    	if(sId == null || sId.equals("") 
    			|| map.get("chat_area") == null || map.get("chat_area").equals("")) {    		
    			
    		System.out.println(sId + " / " + map.get("chat_area"));
    		mv = new ModelAndView("inc/fail_forward");
    		mv.addObject("msg","로그인이 필요 합니다!");
    		mv.addObject("targetURL","login");
    		return mv;
    	}
        mv = new ModelAndView("/inc/chat/rooms");
        try {        	
        	int idx = chatService.getSIdIdx(sId);
        	List<ChatRoomVO> chatList = chatService.getChatRoomList(idx,Integer.parseInt((String)map.get("chat_area")));
        	List<JungProductVO> productList = new ArrayList<JungProductVO>();
        	for(ChatRoomVO chat : chatList) {
        		productList.add(jungProductService.getJungProduct(chat.getProduct_idx()));
        	}
        	mv.addObject("list",chatList);
        	mv.addObject("productList", productList);
        }
        catch(NullPointerException e){
        	e.printStackTrace();
        	mv.addObject("list",null);
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
	public String getRoom(@RequestParam(defaultValue = "-1") String chat_room_idx,HttpSession session , Model model ){
		if(!chat_room_idx.equals("-1") && 
				chatService.isChatMember((String)session.getAttribute("sId"), 
						Integer.parseInt(chat_room_idx) )) {
			model.addAttribute("room", chatService.getChatRoom(Integer.parseInt(chat_room_idx)));
			model.addAttribute("chatList", chatService.getChatList(Integer.parseInt(chat_room_idx)));
		
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
