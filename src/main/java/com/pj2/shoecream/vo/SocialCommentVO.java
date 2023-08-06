package com.pj2.shoecream.vo;

import java.sql.Date;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import lombok.Data;

@Data
public class SocialCommentVO {
	private int comment_idx;
	private int mem_idx;
	@NotNull
	private int posts_idx;
	private String mem_nickname;
	@NotBlank
	private String comment_content;
	private int comment_re_ref;
	private int comment_re_lev;
	private int comment_re_seq;
	private Date comment_date;
//	private Timestamp comment_date;
	
	private String mem_profileImageUrl;

}
