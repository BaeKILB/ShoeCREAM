package com.pj2.shoecream.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pj2.shoecream.mapper.BankMapper;
import com.pj2.shoecream.vo.ResponseTokenVO;

@Service
public class BankService {
	@Autowired
	private BankMapper mapper;

	// 토큰 관련 정보 저장 요청
	public boolean registToken(int idx, ResponseTokenVO responseToken) {
		if(mapper.insertToken(idx, responseToken) > 0) {
			return true;
		} else {
			return false;
		}
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











