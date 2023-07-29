package com.pj2.shoecream.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.pj2.shoecream.vo.AuctionVO;

@Mapper
public interface AuctionMapper {

	int insertAuctionItem(AuctionVO auction);

	List<Map<String, Object>> selectAuctionList(Map<String, Object> map);

	Map<String, Object> selectAuction(String auction_idx);
  
	//입찰금액 받아옴
	String selectBidPrice(String auction_idx);

	//입찰내역 넣기
	int insertBidList(Map<String, Object> map);

}
