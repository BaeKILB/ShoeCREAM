package com.pj2.shoecream.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.pj2.shoecream.mapper.AdminMapper;
import com.pj2.shoecream.vo.AuctionVO;
import com.pj2.shoecream.vo.Criteria;
import com.pj2.shoecream.vo.DidListVO;
import com.pj2.shoecream.vo.InquiryBoardVO;
import com.pj2.shoecream.vo.JungProductVO;
import com.pj2.shoecream.vo.MemberVO;
import com.pj2.shoecream.vo.ReportVO;

@Service
public class AdminService {
	
	@Autowired
	private AdminMapper mapper;
	
	// 회원 목록 조회
	public List<MemberVO> getMemberInfo(String searchType, String searchKeyword, int startRow, int listLimit) {
		return mapper.selectMemberInfo(searchType, searchKeyword, startRow, listLimit);
	}
	public int getMemberListCount(String searchType, String searchKeyword) {
		return mapper.selectMemberListCount(searchType, searchKeyword);
	}
	public MemberVO selectMember(int mem_idx) {
		return mapper.getMemberInfo(mem_idx);
	}
//	public MemberVO updateMemberRank(int mem_idx) {
//		return mapper.updateMemberRank(mem_idx);
//	}
	public boolean deleteMember(int mem_idx) {
		return mapper.deleteMember(mem_idx);
	}
	// 일대일 문의 게시판 조회
	public List<InquiryBoardVO> getQstBoard(String searchType, int startRow, int listLimit) {
		return mapper.selectQstBoard(searchType, startRow, listLimit);
	}
	public int getQstListCount(String searchType) {
		return mapper.getQstListCount(searchType);
	}
	// 일대일 문의 디테일 조회
	public InquiryBoardVO selectQst(int qst_idx) {
		return mapper.selectQst(qst_idx);
	}
	// 답변 조회
	public InquiryBoardVO selectQstAns(int qst_idx) {
		return mapper.selectQstAns(qst_idx);
	}
	// 답변 등록
	public int registBoard(InquiryBoardVO inquiry) {
		return mapper.insertQstBoard(inquiry);
	}
	
	// --------------- 민진 ---------------------------
	//중고상품 목록 띄우기
	public List<JungProductVO> getProduct(Criteria cri, String searchType, String searchKeyword) {
		return mapper.selectProduct(cri, searchType, searchKeyword);
	}
	//경매상품 목록 띄우기
	public List<Map<String, Object>> selectauctionmap(Criteria cri, String searchType, String searchKeyword) {
		return mapper.selectauctionmap(cri, searchType, searchKeyword);
	}
//	public int getTotal() {
//		return mapper.getTotal();
//	}
	// 중고상품 신고 
	public List<ReportVO> getReportListPaging(Criteria cri, String searchType, String searchKeyword) {
		return mapper.getReportListPaging(cri, searchType, searchKeyword);
	}
	// 중고 신고 상품 페이징
	public int getPage() {
		return mapper.getPage();
	}
	// 중고 신고 삭제
	public int deleteReport(ReportVO report) {
		return mapper.deleteReport(report);
	}
	 //경매상품 신고 
	public List<ReportVO> getAuctionReportListPaging(Criteria cri, String searchType, String searchKeyword) {
		return mapper.getAuctionReportListPaging(cri, searchType, searchKeyword);
	}
	// 경매 페이징
	public int getPaging() {
		return mapper.getPaging();
	}
	// 경매 신고 삭제
	public int deleteAuctionReport(ReportVO report) {
		return mapper.deleteAuctionReport(report);
	}
	// 중고 상품 삭제
	public int deleteProduct(JungProductVO jung) {
		return mapper.deleteProduct(jung);
	}
	// 경매 상품 삭제
	public int deleteAuction(AuctionVO auction) {
		return mapper.deleteAuction(auction);
	}
	// 중고 페이징
	public int getproduct() {
		return mapper.getproduct();
	}
	// 경매 페이징
	public int getAucpaging() {
		return mapper.getAucpaging();
	}
	// 크림 상품 목록
	public List<Map<String, Object>> selectcreammap(Criteria cri, String searchType, String searchKeyword) {
		return mapper.selectcreammap(cri, searchType, searchKeyword);
	}
	// 크림 페이징
	public int getcreampaging() {
		return mapper.getcreampaging();
	}
	public int deletecream(int ci_code) {
		// TODO Auto-generated method stub
		return mapper.deletecream(ci_code);
	}
	
	
	
	
}
