package com.pj2.shoecream.vo;

import java.util.Date;

import lombok.Data;

@Data
public class CreamRequestVO {
	private int request_idx;
	private int mem_idx;
	private String cream_idx;
	private String cream_title;
	private String cream_size;
	private int cream_price;
	private String delivery_status;
	private String tracking_company;
	private String tracking_num;
	private Date request_time;
}
