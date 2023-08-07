package com.pj2.shoecream.service;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pj2.shoecream.mapper.CreamMapper;
import com.pj2.shoecream.vo.CreamVO;

@Service
public class CreamService {
	
	@Autowired
	private CreamMapper mapper;
	
	public int registCreamItem(CreamVO cream) {
		return mapper.insertCreamItem(cream);
		
	}

	public int registCreamOption(CreamVO cream) {
		return mapper.insertCreamOption(cream);
		
	}


}
