package com.pj2.shoecream.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pj2.shoecream.vo.BankAccountDetailVO;
import com.pj2.shoecream.vo.ResponseDepositVO;
import com.pj2.shoecream.vo.ResponseTokenVO;
import com.pj2.shoecream.vo.ResponseUserInfoVO;
import com.pj2.shoecream.vo.ResponseWithdrawVO;

@Service
public class BankApiService {
	// 실제 금융API 요청을 수행할 BankApiClient 타입 선언
	@Autowired
	private BankApiClient bankApiClient;

	// 엑세스토큰 발급 요청
	public ResponseTokenVO requestToken(Map<String, String> authResponse) {
		// BankApiClient - requestToken() 메서드 호출 후 결과값 리턴
		// => 파라미터 : Map 타입(authResponse)   리턴타입 : ResponseTokenVO
		return bankApiClient.requestToken(authResponse);
	}

	// 사용자 정보 조회 요청
	public ResponseUserInfoVO requestUserInfo(String access_token, String user_seq_no) {
		return bankApiClient.requestUserInfo(access_token, user_seq_no);
	}

	// 계좌 상세정보 조회 요청
	public BankAccountDetailVO requestAccountDetail(Map<String, String> map) {
		return bankApiClient.requestAccountDetail(map);
	}

	// 출금이체 요청
	public ResponseWithdrawVO requestWithdraw(Map<String, String> map) {
		return bankApiClient.requestWithdraw(map);
	}

	public ResponseDepositVO requestDeposit(Map<String, String> map) {
		return bankApiClient.requestDeposit(map);
	}

	public String requestAuth(String access_token, String user_seq_no) {
		return bankApiClient.requestAuth(access_token, user_seq_no);
	}

}










