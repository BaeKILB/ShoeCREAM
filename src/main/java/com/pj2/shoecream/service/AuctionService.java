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

    public Map<String, Object> getAuction(String auction_idx) {
	return mapper.selectAuction(auction_idx);
    }

    public int updateReadCount(String auction_idx) {
	return mapper.updateItemReadCount(auction_idx);
    }

	public Map<String, Object> getAuctionDibs(Map<String, Object> map) {
		return mapper.selectAuctionDibs(map);
	}

	public void registDibs(Map<String, Object> map) {
		mapper.insertDibs(map);
	}

	public void deleteDibs(Map<String, Object> map) {
		mapper.deleteDibs(map);
	}

	public int getDibsCount(Map<String, Object> map) {
		return mapper.selectDibsCount(map);
	}

	// member service 로 옮겨야함
	public Map<String, Object> getSellerInfo(int mem_idx) {
		return mapper.selectSellerInfo(mem_idx);
	}

}
