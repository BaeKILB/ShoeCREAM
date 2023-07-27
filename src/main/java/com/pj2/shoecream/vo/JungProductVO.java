package com.pj2.shoecream.vo;

import java.sql.Timestamp;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class JungProductVO {

	//===============================중고 jung_product=========================================
	
	private int product_price; // 상품 가격
	private String product_status; //상품 물건상태(중고,미개봉)
	private String product_sell_status; //상품 판매 상황
	private String product_location; //상품 판매 지역

	
	//================================중고,경매 product=========================================
	
	
	private String product_idx; // 상품코드
	private int mem_idx;	// 회원 번호; 판매자
	private String product_title; // 상품 명
	private String product_info; // 상품 정보
	private String product_payment; //결제수단
	private int lc_code; // 대분류
	private int mc_code; // 중분류
//	private int sc_code; // 소분류
	private Timestamp product_date; //작성시간
	private int product_readcount; //조회수
	private String product_brand; //브랜드
	private int product_size; //사이즈
	private int product_selector; //상품 분류코드


	//============================파일=====================================
	// 파일명을 저장할 변수 선언
	private String image1;
	private String image2;
	private String image3;
	private String image4;
	// 주의! 폼에서 전달받는 실제 파일 자체를 다룰 MultipartFile 타입 변수 선언도 필요
	// => 이 때, 멤버변수명은 input type="file" 태그의 name 속성명(파라미터명)과 동일해야함
	private MultipartFile file1;
	private MultipartFile file2;
	private MultipartFile file3;
	private MultipartFile file4;
	
	//파일 경로 저장
	private String image_path;
	
	
}
