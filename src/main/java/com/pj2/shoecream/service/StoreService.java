package com.pj2.shoecream.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pj2.shoecream.mapper.StoreMapper;
import com.pj2.shoecream.vo.CreamRequestVO;

@Service
public class StoreService {
	
	@Autowired
	private StoreMapper mapper;
   

	
	// 중고거래 판매 내역
	public List<Map<String, Object>> selectProductSellList(int mem_idx) {
		return mapper.selectProductSellList(mem_idx);
	}
	
	// 중고거래 구매내역
	public List<Map<String, Object>> selectProductBuyList(int mem_idx) {
		return mapper.selectProductBuyList(mem_idx);
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
    
    // 모든 리뷰 조회
	public List<Map<String, Object>> selectJungReivewList(int mem_idx) {
	    return mapper.selectJungReviewList(mem_idx);
	}

	// 경매 참여내역
	public List<Map<String, Object>> selectAuctionBidList(int mem_idx) {
		return mapper.selectAuctionBidList(mem_idx);
	}

	// 크림 구매내역
	public List<CreamRequestVO> selectCreamList(int mem_idx) {
		return mapper.selectCreamList(mem_idx);
	}
	

    

}
