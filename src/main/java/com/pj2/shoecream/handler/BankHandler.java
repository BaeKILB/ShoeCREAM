package com.pj2.shoecream.handler;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Component;

@Component
public class BankHandler {
	
	private Map<String, String> bankMap = new HashMap<String,String>();
	
	public BankHandler() {
		bankMap.put("002", "KDB 산업은행");  	
		bankMap.put("003", "IBK 기업은행"); 	
		bankMap.put("004", "KB 국민은행") ;	
		bankMap.put("007", "수협은행") 	;
		bankMap.put("011", "NH 농협은행") ;	
		bankMap.put("020", "우리은행");
		bankMap.put("023", "SC 제일은행");
		bankMap.put("027", "한국씨티은행"); 
		bankMap.put("031", "대구은행")	;
		bankMap.put("032", "부산은행")	;
		bankMap.put("034", "광주은행")	;
		bankMap.put("035", "제주은행")	;
		bankMap.put("037", "전북은행");
		bankMap.put("039", "경남은행");
		bankMap.put("081", "하나은행");
		bankMap.put("088", "신한은행");
		bankMap.put("089", "케이뱅크");
		bankMap.put("090", "카카오뱅크");
		bankMap.put("097", "오픈은행");
	}
	
	public String bankCode2BankName(String bankCode) {
		return bankMap.get(bankCode);
	}
}
