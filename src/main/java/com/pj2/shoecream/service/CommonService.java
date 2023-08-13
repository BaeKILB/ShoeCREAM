package com.pj2.shoecream.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pj2.shoecream.mapper.CommonMapper;

@Service
public class CommonService {

	@Autowired
	private CommonMapper mapper;
	
	public void registDeliveryInfo(Map<String, Object> map) {
		mapper.insertDeliveryInfo(map);
	}
	
	public Map<String, Object> getDeliveryInfo(int mem_idx) {
		return mapper.selectDeliveryInfo(mem_idx);
	}

	public void updateDeliveryInfo(Map<String, Object> map) {
		mapper.updateDeliveryInfo(map);
	}

}
