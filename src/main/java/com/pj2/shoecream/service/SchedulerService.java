package com.pj2.shoecream.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

import com.pj2.shoecream.mapper.SchedulerMapper;
import com.pj2.shoecream.vo.TrackingVO;

@Service
public class SchedulerService {

	@Autowired
	private SchedulerMapper mapper;
	
	@Value("${t_key}")
	private String key;
	
	@Value("${t_base_url}")
	private String baseUrl;
	
	private RestTemplate restTemplate;
	
	public List<Map<String, Object>> getTrackingList() {
		return mapper.selectTrackingList();
	}
	
	public TrackingVO requestTracking(Map<String, Object> map) {
		// 사용자정보조회 요청 API 의 URL 생성 - GET 방식
		String url = baseUrl + "/api/v1/trackingInfo";
		
		HttpHeaders httpHeaders = new HttpHeaders();
		
		HttpEntity<String> httpEntity = new HttpEntity<String>(httpHeaders);
		
		String t_code = String.valueOf(map.get("tracking_code"));
		String t_invoice = String.valueOf(map.get("tracking_num"));
		
		UriComponents uriComponents = UriComponentsBuilder.fromHttpUrl(url)
															.queryParam("t_code", t_code)
															.queryParam("t_invoice", t_invoice)
															.queryParam("t_key", key)
															.build();
		
		restTemplate = new RestTemplate();
		
		ResponseEntity<TrackingVO> responseEntity = 
				restTemplate.exchange(uriComponents.toString(), HttpMethod.GET, httpEntity, TrackingVO.class);
		
		return responseEntity.getBody();
	}

	public void modifyTracking(String trackingNumber, String kind) {
		mapper.updateTracking(trackingNumber,kind);
	}
	
	

}
