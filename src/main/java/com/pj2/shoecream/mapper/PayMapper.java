package com.pj2.shoecream.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.pj2.shoecream.vo.PayInfoVO;
import com.pj2.shoecream.vo.PointInoutVO;

@Mapper
public interface PayMapper {
	
	PayInfoVO selectGetPayInfoTop(String product_idx);
	
	int updateMemberPoint(
			@Param("mem_idx") int mem_idx
			,@Param("point") int point
	);
	
	int insertPayInfo(PayInfoVO payInfo);
	int insertPointInout(PointInoutVO pointInout);
}
