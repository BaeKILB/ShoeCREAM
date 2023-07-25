package com.pj2.shoecream.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.pj2.shoecream.vo.ChatRoomVO;
import com.pj2.shoecream.vo.ChatMsgVO;



@Mapper
public interface ChatMapper {
	
	int insertChat(ChatMsgVO chat);
	int insertChatRoom(ChatRoomVO chatRoom);
	List<ChatRoomVO> selectChatRoomListSeller(@Param("mem_idx") int mem_idx,@Param("chat_room_area") String chat_room_area);
	List<ChatRoomVO> selectChatRoomListBuyer(@Param("mem_idx") int mem_idx,@Param("chat_room_area") String chat_room_area);
	List<ChatMsgVO> selectChatList(int chat_room_idx);
	ChatRoomVO selectChatRoom(int chat_room_idx);
	int selectChatCheckAuth(@Param("mem_idx") int mem_idx,@Param("chat_room_idx") int chat_room_idx);
}
