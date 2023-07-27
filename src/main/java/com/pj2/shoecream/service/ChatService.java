package com.pj2.shoecream.service;

import java.util.List;
import java.util.Map;

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
	
	public int addChat(ChatMsgVO chat) {
		return mapper.insertChat(chat);
	}
	
	public int makeChatRoom(ChatRoomVO roomVo) {
		return mapper.insertChatRoom(roomVo);
	}
	
	public List<ChatMsgVO> getChatList(int chat_room_idx){
		return mapper.selectChatList(chat_room_idx);
	}
	
	// sId로 idx 만 불러오기
	public int getSIdIdx(String sId) {
		MemberVO mem = memMapper.findMemberById(sId);
		if(mem == null)
			return -1;
		return mem.getMem_idx();
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
	public ChatRoomVO getChatRoom(int room_id){
		return mapper.selectChatRoom(room_id);
	}
	
	// 현재 자신이 채팅방 인원인지확인
	public boolean isChatMember(String sId , int chat_room_idx) {
		MemberVO mem = memMapper.findMemberById(sId);
		if(mem == null) {
			return false;
		}
		return mapper.selectChatCheckAuth(mem.getMem_idx(), chat_room_idx) > 0;
	}
	
	
}
