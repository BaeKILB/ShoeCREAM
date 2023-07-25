package com.pj2.shoecream.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.pj2.shoecream.vo.MemberVO;

@Mapper
public interface AdminMapper {
	// 회원 목록 조회
	List<MemberVO> selectMemberInfo(@Param("searchType") String searchType, @Param("searchKeyword") String searchKeyword, @Param("startRow") int startRow, @Param("listLimit") int listLimit);
	int selectMemberListCount(@Param("searchType") String searchType, @Param("searchKeyword") String searchKeyword);
}
