package com.pj2.shoecream.vo;

import lombok.Data;

/*
 회원 인증 정보를 관리하는 auth_info 테이블 정의
 ---------------------------------------
 아이디(id) - 16글자, UN, NN
 인증코드(auth_code) - 50글자, NN
 ---------------------------------------
 CREATE TABLE auth_info (
 	id VARCHAR(16) UNIQUE NOT NULL,
 	auth_code VARCHAR(50) NOT NULL
 );
 */
@Data
public class AuthInfoVO {
	private String id;
	private String auth_code;
}

















