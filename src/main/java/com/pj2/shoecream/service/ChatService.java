package com.pj2.shoecream.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pj2.shoecream.mapper.ChatMapper;
import com.pj2.shoecream.vo.ChatRoomVO;
import com.pj2.shoecream.vo.ChatMsgVO;


@Service
public class ChatService {

	@Autowired
	private ChatMapper mapper;
	
	public int addChat(ChatMsgVO chat) {
		return mapper.insertChat(chat);
	}
	
	public int makeChatRoom(String room_title) {
		ChatRoomVO chatRoom = new ChatRoomVO();
		chatRoom.setRoom_title(room_title);
		System.out.println(chatRoom);
		return mapper.insertChatRoom(chatRoom);
	}
	
	public List<ChatMsgVO> getChatList(int room_id){
		return mapper.selectChatList(room_id);
	}
	
	public List<ChatRoomVO> getChatRoomList(){
		return mapper.selectChatRoomList();
	}
	public ChatRoomVO getChatRoom(int room_id){
		return mapper.selectChatRoom(room_id);
	}
	
}
