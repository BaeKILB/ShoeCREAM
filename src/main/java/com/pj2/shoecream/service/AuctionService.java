package com.pj2.shoecream.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pj2.shoecream.mapper.AuctionMapper;
import com.pj2.shoecream.vo.AuctionVO;

@Service
public class AuctionService {
	
	@Autowired
	private AuctionMapper mapper;
	
	public int auctionRegist(AuctionVO auction) {
		return mapper.insertAuctionItem(auction);
	}

	public List<Map<String, Object>> auctionList(Map<String, Object> map) {
		return mapper.selectAuctionList(map);
	}


}
