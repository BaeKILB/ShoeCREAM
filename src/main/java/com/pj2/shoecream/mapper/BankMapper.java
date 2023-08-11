package com.pj2.shoecream.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.pj2.shoecream.vo.AdminAccountInoutVO;
import com.pj2.shoecream.vo.ResponseTokenVO;

public interface BankMapper {

	// 계좌 정보 저장
	int insertMemAccount(Map<String,Object> account);

	// 관리자 계좌 입출금 내역 기록 하기
	int insertAdmAccountInout(AdminAccountInoutVO admAccount);

	//계좌 정보 조회
	Map<String,Object> selectMemAccount(int mem_idx);
	
	
	// 계좌 잔액 업데이트
	int updateMemAccountAmount(int balance_amt, int mem_idx);
	
	// ================ 사용 안함 ===================
	// 토큰 정보 조회
	ResponseTokenVO selectToken(String id);

	// 토큰 정보 조회 요청 - JOIN 구문 활용
	ResponseTokenVO selectTokenForBankAuth(String id);
	
}
