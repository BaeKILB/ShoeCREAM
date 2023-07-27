package com.pj2.shoecream.vo;

import java.util.HashSet;
import java.util.Set;
import org.springframework.web.socket.WebSocketSession;

import lombok.Data;


@Data
public class ChatRoomVO {
	private int chat_room_idx;
	private String product_idx;
	private int mem_seller_idx;
	private int mem_buyer_idx;
	private int chat_room_area;

	private Set<WebSocketSession> sessions = new HashSet<>();
	
}
