package com.pj2.shoecream.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.pj2.shoecream.vo.AuctionVO;

@Mapper
public interface AuctionMapper {

	int insertAuctionItem(AuctionVO auction);

	List<Map<String, Object>> selectAuctionList();

}
