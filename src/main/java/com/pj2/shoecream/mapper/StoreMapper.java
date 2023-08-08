package com.pj2.shoecream.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;


@Mapper
public interface StoreMapper {
	

	
	// 중고거래 판매 내역
	List<HashMap<String, Object>> selectProductSellList(int mem_idx);
	
	// 경매등록 내역
	List<HashMap<String, String>> selectAuctionList(int mem_idx);
	
	
	
	
	
    // 상점 개인 페이지 정보 조회
	HashMap<String, Object> selectStoreInfo(int mem_idx);
}
