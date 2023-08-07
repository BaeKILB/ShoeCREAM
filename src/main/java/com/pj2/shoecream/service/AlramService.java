package com.pj2.shoecream.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pj2.shoecream.mapper.AlramMapper;
import com.pj2.shoecream.vo.AlramVO;

@Service
public class AlramService {

	@Autowired
	private AlramMapper mapper;
	
	public int registerAlram(AlramVO alram) {
		return mapper.insertAlram(alram);
	}

	
	
}
