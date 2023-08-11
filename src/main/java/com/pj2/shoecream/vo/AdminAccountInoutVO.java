package com.pj2.shoecream.vo;

import java.sql.Timestamp;

import lombok.Data;


// tran_type : 입금인지 출금인지 확인 코드
// d : deposit (입금)
// w : withdraw (출금)

@Data
public class AdminAccountInoutVO {
	   private int admin_account_idx;
	   private int mem_idx;
	   private int tran_amount;
	   private String tran_type;
	   private Timestamp tran_date;
	   private Long admin_account_balance;
}
