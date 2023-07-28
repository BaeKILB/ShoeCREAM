package com.pj2.shoecream.vo;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class SocialVO {
	private int posts_idx;
	private int mem_idx;
	private String mem_nickname;
//	private String posts_title;
	private String posts_content;
	private Date posts_date;
	
	private String posts_image1;
	private String posts_image2;
	private String posts_image3;
	private String posts_image4;
	
	private MultipartFile file1;
	private MultipartFile file2;
	private MultipartFile file3;
	private MultipartFile file4;
	
	
//	@JoinColumn(name="userId")
//	@ManyToOne
//	private MemberVO member;
	
	// 이미지 좋아요
	
	// 댓글
}
