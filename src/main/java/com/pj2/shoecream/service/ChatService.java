package com.pj2.shoecream.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Service;

import com.pj2.shoecream.handler.JsonHandler;
import com.pj2.shoecream.mapper.ChatMapper;
import com.pj2.shoecream.mapper.MemberMapper;
import com.pj2.shoecream.vo.ChatMsgVO;
import com.pj2.shoecream.vo.ChatRoomVO;
import com.pj2.shoecream.vo.MemberVO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ChatService {

	// stomp 로 메시지 보내기 위한 객체
	@Autowired
    private final SimpMessagingTemplate template; //특정 Broker로 메세지를 전달
	
	
	@Autowired
	private JsonHandler jsonHandler;
	
	@Autowired
	private ChatMapper mapper;
	
	@Autowired
	private MemberMapper memMapper;
	
	public int addChat(Map<String,String> chat) {
		return mapper.insertChat(chat);
	}
	
	public int makeChatRoom(ChatRoomVO roomVo) {
		return mapper.insertChatRoom(roomVo);
	}
	
	public List<Map<String,Object>> getChatList(int chat_room_idx){
		return mapper.selectChatList(chat_room_idx);
	}
	
	// sId로 idx 만 불러오기
	public int getSIdIdx(String sId) {
		MemberVO mem = memMapper.findMemberById(sId);
		if(mem == null)
			return -1;
		return mem.getMem_idx();
	}
	public String getSid(int idx) {
		MemberVO mem = memMapper.findMemberByMemIdx(idx);
		if(mem == null)
			return "";
		return mem.getMem_id();
	}

	public MemberVO getMember(String sId) {
		return memMapper.findMemberById(sId);
	}

	public MemberVO getMember(int idx) {
		return memMapper.findMemberByMemIdx(idx);
	}
	
	// 내가 있는 채팅방 검색
	public List<Map<String,Object>> getChatRoomList(int mem_idx , int chat_room_area){
		return mapper.selectChatRoomList(mem_idx, chat_room_area);
	}
	// 내가 있는 채팅방 검색 - sId 가지고 있을때
	public List<Map<String,Object>> getChatRoomList(String sId , int chat_room_area){
		int mem_idx = getSIdIdx(sId);
		if(mem_idx < 0) {
			return null;
		}
		return mapper.selectChatRoomList(mem_idx, chat_room_area);
	}
	
	//채팅방 가져오기
	public Map<String,Object> getChatRoom(int chat_room_idx, int chat_room_area){
		return mapper.selectChatRoom(chat_room_idx,chat_room_area);
	}
	
	// product_idx 와 멤버 idx 로 받아오기
	public ChatRoomVO getChatRoomIdx(String product_idx, int mem_idx){
		return mapper.selectChatRoomProductIdx(product_idx,mem_idx);
	}
	
	// 현재 자신이 채팅방 인원인지확인
	public boolean isChatMember(int idx , int chat_room_idx) {
		MemberVO mem = memMapper.findMemberByMemIdx(idx);
		if(mem == null) {
			return false;
		}
		Integer result = mapper.selectChatCheckAuth(mem.getMem_idx(), chat_room_idx);
		//null 체크
		if(!Objects.nonNull(result)) {
			return false;
		}
		return result > 0;
	}
	
	// 채팅방 상태 업데이트
	
	// 채팅방 위치 변경
	public boolean changeChatRoomArea(int chat_room_idx , int chat_room_area) {
		if(mapper.updateChatRoomArea(chat_room_idx, chat_room_area) > 0) {
			return true;
		}
		else {
			return false;
		}
	}
	public boolean changeChatRoomSeller(int chat_room_idx , int mem_seller_idx) {
		if(mapper.updateChatRoomSellerIdx(chat_room_idx, mem_seller_idx) > 0) {
			return true;
		}
		else {
			return false;
		}
	}
	public boolean changeChatRoomBuyer(int chat_room_idx , int mem_buyer_idx) {
		if(mapper.updateChatRoomBuyerIdx(chat_room_idx,mem_buyer_idx) > 0) {
			return true;
		}
		else {
			return false;
		}
	}
	
	// java 내부에서 stomp로 채팅을 원하는 시점에 메시지 보내기
	// map 에 있어야할 값
	/*
	 * member : 메시지 보낼 멤버정보
	 * chat_room_idx : 현재 채팅방 번호
	 * chat_msg_content : 채팅 내용 넣기
	 * product_sell_status(선택) : 현재 상품의 거래 상태 넣을시 중고 채팅쪽의 상품, 회원 상태바 변경
	 * */
	public void sandchatInJava(Map<String,Object> map) {
		  // 내부에서 원하는 시점에 stomp 메시지 보내기
		 
		MemberVO member = (MemberVO)map.get("member");
		
	    // ChatMessage 객체 생성하기
	    Map<String,String> msg = new HashMap<String, String>();
	    msg.put("chat_room_idx",(String)map.get("chat_room_idx"));
	    msg.put("chat_msg_writer",Integer.toString(member.getMem_idx()));
	    msg.put("chat_msg_content",(String)map.get("chat_msg_content"));
	    msg.put("sId",member.getMem_id());
	    msg.put("nickname",member.getMem_nickname());
	    if(map.get("product_sell_status") != null) {	    	
	    	msg.put("product_sell_status",(String)map.get("product_sell_status"));
	    }
	    if(map.get("isCancel") != null) {	    	
	    	msg.put("isCancel",(String)map.get("isCancel"));
	    }
	    
	    // convertAndSend() 메서드 사용하기
	    
		JSONObject jo = jsonHandler.map2Json(msg);
		addChat(msg);
		template.convertAndSend("/topic/room" + msg.get("chat_room_idx"),jo.toString());
	}
	
}
