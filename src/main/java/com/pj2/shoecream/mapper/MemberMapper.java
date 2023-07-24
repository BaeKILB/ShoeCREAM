package com.pj2.shoecream.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.pj2.shoecream.vo.MemberVO;

@Mapper
public interface MemberMapper {
    int insertMember(MemberVO member);

	int isMemberIdDuplicated(String mem_id);

	int idCheck(String id);

	int selectIdCheck(Map<String, String> map);
	
    MemberVO findMemberById(String mem_id);


//	Object selectMemberById(String mem_id);
//
//	Object selectMemberByName(String mem_name);
//
//	Object selectMemberByEmail(String mem_email);
//
//	Object selectMemberByMtel(String mem_mtel);
}
