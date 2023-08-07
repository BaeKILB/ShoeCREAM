package com.pj2.shoecream.vo;

import java.util.List;

import lombok.Data;

// 2.5. 이체서비스 - 2.5.2. 입금이체 API 응답 데이터를 관리하는 클래스 정의
@Data
public class ResponseDepositVO {
	private String api_tran_id;
	private String api_tran_dtm;
	private String rsp_code;
	private String rsp_message;
	private String wd_bank_code_std;
	private String wd_bank_code_sub;
	private String wd_bank_name;
	private String wd_account_num_masked;
	private String wd_print_content;
	private String wd_account_holder_name;
	private String res_cnt;
	private List<DepositInfoVO> res_list;
}














