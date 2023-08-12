package com.pj2.shoecream.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

public interface SchedulerMapper {

	List<Map<String, Object>> selectTrackingList();

	void updateTracking(@Param("trackingNumber") String trackingNumber,@Param("kind") String kind);

}
