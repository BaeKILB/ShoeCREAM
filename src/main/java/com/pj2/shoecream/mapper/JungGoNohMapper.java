package com.pj2.shoecream.mapper;



import java.util.*;

import org.apache.ibatis.annotations.Mapper;

import com.pj2.shoecream.vo.JungGoNohVO;





@Mapper
public interface JungGoNohMapper {
	
	//물품 등록(중고)
	int insertJungProduct(JungGoNohVO jungGoNoh);
	int insertProductImage(JungGoNohVO jungGoNoh);
	
	//중고 수정
	int modifyJunggo(JungGoNohVO jungGoNoh);
	
	// 등록된 상품 상세 폼
	JungGoNohVO selectProduct(String product_idx);
	
	// 등록된 상품 찜
	JungGoNohVO selectDibs(JungGoNohVO jungGoNoh);
		
	// 조회수 증가
	void updateReadcount(JungGoNohVO jungGoNoh);
	
	// 글 삭제 프로
	int deleteProduct(String product_idx);

	//찜 입력
	int insertDibs(JungGoNohVO jungGoNoh);

	// 찜 삭제
	int deleteDibs(JungGoNohVO jungGoNoh);
	
	// 판매자 관련 더 많은 판매 리스트  
	List<JungGoNohVO> getMoreProductListSmall(int mem_idx);
	
	// 판매자 관련 더 많은 리뷰 리스트  
	List<JungGoNohVO> getMoreReviewListSmall(int mem_idx);
	
	// 찜 변동시 조회수 -1
	int decreaseReadcount(JungGoNohVO jungGoNoh);
	
	//신고 등록
	int insertReport(JungGoNohVO jungGoNoh);
	
	//신고 조회(중복 확인)
	String selectReports(JungGoNohVO jungGoNoh);
	
	//신고 조회(리스트)
	List<JungGoNohVO> moreReportListSmall(JungGoNohVO jungGoNoh);
	
	//리뷰 조회(중복 확인)
	String selectReview(JungGoNohVO jungGoNoh);
	
	//리뷰 작성
	int insertReview(JungGoNohVO jungGoNoh);
	
	//리뷰 조회
	JungGoNohVO selectReview2(JungGoNohVO jungGoNoh);
	
	//수정 등록
	int modifyReview(JungGoNohVO jungGoNoh);
	
	//삭제 프로
	int deleteReview(JungGoNohVO jungGoNoh);
	
	//DB payinfo
	JungGoNohVO selectPayInfo(String product_idx);
	JungGoNohVO selectPayInfo2(JungGoNohVO jungGoNoh);
	JungGoNohVO selectPayInfo3(JungGoNohVO jungGoNoh);
	


	
	
}
