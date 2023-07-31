package com.pj2.shoecream.vo;

import com.google.protobuf.Timestamp;

import lombok.Data;

@Data
public class DidListVO {
	private String auction_idx;
	private String mem_idx;
	private int bid_price;
	private Timestamp bid_date;
	private int deposit;
	private String bid_state;
	
}
