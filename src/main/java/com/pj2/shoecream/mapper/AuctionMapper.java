package com.pj2.shoecream.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface AuctionMapper {

	int insertAuctionItem(Map<String, Object> map);

}
