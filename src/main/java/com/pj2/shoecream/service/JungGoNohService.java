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

		public List<JungGoNohVO> moreProductListSmall(int mem_idx) {
			return jungGoNohMapper.getMoreProductListSmall(mem_idx);
		}

}


