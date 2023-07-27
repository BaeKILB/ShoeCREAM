package com.pj2.shoecream.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.pj2.shoecream.vo.AuctionVO;

@Mapper
public interface AuctionMapper {

	int insertAuctionItem(AuctionVO auction);

}
