package com.pj2.shoecream.mapper;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface PayMapper {
	// 상품 idx 로 결제 정보가 있는지 조회
	int selectCountPayInfo(String product_idx);
	
}
