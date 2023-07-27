package com.pj2.shoecream.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;

import com.pj2.shoecream.service.ChatService;
import com.pj2.shoecream.vo.ChatMsgVO;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class StompChatController {
	//채팅 db 활용 위한 서비스
	@Autowired
	private ChatService service;
	
    private final SimpMessagingTemplate template; //특정 Broker로 메세지를 전달
	// 클라이언트가 보낼(send)수 있는 경로
	// StompHandler 에서 설정한 setApplicationDestinationPrefixes 경로가 병합 
	// 해당 매핑을 이용하기 위해선 우선
    
    // 아래 구독 주소를 먼저 사용될 js 코드와 맞춰서 써야함
    
    /*
     * ex )  페이지의 js 코드에 
     * stomp.subscribe("/topic/room" + chat_room_idx, [콜백함수]) 로 구독을 한다 하면
     * 아래 코드의 주소도 같은 주소로 이루어져야함
     * 고정되는 주소라면 @SendTo 로 쓰면 되지만
     * 유동되는 주소면 아래와같이 
     * SimpMessagingTemplate 를 활용하여 convertAndSend(주소,메시지 로 전달해야함)
     */
    

    
	@MessageMapping("enter")
	public void enter(ChatMsgVO msg) {
		msg.setChat_msg_content(msg.getChat_msg_writer() + "님이 채팅방에 참여하였습니다.");
		template.convertAndSend("/topic/room" + msg.getChat_room_idx(),msg);
	}

	@MessageMapping("message")
	public void message(ChatMsgVO msg) {
		System.out.println("test : " + msg);
		if(!service.isChatMember(msg.getSId(),msg.getChat_room_idx())
				&& !msg.getSId().equals("admin")) {
			msg.setChat_msg_content("메시지 전송 권한이 없습니다!");
			template.convertAndSend("/topic/room" + msg.getChat_room_idx(),msg);	
			System.out.println("test1");
		}	
		else if(service.addChat(msg) < 0) {
			msg.setChat_msg_content("메시지 저장에 실패하였습니다!");
			template.convertAndSend("/topic/room" + msg.getChat_room_idx(),msg);			
			System.out.println("test2");
		}
		else {			
			template.convertAndSend("/topic/room" + msg.getChat_room_idx(),msg);
			System.out.println("test3");
		}
		System.out.println("test4");
	}
}
