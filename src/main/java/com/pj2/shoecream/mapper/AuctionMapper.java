package com.pj2.shoecream.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.pj2.shoecream.vo.AuctionVO;
import com.pj2.shoecream.vo.MemberVO;

@Mapper
public interface AuctionMapper {

	int insertAuctionItem(AuctionVO auction);

	int modifyAuctionItem(AuctionVO auction);
	
	List<Map<String, Object>> selectAuctionList(Map<String, Object> map);

	Map<String, Object> selectAuction(String auction_idx);
  
	int updateItemReadCount(String auction_idx);

	Map<String, Object> selectAuctionDibs(Map<String, Object> map);

	void insertDibs(Map<String, Object> map);

	void deleteDibs(Map<String, Object> map);

	int selectDibsCount(Map<String, Object> map);

	// member service로 옮겨야함
	Map<String, Object> selectSellerInfo(int mem_idx);

	void updateAuctionState(String auction_idx);

	List<Map<String, Object>> selectSellerItems(int mem_idx);

	List<Map<String, Object>> selectRelatedAuctionList(Map<String, Object> map);

	MemberVO getMember(int mem_idx);

	// member service로 옮겨야함
	MemberVO selectMember(int mem_idx);

	boolean deleteAuction(String auction_idx);

	boolean deleteImage(String auction_idx);

	Map<String, Object> selectDeliveryInfo(int mem_idx);

	int insertTracking(Map<String, Object> map);


}
