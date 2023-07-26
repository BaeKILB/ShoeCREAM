package com.pj2.shoecream.vo;

import java.util.Date;

import lombok.Data;

@Data
public class AuctionVO {
	private int auc_start_price; //경매 시작가
	private int auc_buy_instantly; //즉시구매가
	private int auc_bid_unit; //입찰단위
	private Date auc_regist_date; //경매등록일
	private Date auc_close_date; //경매 마감일
	private String auc_state; //상태코드 ex)판매중,마감,결제대기
}
