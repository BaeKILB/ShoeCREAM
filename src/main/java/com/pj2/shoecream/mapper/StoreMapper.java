package com.pj2.shoecream.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;


@Mapper
public interface StoreMapper {
	

	
	// 중고거래 판매 내역
	List<Map<String, Object>> selectProductSellList(int mem_idx);
	
	// 경매등록 내역
	List<Map<String, Object>> selectAuctionList(int mem_idx);
	
	// 찜 내역
	List<Map<String, Object>> selectDibList(int mem_idx);
	
	
	
    // 상점 개인 페이지 정보 조회
	Map<String, Object> selectStoreInfo(int mem_idx);
	
	// 중고 리뷰 조회
	List<Map<String, Object>> selectJungReviewList(int mem_idx);


}
