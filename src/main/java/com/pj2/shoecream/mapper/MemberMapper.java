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
	
	// MemberControllor 백엔드단 아이디 중복 검사
//	int idCheck(String id);
	
	// signup.js 프론트단 아이디 중복 검사
	int selectIdCheck(Map<String, String> map);
	
	// 시큐리티에 mem_id 셀렉해주기
    MemberVO findMemberById(String mem_id);

	MemberVO updateMember(int mem_idx, MemberVO member);

	Object findMemberById(int mem_idx);
	
	// 회원정보 수정 
	int updateMember(@Param("member") MemberVO member, @Param("newPasswd") String newPasswd,
			@Param("newPasswd1") String newPasswd1);
	
}
