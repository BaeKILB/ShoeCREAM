package com.pj2.shoecream.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class AuctionVO {
    private String auction_idx; // 상품 코드
    private int mem_idx; // 판매자 회원 번호
    private String auction_title; // 제목
    private String auction_info; // 상세내용
    private String auction_payment; // 결제방법
    private int lc_code; // 대분류
    private int mc_code; // 중분류
//    private int sc_code; // 소분류
    private Date auction_date; // 작성시간
    private int auction_readcount; // 조회수
    private String auction_brand; // 브랜드
    private int auction_size; // 사이즈
    private int auction_selector; // 상품 분류코드; 0 중고 1 경매 2 크림
    private int auc_start_price; // 경매시작가
    private int auc_buy_instantly; // 즉시구매가
    private int auc_bid_unit; // 입찰단위
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
    private Date auc_regist_date; // 경매등록일
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
    private Date auc_close_date; // 경매등록일
    private String auc_state; // 상태코드
    
    // 신규 추가하신것
    private int currentPrice; //현재가격 (bid_price 의 최대값 없으면 시작가)
    private int bidCcount; //입찰수
    private int deposit; //보증금
    private String mem_nickname; //판매자 닉넴
}
