package com.pj2.shoecream.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.pj2.shoecream.vo.CreamVO;

@Mapper
public interface CreamMapper {

	int insertCreamItem(CreamVO cream);

	List<Map<String, Object>> selectCreamList(Map<String, Object> map);


	int updateItemReadCount(String cream_idx);

	Map<String, Object> selectCream(String cream_idx);

	Map<String, Object> selectCreamDibs(Map<String, Object> map);

	int selectDibsCount(Map<String, Object> map);

	void insertDibs(Map<String, Object> map);

	void deleteDibs(Map<String, Object> map);

	void insertCreamItemRequest(Map<String, Object> map);

	int insertTrackingNumber(Map<String, Object> map);

	void modifyCream(Map<String, Object> map);

	Map<String, Object> selectCreamOrderDetail(Integer request_idx);

	int getTrackingStatus(String request_idx);

	int updateCIR(Map<String, Object> map);

	List<Map<String, Object>> selectRelatedCreamList(Map<String, Object> map);

	List<Map<String, Object>> selectReviewList(String cream_idx);



}
