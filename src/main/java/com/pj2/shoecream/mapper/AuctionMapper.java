package com.pj2.shoecream.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.pj2.shoecream.vo.AuctionVO;

@Mapper
public interface AuctionMapper {

	int insertAuctionItem(AuctionVO auction);

	List<Map<String, Object>> selectAuctionList(Map<String, Object> map);

	Map<String, Object> selectAuction(String auction_idx);
  
	int updateItemReadCount(String auction_idx);

	Map<String, Object> selectAuctionDibs(Map<String, Object> map);

	void insertDibs(Map<String, Object> map);

	void deleteDibs(Map<String, Object> map);

	int selectDibsCount(Map<String, Object> map);

	Map<String, Object> selectSellerInfo(int mem_idx);

}
