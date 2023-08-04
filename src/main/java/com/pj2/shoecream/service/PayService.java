package com.pj2.shoecream.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pj2.shoecream.mapper.PayMapper;
import com.pj2.shoecream.vo.PayInfoVO;

@Service
public class PayService {
	
	@Autowired
	private PayMapper mapper;
	
	public int withdrawPoints(int mem_idx , int price) {
		return -1;
	}
	
}
