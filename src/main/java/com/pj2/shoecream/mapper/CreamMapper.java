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


}
