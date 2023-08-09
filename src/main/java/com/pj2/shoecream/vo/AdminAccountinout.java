package com.pj2.shoecream.vo;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class AdminAccountinout {
	   private int admin_account_idx;
	   private int mem_idx;
	   private int tran_amount;
	   private String tran_type;
	   private Timestamp tran_date;
	   private int admin_account_balance;
}
