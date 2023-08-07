package com.pj2.shoecream.vo;

import lombok.Data;

// 사용자 계좌 1개 정보 관리
@Data
public class BankAccountVO {
	private String fintech_use_num;
	private String account_alias;
	private String bank_code_std;
	private String bank_code_sub;
	private String bank_name;
	private String savings_bank_name;
	private String account_num;
	private String account_num_masked;
	private String account_seq;
	private String account_holder_name;
	private String account_holder_type;
	private String inquiry_agree_yn;
	private String inquiry_agree_dtime;
	private String transfer_agree_yn;
	private String transfer_agree_dtime;
	private String account_state;
}
