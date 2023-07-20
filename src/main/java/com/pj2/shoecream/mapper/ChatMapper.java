package com.pj2.shoecream.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.pj2.shoecream.vo.ChatRoomVO;
import com.pj2.shoecream.vo.ChatMsgVO;



@Mapper
public interface ChatMapper {
	
	int insertChat(ChatMsgVO chat);
	int insertChatRoom(ChatRoomVO chatRoom);
	List<ChatRoomVO> selectChatRoomList();
	List<ChatMsgVO> selectChatList(int room_id);
	ChatRoomVO selectChatRoom(int room_id);
}
