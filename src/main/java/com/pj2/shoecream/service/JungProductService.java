package com.pj2.shoecream.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pj2.shoecream.mapper.JungProductMapper;
import com.pj2.shoecream.vo.JungProductVO;

@Service
public class JungProductService {
	@Autowired
	private JungProductMapper mapper;
	
	public JungProductVO getJungProduct(int product_idx) {
		return mapper.selectJungProductChat(product_idx);
	}
}
