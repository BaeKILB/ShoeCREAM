package com.pj2.shoecream.controller;

import java.util.Map;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestParam;

import com.pj2.shoecream.handler.JsonHandler;
import com.pj2.shoecream.service.ChatService;
import com.pj2.shoecream.vo.ChatMsgVO;
import com.pj2.shoecream.vo.MemberVO;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class StompChatController {
	//채팅 db 활용 위한 서비스
	@Autowired
	ChatService service;
	
	@Autowired
    private final SimpMessagingTemplate template; //특정 Broker로 메세지를 전달
	
	@Autowired
	private	JsonHandler jsonHandler; 
	
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
	public void enter(@RequestParam Map<String,String> msg) {

		MemberVO member = service.getMember(msg.get("sId"));
		int idx = member.getMem_idx();
		String nickname = member.getMem_nickname();
		
		msg.put("chat_msg_content", nickname + "님이 채팅방에 참여하였습니다.");
		
		System.out.println("test : " + msg);
		JSONObject jo = jsonHandler.map2Json(msg);
		jo.put("nickname", nickname);
		template.convertAndSend("/topic/room" + msg.get("chat_room_idx"),jo.toString());
	}

	@MessageMapping("message")
	public void message(@RequestParam Map<String,String> msg) {
		System.out.println("test : " + msg);
		MemberVO member = service.getMember(msg.get("sId"));
		int idx = member.getMem_idx();
		String nickname = member.getMem_nickname();
		if(!service.isChatMember(idx,Integer.parseInt(msg.get("chat_room_idx")))
				&& !msg.get("sId").equals("admin")) {
			msg.put("chat_msg_content","메시지 전송 권한이 없습니다!");
			JSONObject jo = jsonHandler.map2Json(msg);
			template.convertAndSend("/topic/room" + msg.get("chat_room_idx"),jo.toString());	
		}	
		
		msg.put("chat_msg_writer", Integer.toString(idx));
		if(service.addChat(msg) < 0) {
			msg.put("chat_msg_content","메시지 저장에 실패하였습니다!");
			JSONObject jo = jsonHandler.map2Json(msg);
			template.convertAndSend("/topic/room" + msg.get("chat_room_idx"),jo.toString());
		}
		else {			
			JSONObject jo = jsonHandler.map2Json(msg);
			jo.put("nickname", nickname);
			template.convertAndSend("/topic/room" + msg.get("chat_room_idx"),jo.toString());
		}
	}
	
	// ==================== 채팅 부가 작업
	// 채팅 물품 변화에 따른 정보를 수신받아 트리거를 보내서 ajax 동작을 하게끔 하기
	
	@MessageMapping("checkItemStatus")
	public void checkItemStatus(Map<String,String> map) {
		if(map.get("checkStart") != null && map.get("checkStart").equals("Y")) {
			
		}
	}
	
	
}






















