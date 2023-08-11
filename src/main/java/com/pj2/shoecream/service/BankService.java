package com.pj2.shoecream.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pj2.shoecream.mapper.BankMapper;
import com.pj2.shoecream.mapper.MemberMapper;
import com.pj2.shoecream.vo.AdminAccountInoutVO;
import com.pj2.shoecream.vo.ResponseTokenVO;

@Service
public class BankService {
	@Autowired
	private BankMapper mapper;
	
	@Autowired
	private MemberMapper memMapper;

	// 유저 통장 토큰, 핀테크 사용 번호 db 저장
	public boolean registAccount(Map<String,Object> account) {
		return mapper.insertMemAccount(account) > 0; 
	}

	// 유저 통장 정보 조회
	public Map<String,Object> getMemAccount(int mem_idx){
		return mapper.selectMemAccount(mem_idx);
	}
	
	// 관리자 계좌 입출금 내역 DB에 기록
	// mem_idx : 관리자에게 보내는, 입금 받는 유저번호
	// tran_amount : 보내는, 받는 금액 수 ** 출금이라도 무조건 양수로 들고오기
	// tran_type : 입금인지 출금인지 확인 코드
	// tran_type 에 입력되는 값 ====
	// d : deposit (입금)
	// w : withdraw (출금)
	// =====
	
	public boolean addAdmAccountLog(AdminAccountInoutVO admAccountInout) {
		if(admAccountInout == null) {
			return false;
		}
		
		// 관리자 계좌 정보 불러오기
		// mem_idx를 1로 집어넣고 찾지말고
		// 멤버 id admin으로 된 아이디 찾아 거기의 mem_idx 로 넣기
		
		int adm_idx = memMapper.findMemberById("admin").getMem_idx();
		System.out.println("adm_idx : " + adm_idx);
		
		int tran_amount = admAccountInout.getTran_amount();
		Long admAccountBalance = (Long)mapper.selectMemAccount(adm_idx).get("balance_amt");
		
		if(admAccountInout.getTran_type().equals("d")) {
			admAccountInout.setAdmin_account_balance(
					admAccountBalance + tran_amount );
		}
		else if(admAccountInout.getTran_type().equals("w")) {
			admAccountInout.setAdmin_account_balance(
					admAccountBalance - tran_amount );
		}
		else 
			return false;
		
		// 관리자 계정 계좌 정보에도 업데이트
		if(mapper.insertAdmAccountInout(admAccountInout) > 0) {
			
			return mapper.updateMemAccountAmount(
					 adm_idx,admAccountInout.getAdmin_account_balance()) > 0;
		}
		
		return false;
		
	}
	
	public boolean updateMemAccountAmount(int mem_idx , Long balance_amt){
		return mapper.updateMemAccountAmount(mem_idx, balance_amt) > 0;
	}
	
	// 사용 하지 않음 ==========
	
	// 토큰 정보 조회 요청
	public ResponseTokenVO getToken(String id) {
		return mapper.selectToken(id);
	}

	// 토큰 정보 조회 요청 - JOIN 구문 활용
	public ResponseTokenVO getTokenForBankAuth(String id) {
		return mapper.selectTokenForBankAuth(id);
	}
	

}











