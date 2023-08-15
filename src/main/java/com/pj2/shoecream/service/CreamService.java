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

	
	//이하 찜하기 관련
	public Map<String, Object> getCreamDibs(Map<String, Object> map) {
		return mapper.selectCreamDibs(map);
	}

	public int getDibsCount(Map<String, Object> map) {
		return mapper.selectDibsCount(map);
	}

	public void registDibs(Map<String, Object> map) {
		mapper.insertDibs(map);
		
	}

	public void deleteDibs(Map<String, Object> map) {
		mapper.deleteDibs(map);		
	}

	public void insertCreamDelivery(Map<String, Object> map) {
		mapper.insertCreamItemRequest(map);
		
	}

	public int registTracking(Map<String, Object> map) {
		return mapper.insertTrackingNumber(map);
	}

	public void modifyCream(Map<String, Object> map) {
		mapper.modifyCream(map);
		
	}

	public Map<String, Object> getCreamOrder(Integer request_idx) {
		return mapper.selectCreamOrderDetail(request_idx);
	}

	public int getTrackingNum(String request_idx) {
		return mapper.getTrackingStatus(request_idx);
	}

	public int updateTrackingNum(Map<String, Object> map) {
		return mapper.updateCIR(map);
	}

	public List<Map<String, Object>> getRelatedCreamList(Map<String, Object> map) {
		return mapper.selectRelatedCreamList(map);
	}





}
