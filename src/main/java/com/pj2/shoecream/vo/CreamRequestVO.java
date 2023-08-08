package com.pj2.shoecream.vo;

import lombok.Data;

@Data
public class CreamRequestVO {
	private int request_idx;
	private int mem_idx;
	private String cream_idx;
	private String cream_size;
	private int cream_price;
	private String delivery_status;
}
