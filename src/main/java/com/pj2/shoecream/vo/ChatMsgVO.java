package com.pj2.shoecream.vo;

import java.sql.Timestamp;

import lombok.Data;


@Data
public class ChatMsgVO {
	private int chat_msg_idx;
	private int chat_room_idx;
	private int mem_idx;
	private String chat_msg_content;
	private Timestamp chat_msg_date;
    
}
