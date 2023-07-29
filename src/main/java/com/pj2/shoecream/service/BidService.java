package com.pj2.shoecream.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pj2.shoecream.mapper.BidMapper;

@Service
public class BidService {
	
	@Autowired
	private BidMapper mapper;

	//입찰하기
	public int insertBidList(Map<String, Object> map) {
	    return mapper.insertBidList(map);
	}

	public Map<String, Object> getBid(String auction_idx) {
	    return mapper.selectBid(auction_idx);
	}

}