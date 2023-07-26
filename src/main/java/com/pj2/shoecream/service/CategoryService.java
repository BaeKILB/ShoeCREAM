package com.pj2.shoecream.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pj2.shoecream.mapper.CategoryMapper;

@Service
public class CategoryService {
	
	@Autowired
	private CategoryMapper mapper;

  public List<Map<String, Object>> getLcList() {
    return mapper.selectLcList();
  }

  public List<Map<String, Object>> getMcList(int code) {
    return mapper.selectMcList(code);
  }

  public List<Map<String, Object>> getScList(int code) {
    return mapper.selectScList(code);
  }
	

}
