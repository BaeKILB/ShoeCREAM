package com.pj2.shoecream.vo;

import java.sql.Date;

import lombok.Data;

@Data
public class SocialLikeVO {
	private int likes_idx;// AUTO_INCREMENT COMMENT '라이크 번호'
	private int posts_idx; //'좋아요를 누른 포스트의 회원번호(게시물)'
	private int mem_idx; // '좋아요를 누른 멤버(현재 로그인)'
	private Date likes_date; // '라이크 한 날짜'
}
