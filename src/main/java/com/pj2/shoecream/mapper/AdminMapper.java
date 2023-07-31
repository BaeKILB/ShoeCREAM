package com.pj2.shoecream.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.pj2.shoecream.vo.AuctionVO;
import com.pj2.shoecream.vo.Criteria;
import com.pj2.shoecream.vo.DidListVO;
import com.pj2.shoecream.vo.InquiryBoardVO;
import com.pj2.shoecream.vo.JungProductVO;
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
	// 일대일 문의 조회
	List<InquiryBoardVO> selectQstBoard(@Param("searchType") String searchType, @Param("startRow") int startRow, @Param("listLimit") int listLimit);
	int getQstListCount(String searchType);
	// --------------- 민진 ---------------------------
	
		// 중고 상품 띄우기
		List<JungProductVO> selectProduct(@Param("cri") Criteria cri, @Param("searchType") String searchType, @Param("searchKeyword") String searchKeyword);
		// 중고상품 페이징
		int getTotal();
//		// 경매 상품 띄우기

		List<Map<String, Object>> selectauctionmap(@Param("cri") Criteria cri, @Param("searchType") String searchType, @Param("searchKeyword") String searchKeyword);
	}

