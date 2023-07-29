package com.pj2.shoecream.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pj2.shoecream.mapper.AuctionMapper;

@Service
public class BidService {
	
	@Autowired
	private AuctionMapper mapper;

	public String getBidPrice(String auction_idx) {
		// TODO Auto-generated method stub
		return mapper.selectBidPrice(auction_idx);
	}

	public int insertBidList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return mapper.insertBidList(map);
	}

}