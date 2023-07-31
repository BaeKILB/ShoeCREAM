package com.pj2.shoecream.vo;



import java.sql.*;
import java.sql.Timestamp;

import org.springframework.web.multipart.*;

import lombok.Data;



@Data
public class JungGoNohVO {
	//===============================중고 jung_product=========================================
	
		private int product_price; // 상품 가격(천원단위당 쉼표 표시)
		private String product_status; //상품 물건상태(중고,미개봉)
		private String product_sell_status; //상품 판매 상황
		private String product_location; //상품 판매 지역

		
		//================================중고,경매 product=========================================
		
		private String product_idx;// 상품 코드
		private int mem_idx;	// 회원 번호; 판매자 식별 번호
		private String mem_id; // 회원 id, 판매자
		private String mem_nickname;
		private String mem_rank;
		private String mem_profileImageUrl;
		private String buyier; // 회원 id, 사는 사람, 접속한 사람
		private int buyier_idx;	// 회원 번호; 사는 사람, 접속한 사람 식별 번호
		private String product_title; // 상품 명
		private String product_info; // 상품 정보
		private String product_payment; //결제수단
		private int lc_code; // 대분류
		private int mc_code; // 중분류
		//private int sc_code; // 소분류 사라짐. 
		private Timestamp product_date; //작성시간
		private int product_readcount; //조회수
		private String product_brand; //브랜드
		private int product_size; //사이즈
		private int product_selector; //상품 분류코드

		
		//====================================그 이외 필요한 VO==================================
		
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
			
			
		
		//================================찜======================================
		
			private int dibs_idx; //찜코드
			//상품코드(위에 상품코드VO 재활용)
			private int memFav_idx; //찜 해당 멤버(지금 접속중인 아이디, 상품등록자 말고)
			private String favorite_check; //찜 체크(찜한 여부)
			private int dibs_count; // 물건 당 찜 갯수
		//===============================리뷰=====================================
			private int review_idx; //리뷰코드
			private String review_id; //리뷰어 아이디
			private String seller_id; //리뷰 대상 아이디
			private String review_content; //리뷰 내용
			private Timestamp review_date; //리뷰 날짜
			private int review_score; // 리뷰 점수
			private String review_type; // 리뷰 타입(중고,경매,크림)
		//===============================신고===================================
			
			private int report_idx; //신고코드
			private String report_content; //신고 내용
			//신고대상자(파는 사람 위에 VO에서 재활용
			
		//==============================필터링==================================
		private String trashArr[] = {"미친", "욕", "나쁜말"};


}


























