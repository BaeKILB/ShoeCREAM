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
	private String file1;
	private String file2;
	private String file3;
	private MultipartFile bo_file1;
	private MultipartFile bo_file2;
	private MultipartFile bo_file3;
	
}


