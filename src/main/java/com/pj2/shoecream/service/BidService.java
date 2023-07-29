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
		return mapper.selectBidPrice(auction_idx);
	}

	//입찰하기
	public int insertBidList(Map<String, Object> map) {
		return mapper.insertBidList(map);
	}

	public static Map<String, Object> getBidDetail(String auction_idx) {
		return null;
	}

}