package com.pj2.shoecream.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pj2.shoecream.mapper.CreamMapper;
import com.pj2.shoecream.vo.CreamVO;

@Service
public class CreamService {
	
	@Autowired
	private CreamMapper mapper;
	
	//크림 등록
	public int registCreamItem(CreamVO cream) {
		return mapper.insertCreamItem(cream);
		
	}

	//크림 리스트 파일까지 다 들고옴
	public List<Map<String, Object>> getCreamList(Map<String, Object> map) {
		return mapper.selectCreamList(map);
	}

	public int updateReadCount(String cream_idx) {
		return mapper.updateItemReadCount(cream_idx);
	}

	public Map<String, Object> getCream(String cream_idx) {
		return mapper.selectCream(cream_idx);
	}

	public Map<String, Object> getCreamDibs(Map<String, Object> map) {
		return mapper.selectCreamDibs(map);
	}

	public int getDibsCount(Map<String, Object> map) {
		return mapper.selectDibsCount(map);
	}


}
