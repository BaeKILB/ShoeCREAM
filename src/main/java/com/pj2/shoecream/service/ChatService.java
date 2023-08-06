package com.pj2.shoecream.service;

import java.util.List;
import java.util.Map;
import java.util.Objects;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pj2.shoecream.mapper.ChatMapper;
import com.pj2.shoecream.mapper.MemberMapper;
import com.pj2.shoecream.vo.ChatMsgVO;
import com.pj2.shoecream.vo.ChatRoomVO;
import com.pj2.shoecream.vo.MemberVO;

@Service
public class ChatService {

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
	
	
}
