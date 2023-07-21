package com.pj2.shoecream.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.pj2.shoecream.vo.MemberVO;

@Mapper
public interface MemberMapper {

	int insertMember(MemberVO member);

	
}
