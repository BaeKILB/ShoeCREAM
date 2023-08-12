package com.pj2.shoecream.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

public interface CourierMapper {

	List<Map<String, Object>> selectCourierList();

	void updateCourier(@Param("trackingNumber") String trackingNumber,@Param("kind") String kind);

	Map<String, Object> selectCourier(String auction_idx);

}
