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
	// 회원 정보 상세 조회
	MemberVO getMemberInfo(int mem_idx);
	// 회원 등업 업데이트
//	MemberVO updateMemberRank(int mem_idx);
	// 회원 삭제
	boolean deleteMember(int mem_idx);
}
