package com.pj2.shoecream.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pj2.shoecream.mapper.BidMapper;

@Service
public class BidService {
	
	@Autowired
	private BidMapper mapper;

	//입찰하기
	public int insertBid(Map<String, Object> map) {
//		Map<String, Object> bid = getBid((String)map.get("auction_idx"));
//		if (bid == null) {
			return mapper.insertBid(map);
//		}else {
//			// 기존의 입찰을 유찰로 변경
//			mapper.updateBid(map);
//			// 보증금 돌려주는 로직 2023-07-30 11:11
//			
//			return mapper.insertBid(map);
//		}
	}

	public Map<String, Object> getBid(String auction_idx) {
	    return mapper.selectBid(auction_idx);
	}

	public int getBidCount(String auction_idx) {
		return mapper.selectBidCount(auction_idx);
	}

	public List<Map<String, Object>> getBidList(String auction_idx) {
		return mapper.selectBidList(auction_idx);
	}

	public int modifyBid(Map<String, Object> map) {
		return mapper.updateBid(map);
	}
	// 즉시구매
	public int insertBidBuyNow(Map<String, Object> map) {
		return mapper.insertBidBuyNow(map);
	}

}