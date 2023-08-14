package com.pj2.shoecream.vo;

import lombok.Data;

@Data
public class MemAccountVO {
	private int mem_account_idx;
	private String mem_idx;
	private String mem_name;
	private String mem_seq_no;
	private String access_token;
	private String refresh_token;
	private String bank_code_std;
	private String account_num;
	private String fintech_use_num;
	private Long balance_amt;
}
