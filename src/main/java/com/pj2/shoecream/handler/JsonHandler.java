package com.pj2.shoecream.handler;

import java.util.Map;

import org.json.JSONObject;
import org.springframework.stereotype.Component;

import com.pj2.shoecream.vo.PageInfoVO;

@Component
public class JsonHandler {
	
	// Map<String,String> 데이터를 JSONObject 로 변환
	public JSONObject map2Json(Map<String,String> map) {
		JSONObject jo = new JSONObject();
		map.forEach((key,val) -> {
			jo.put(key, val);
		});
		return jo;
	}
	

	public boolean pageInfo2JsonObj(JSONObject jsonObj, PageInfoVO pageInfo) {
		jsonObj.put("endPage", pageInfo.getEndPage());			
		jsonObj.put("listCount", pageInfo.getListCount());			
		jsonObj.put("pageListLimit", pageInfo.getPageListLimit());			
		jsonObj.put("startPage", pageInfo.getStartPage());			
		jsonObj.put("maxPage", pageInfo.getMaxPage());			
		
		return true;
	}

	public boolean jsonMap2PageInfo(Map<String,Object> jsonMap, PageInfoVO pageInfo) {
		pageInfo.setEndPage(Integer.parseInt((String)jsonMap.get("endPage")));
		pageInfo.setListCount(Integer.parseInt((String)jsonMap.get("listCount")));
		pageInfo.setPageListLimit(Integer.parseInt((String)jsonMap.get("pageListLimit")));
		pageInfo.setStartPage(Integer.parseInt((String)jsonMap.get("startPage"))); 
		pageInfo.setMaxPage(Integer.parseInt((String)jsonMap.get("maxPage")));
		
		return true;
	}
}
