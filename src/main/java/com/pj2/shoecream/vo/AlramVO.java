package com.pj2.shoecream.vo;

import java.util.Date;

import lombok.Data;

@Data
public class AlramVO {
	private int alram_idx;
	private String cmd;
	private int sender;
	private int receiver;
	private String product_idx;
	private String product_title;
	private String checked;
	private Date alram_date;
}
