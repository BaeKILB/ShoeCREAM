package com.pj2.shoecream.vo;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;
@Data
public class NoticeVO {
	private int bo_idx;
	private String bo_title;
	private String bo_content;
	private Date bo_sysdate;
	private int bo_readcount;
	
	// 파일명을 저장할 변수 선언
	private String bo_file1;
	private String bo_file2;
	private String bo_file3;
	
	private MultipartFile file1;
	private MultipartFile file2;
	private MultipartFile file3;
	
}


