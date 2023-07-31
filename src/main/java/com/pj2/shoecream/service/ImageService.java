package com.pj2.shoecream.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pj2.shoecream.mapper.ImageMapper;
import com.pj2.shoecream.vo.ProductImageVO;

@Service
public class ImageService {

	@Autowired
	private ImageMapper mapper;
	
	public int registProductImage(ProductImageVO image) {
		return mapper.insertProductImage(image);
	}
	
	public int modifyProductImage(ProductImageVO image) {
		return mapper.modifyProductImage(image);
	}
	
}
