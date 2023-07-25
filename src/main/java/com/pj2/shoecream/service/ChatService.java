package com.pj2.shoecream.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pj2.shoecream.mapper.ChatMapper;
import com.pj2.shoecream.vo.ChatMsgVO;
import com.pj2.shoecream.vo.ChatRoomVO;
import com.pj2.shoecream.vo.MemberVO;

@Service
public class ChatService {

	@Autowired
	private ChatMapper mapper;
	
	public int addChat(ChatMsgVO chat) {
		return mapper.insertChat(chat);
	}
	
	public int makeChatRoom(ChatRoomVO roomVo) {
		return mapper.insertChatRoom(roomVo);
	}
	
	public List<ChatMsgVO> getChatList(int chat_room_idx){
		return mapper.selectChatList(chat_room_idx);
	}
	
	// 내가 파는쪽 제품의 채팅방 검색
	public List<ChatRoomVO> getChatRoomListSeller(int mem_idx , String chat_room_area){
		return mapper.selectChatRoomListSeller(mem_idx, chat_room_area);
	}
	// 내가 사는쪽 제품의 채팅방 검색 
	public List<ChatRoomVO> getChatRoomListBuyer(int mem_idx , String chat_room_area){
		return mapper.selectChatRoomListBuyer(mem_idx, chat_room_area);
	}
	public ChatRoomVO getChatRoom(int room_id){
		return mapper.selectChatRoom(room_id);
	}
	
	public boolean isChatMember(int mem_idx, int chat_room_idx) {
		return mapper.selectChatCheckAuth(mem_idx, chat_room_idx) > 0;
	}
	
	
}
