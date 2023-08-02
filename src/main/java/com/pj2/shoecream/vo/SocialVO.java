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
	
	private int likes_idx; // 소셜이 좋아요 불러올때 사용하자.
	private boolean likeState; // DB 저장 x 
	private int likeCount; 
	
//    public MemberVO toMemberVO() {
//        MemberVO member = new MemberVO();
//        member.setMem_id(mem_id);
//        member.setMem_passwd(mem_passwd);
//        member.setMem_email(mem_email);
//        member.setMem_name(mem_name);
//        return member;
//    }
	
//	@JoinColumn(name="userId")
//	@ManyToOne
//	private MemberVO member;
	
	// 이미지 좋아요
	
	// 댓글
}
