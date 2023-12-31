package com.pj2.shoecream.service;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import com.pj2.shoecream.mapper.JungGoNohMapper;
import com.pj2.shoecream.vo.JungGoNohVO;
 
@Service
public class JungGoNohService {

	@Autowired
	JungGoNohMapper jungGoNohMapper;

	//============================중고 물품 등록======================================

		public int registJungProduct(JungGoNohVO jungGoNoh) {
			return jungGoNohMapper.insertJungProduct(jungGoNoh);
		}
		
		public int registProductImage(JungGoNohVO jungGoNoh) {
			return jungGoNohMapper.insertProductImage(jungGoNoh);
		}
			

	//========================중고 물품 상세보기==============================
		
		public JungGoNohVO getProduct(String product_idx) {

			JungGoNohVO jungGoNoh = jungGoNohMapper.selectProduct(product_idx);
				
				if(jungGoNoh != null) {

					jungGoNohMapper.updateReadcount(jungGoNoh);
				}

			return jungGoNoh;
		}

		public JungGoNohVO getDibs(JungGoNohVO jungGoNoh) {

			JungGoNohVO jungGoNoh1 = jungGoNohMapper.selectDibs(jungGoNoh);
				
			return jungGoNoh1;
		}

//-===============================중고수정========================================================
		public int modifyJunggo(JungGoNohVO jungGoNoh) {
			return jungGoNohMapper.modifyJunggo(jungGoNoh);
		}
		
	//========================== 작성자 확인========================================
			
		public boolean isProductWriter(String product_idx, String sId) {
			String id = sId;
			JungGoNohVO jungGoNoh = jungGoNohMapper.selectProduct(product_idx);

			return id.equals(jungGoNoh.getMem_id());

		}

	//===========================삭제 프로============================================
			
		public int removeProduct(String product_idx) {
			
			return jungGoNohMapper.deleteProduct(product_idx);
		}

	//===========================찜 입력============================================	
		public int registDibs(JungGoNohVO jungGoNoh) {
			
			return jungGoNohMapper.insertDibs(jungGoNoh);
			
		}
	//===========================찜 삭제============================================	
		public int removeDibs(JungGoNohVO jungGoNoh) {
			return jungGoNohMapper.deleteDibs(jungGoNoh);
		}
	// ==========판매자 관련 판매 목록=======================
		public List<JungGoNohVO> moreProductListSmall(int mem_idx) {
			return jungGoNohMapper.getMoreProductListSmall(mem_idx);
		}
	//=====================찜 등록시 올라가는 조회수 내리기============
		public int removeReadCount(JungGoNohVO jungGoNoh) {
			return jungGoNohMapper.decreaseReadcount(jungGoNoh);
		}
	//============================신고 등록======================================
		public int registReport(JungGoNohVO jungGoNoh) {
			return jungGoNohMapper.insertReport(jungGoNoh);
		}
		//========================신고 조회(중복확인)=========================
		public String getReport(JungGoNohVO jungGoNoh) {
			String ifReport = jungGoNohMapper.selectReports(jungGoNoh);
			return ifReport;
		}
		//==================신고 조회(리스트 가져오기)========================
		public List<JungGoNohVO> moreReportListSmall(JungGoNohVO jungGoNoh) {
			return jungGoNohMapper.moreReportListSmall(jungGoNoh);
		}
		//====================리뷰 조회(중복확인)=========================
		public String getReview(JungGoNohVO jungGoNoh) {
			String ifReview = jungGoNohMapper.selectReview(jungGoNoh);
			return ifReview;
		}
		//==================리뷰 작성=====================================
		public int registReview(JungGoNohVO jungGoNoh) {
			return jungGoNohMapper.insertReview(jungGoNoh);
		}
		// ============================= 리뷰 조회=======================
		public JungGoNohVO getReview2(JungGoNohVO jungGoNoh) {
			JungGoNohVO jungGoNohReport = jungGoNohMapper.selectReview2(jungGoNoh);
			return jungGoNohReport;
		}
		//====================리뷰수정===================================
		public int modifyReview(JungGoNohVO jungGoNoh) {
			// TODO Auto-generated method stub
			return jungGoNohMapper.modifyReview(jungGoNoh);
		}
		
		//=========================리뷰삭제========================
		public int deleteReview(JungGoNohVO jungGoNoh) {
			// TODO Auto-generated method stub
			return jungGoNohMapper.deleteReview(jungGoNoh);
		}
		
		//==========리뷰 관련 판매 목록=======================
		public List<JungGoNohVO> moreReviewListSmall(int mem_idx) {
			return jungGoNohMapper.getMoreReviewListSmall(mem_idx);
		}
		
		// == DBPay_info===========================================
		public JungGoNohVO getPayInfo(String product_idx) {

			JungGoNohVO jungGoNoh = jungGoNohMapper.selectPayInfo(product_idx);
				
			return jungGoNoh;
		}

		public JungGoNohVO getPayInfo2(JungGoNohVO jungGoNoh) {
			JungGoNohVO jungGoNohData = jungGoNohMapper.selectPayInfo2(jungGoNoh);
			return jungGoNohData;
		}

		
		public JungGoNohVO getPayInfo3(JungGoNohVO jungGoNoh) {
			JungGoNohVO pay = jungGoNohMapper.selectPayInfo3(jungGoNoh);
			return pay;
		}
	
		
	}


