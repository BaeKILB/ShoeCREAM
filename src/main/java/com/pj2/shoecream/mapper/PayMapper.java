package com.pj2.shoecream.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.pj2.shoecream.vo.PayInfoVO;
import com.pj2.shoecream.vo.PointInoutVO;

@Mapper
public interface PayMapper {
	
	PayInfoVO selectGetPayInfoTop(String product_idx);
	
	// 크림의 경우 사용
	PayInfoVO selectGetPayInfoIdx(
			@Param("product_idx") String product_idx
			,@Param("mem_buyer_idx") int mem_buyer_idx
			);
	
	int updateMemberPoint(
			@Param("mem_idx") int mem_idx
			,@Param("charge_point") int charge_point
	);
	
	int insertPayInfo(PayInfoVO payInfo);
	int insertPointInout(PointInoutVO pointInout);
	
}
