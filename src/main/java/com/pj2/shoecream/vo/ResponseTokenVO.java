package com.pj2.shoecream.vo;

import lombok.Data;

// 2.1.2. 토큰발급 API 요청에 대한 응답데이터를 관리할 VO 객체
@Data
public class ResponseTokenVO {
	private String access_token;
	private String token_type;
	private String expires_in;
	private String refresh_token;
	private String scope;
	private String user_seq_no;
}
