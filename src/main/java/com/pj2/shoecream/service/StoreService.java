package com.pj2.shoecream.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pj2.shoecream.mapper.StoreMapper;

@Service
public class StoreService {
	
	@Autowired
	private StoreMapper mapper;
   

	
	// 중고거래 판매 내역
	public List<Map<String, Object>> selectProductSellList(int mem_idx) {
		return mapper.selectProductSellList(mem_idx);
	}

	// 경매 등록 내역
	public List<Map<String, Object>> selectAuctionList(int mem_idx) {
	    return mapper.selectAuctionList(mem_idx);
	}
	
    // 찜 내역
	public List<Map<String, Object>> selectDibList(int mem_idx) {
	    return mapper.selectDibList(mem_idx);
	}
	
	// 상점 개인 페이지 정보 조회
    public Map<String, Object> selectStoreInfo(int mem_idx) {
        return mapper.selectStoreInfo(mem_idx);
    }
    
    // 중고 리뷰 조회
	public List<Map<String, Object>> selectJungReivewList(int mem_idx) {
	    return mapper.selectJungReviewList(mem_idx);
	}
    

}
