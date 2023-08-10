package com.pj2.shoecream.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.pj2.shoecream.vo.MemberVO;

@Mapper
public interface MemberMapper {
   
	// 회원가입
	int insertMember(MemberVO member);
	
    // MemberControllor 백엔드단 아이디 중복 검사
	int isMemberIdDuplicated(String mem_id);
    // MemberControllor 백엔드단 폰 중복 검사
	int isMemberPhoneDuplicated(String mem_mtel);
	// MemberControllor 백엔드단 이메일 중복 검사
	int isMemberEmailDuplicated(String mem_email);
	// signup.js 프론트단 아이디 중복 검사
	int selectIdCheck(Map<String, String> map);
	
	
	// 시큐리티에 mem_id 셀렉해주기
    MemberVO findMemberById(String mem_id);

	MemberVO updateMember(int mem_idx, MemberVO member);

	Object findMemberById(int mem_idx);
	
	// 회원정보 수정 
	int updateMember(@Param("member") MemberVO member, @Param("newPasswd") String newPasswd,
			@Param("newPasswd1") String newPasswd1);
	
	// 회원정보 수정 새로운 값 셀렉
	MemberVO selectMember(String mem_id);

	//폰번호 중복확인
	int phoneCheck(String phone);
//---------------------- 회원가입 / 회원정보수정--------------------
	//아이디찾기
	String getId(MemberVO member);
	
	//비번찾기
	String isExistUser(MemberVO member);
	
	String selectSendEmail(MemberVO member);
	
	
	//임시비밀번호 설정
	int changePw(MemberVO member);
	
// ------------------ 마이페이지 / 프로필 관리 -------------------
	Map<String, Object> selectProfileMember(int sId);
	
	// 마이페이지 프로필 변경
	int updateProfile(MemberVO member);
//---------------------- 아이디/비밀번호 찾기 - find.jsp--------------------

	// 소셜 프로필 가져올 memIdx
	MemberVO findMemberByMemIdx(int mem_idx);
	
	// 소셜 소토리 용
	MemberVO findMemberByIdx(int mem_idx);
	
	// 회원탈퇴 : (상태 ROLE_REST) 로 업데이트
	int deleteMember(@Param("sId") int sId);

	


	






	

//--------- 0809 배경인 추가 ----------
	// 계좌인증 여부 업데이트
	int updateMemAccountAuth(
			@Param("mem_idx") int mem_idx 
			,@Param("mem_account_auth") String mem_account_auth);
	
	// 포인트 충전 출금 액수 업데이트
	int updatePointAmount(
			@Param("mem_idx") int mem_idx
			,@Param("pointAmount") int pointAmount);
	
}
