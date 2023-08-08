package com.pj2.shoecream.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface BidMapper {
    // 입찰내역 넣기
    int insertBid(Map<String, Object> map);
    
    // 입찰정보 가져오기
    Map<String, Object> selectBid(String auction_idx);

    // 입찰횟수 가져오기
	int selectBidCount(String auction_idx);

	// 입찰정보 변경
	int updateBid(Map<String, Object> map);

	// 입찰내역 리스트 가져오기
	List<Map<String, Object>> selectBidList(String auction_idx);

	int insertBidBuyNow(Map<String, Object> map);
}
