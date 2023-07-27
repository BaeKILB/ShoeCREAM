package com.pj2.shoecream.vo;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;
@Data
public class ProductImageVO {
	private String product_idx;
	private MultipartFile image1;
	private MultipartFile image2;
	private MultipartFile image3;
	private MultipartFile image4;
	private String image1_name;
	private String image2_name;
	private String image3_name;
	private String image4_name;
	private String image_path;
}


