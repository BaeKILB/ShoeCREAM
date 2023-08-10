package com.pj2.shoecream.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pj2.shoecream.mapper.BankMapper;
import com.pj2.shoecream.vo.ResponseTokenVO;

@Service
public class BankService {
	@Autowired
	private BankMapper mapper;

	// 유저 통장 토큰, 핀테크 사용 번호 db 저장
	public boolean registAccount(Map<String,Object> account) {
		return mapper.insertMemAccount(account) > 0; 
	}

	// 토큰 정보 조회 요청
	public ResponseTokenVO getToken(String id) {
		return mapper.selectToken(id);
	}

	// 토큰 정보 조회 요청 - JOIN 구문 활용
	public ResponseTokenVO getTokenForBankAuth(String id) {
		return mapper.selectTokenForBankAuth(id);
	}

}











