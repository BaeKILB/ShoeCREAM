package com.pj2.shoecream.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.pj2.shoecream.vo.ChatRoomVO;
import com.pj2.shoecream.vo.ChatMsgVO;



@Mapper
public interface ChatMapper {
	int insertChat(Map<String,String> chat);
	int insertChatRoom(ChatRoomVO chatRoom);
	
	// 채팅방 가져오기
	List<Map<String,Object>> selectChatRoomList(@Param("mem_idx") int mem_idx,
			@Param("chat_room_area") int chat_room_area);
	List<Map<String,Object>> selectChatRoomListSeller(@Param("mem_idx") int mem_idx,
			@Param("chat_room_area") int chat_room_area);
	List<Map<String,Object>> selectChatRoomListBuyer(@Param("mem_idx") int mem_idx,
			@Param("chat_room_area") int chat_room_area);
	List<Map<String,Object>> selectChatList(int chat_room_idx);
	
	Map<String,Object> selectChatRoom(@Param("chat_room_idx") int chat_room_idx,@Param("chat_room_area") int chat_room_area);
	ChatRoomVO selectChatRoomProductIdx(@Param("product_idx") String product_idx,@Param("mem_idx") int mem_idx);
	
	Integer selectChatCheckAuth(@Param("mem_idx") int mem_idx,
			@Param("chat_room_idx") int chat_room_idx);
	
	// 채팅방 설정값 업데이트
	int updateChatRoomArea(@Param("chat_room_idx") int chat_room_idx , @Param("chat_room_area") int chat_room_area);
	int updateChatRoomSellerIdx(@Param("chat_room_idx") int chat_room_idx, @Param("mem_seller_idx") int mem_seller_idx);
	int updateChatRoomBuyerIdx(@Param("chat_room_idx") int chat_room_idx, @Param("mem_buyer_idx") int mem_buyer_idx);
	
	int deleteChatRoom(String chat_room_idx);
}
