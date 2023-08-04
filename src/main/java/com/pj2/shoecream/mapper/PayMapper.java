package com.pj2.shoecream.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface PayMapper {
	
	int updateMemberPoint(
			@Param("idx") int idx
			,@Param("idx") int price
	);
	
	
	
}
