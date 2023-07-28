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
	
	public int registAuctionItem(AuctionVO auction) {
		return mapper.insertAuctionItem(auction);
	}

	public List<Map<String, Object>> getAuctionList(Map<String, Object> map) {
		return mapper.selectAuctionList(map);
	}

  public Map<String, Object> getAuctionItem(String auction_idx) {
    return mapper.selectAuction(auction_idx);
  }


}
