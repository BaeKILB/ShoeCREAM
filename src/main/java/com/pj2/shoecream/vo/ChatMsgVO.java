package com.pj2.shoecream.vo;

import java.sql.Timestamp;

import lombok.Data;


@Data
public class ChatMsgVO {
	private int	chat_id;
    private int chat_room_idx;
    private String chat_writer;
    private String chat_content;
    private Timestamp chat_date;
}
