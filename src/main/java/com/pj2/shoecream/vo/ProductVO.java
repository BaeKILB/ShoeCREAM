package com.pj2.shoecream.vo;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class ProductVO {
	//================================중고,경매 product=========================================
	
	
	private int product_idx; // 상품코드
	private int mem_idx;	// 회원 번호; 판매자
	private String product_title; // 상품 명
	private String product_info; // 상품 정보
	private String product_payment; //결제수단
	private int lc_code; // 대분류
	private int mc_code; // 중분류
	private int sc_code; // 소분류
	private Timestamp product_date; //작성시간
	private int product_readcount; //조회수
	private String product_brand; //브랜드
	private int product_size; //사이즈
	private int product_selector; //상품 분류코드

}
