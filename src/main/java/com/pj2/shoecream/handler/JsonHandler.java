package com.pj2.shoecream.handler;

import java.util.Map;

import org.json.JSONObject;
import org.springframework.stereotype.Component;

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
}
