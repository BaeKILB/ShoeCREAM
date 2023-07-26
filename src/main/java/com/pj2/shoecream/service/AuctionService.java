package com.pj2.shoecream.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pj2.shoecream.mapper.AuctionMapper;

@Service
public class AuctionService {
	
	@Autowired
	private AuctionMapper mapper;
	
	public int AuctionRegist(Map<String, Object> map) {
		return mapper.insertAuctionItem(map);
	}


}
