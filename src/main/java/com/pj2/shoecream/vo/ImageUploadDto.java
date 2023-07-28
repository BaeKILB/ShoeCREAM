package com.pj2.shoecream.vo;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class ImageUploadDto {
	private MultipartFile file;
	private String posts_content;
}
