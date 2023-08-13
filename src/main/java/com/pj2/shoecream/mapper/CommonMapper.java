package com.pj2.shoecream.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface CommonMapper {

	void insertDeliveryInfo(Map<String, Object> map);

	Map<String, Object> selectDeliveryInfo(int mem_idx);

	void updateDeliveryInfo(Map<String, Object> map);
}
