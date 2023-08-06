package com.pj2.shoecream.vo;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class PayInfoVO {
	private int pay_idx	;
	private String product_idx;
	private int pay_method;
	private int pay_total;
	private String pay_status;
	private Timestamp pay_time;
	private Timestamp cancel_trade_date;
	private String cancel_trade_reason;
	private int cancel_pay;
	private Integer point_idx;
	private Timestamp trans_date;	
}
