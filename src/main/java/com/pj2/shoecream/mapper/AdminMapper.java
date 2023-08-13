package com.pj2.shoecream.mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.pj2.shoecream.vo.AuctionVO;
import com.pj2.shoecream.vo.CreamRequestVO;
import com.pj2.shoecream.vo.Criteria;
import com.pj2.shoecream.vo.DidListVO;
import com.pj2.shoecream.vo.InquiryBoardVO;
import com.pj2.shoecream.vo.JungProductVO;
import com.pj2.shoecream.vo.MemAccountVO;
import com.pj2.shoecream.vo.MemberVO;
import com.pj2.shoecream.vo.PointInoutVO;
import com.pj2.shoecream.vo.ReportVO;

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
	// 일대일 디테일 조회
	InquiryBoardVO selectQst(int qst_idx);
	// 답변 조회
	InquiryBoardVO selectQstAns(int qst_idx);
	// 답변 등록
	int insertQstBoard(InquiryBoardVO inquiry);
	// 답변 등록 시 참조글 상태 업데이트
	int updateQstStatus(int qst_idx);
	// 답변 등록 수정
	int updateQstAns(@Param("qst_idx") int qst_idx, @Param("inquiry") InquiryBoardVO inquiry);
	// 답변 삭제
	boolean inquiryDelete(int qst_idx);
	// 답변 삭제 후 상태 업데이트
	int deleteUpdateQstAns(int qst_idx);
	// 일대일 내역 조회
	List<InquiryBoardVO> getMainQstBoard(int listLimit);
	// 크림 신청 내역
	List<CreamRequestVO> getCreamRequestList(@Param("searchType") String searchType, @Param("searchKeyword") String searchKeyword, @Param("startRow") int startRow, @Param("listLimit") int listLimit);

	
	// --------------- 민진 ---------------------------
	// 중고 상품 띄우기
	List<JungProductVO> selectProduct(@Param("cri") Criteria cri, @Param("searchType") String searchType, @Param("searchKeyword") String searchKeyword);
	// 경매 상품 띄우기
	List<Map<String, Object>> selectauctionmap(@Param("cri") Criteria cri, @Param("searchType") String searchType, @Param("searchKeyword") String searchKeyword);
//	int getTotal();
	// 중고 신고
	List<ReportVO> getReportListPaging(@Param("cri") Criteria cri, @Param("searchType") String searchType, @Param("searchKeyword") String searchKeyword);
	// 중고 신고 페이징
	int getPage();
	// 중고 신고 처리하기
	int deleteReport(ReportVO report);
	// 경매 신고
	List<ReportVO> getAuctionReportListPaging(@Param("cri") Criteria cri, @Param("searchType") String searchType, @Param("searchKeyword") String searchKeyword);
	// 경매 페이징
	int getPaging();
	// 경매 신고 처리하기
	int deleteAuctionReport(ReportVO report);
	// 중고 상품 삭제
	int deleteProduct(JungProductVO jung);
	// 경매 상품 삭제
	int deleteAuction(AuctionVO auction);
	// 중고 페이징
	int getproduct();
	// 경매 페이징
	int getAucpaging();
	// 크림 상품 목록
	List<Map<String, Object>> selectcreammap(@Param("cri") Criteria cri, @Param("searchType") String searchType, @Param("searchKeyword") String searchKeyword);
	// 크림 페이징
	int getcreampaging();
	// 크림 삭제
	int deletecream(String cream_idx);
	// 경매 차트 계산
	List<Map<String, Object>> selectProductList();
	// 중고 차트 계산
	List<Map<String, Object>> selectAuctionList();
	// 메인페이지 회원 수 세기
	int selectMemberCount();
	// 중고 상품 수 세기
	int selectPro();
	// 경매 상품 수 세기
	int selectAuctionCount();
	// 크림 상품 수 세기
	int selectCreamCount();
	//  포인트 입출금
	List<PointInoutVO> selectAdminPointList(@Param("cri") Criteria cri, @Param("searchType") String searchType, @Param("searchKeyword") String searchKeyword);
	// 관리자 정보조회
	List<Map<String, Object>> selectAdminInfo();
	List<MemAccountVO> selectMemAccount();
		
		
		}
	
	
	
	

