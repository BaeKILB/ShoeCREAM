package com.pj2.shoecream.vo;

import lombok.Data;

@Data
public class ReportVO {

	private int report_idx; //신고번호
	private String report_content; //신고내용
	private String product_idx; //상품번호
	private String seller_idx; //신고 대상자
	private String reporter_idx; //신고하는사람
	private String report_div; //신고유형
	private String report_detail; //상세사유
}
