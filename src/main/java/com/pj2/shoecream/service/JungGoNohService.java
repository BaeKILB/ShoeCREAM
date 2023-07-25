package com.pj2.shoecream.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pj2.shoecream.mapper.JungGoNohMapper;
import com.pj2.shoecream.vo.JungGoNohVO;
 
@Service
public class JungGoNohService {

	@Autowired
	JungGoNohMapper jungGoNohMapper;

//============================중고 물품 등록======================================

	public int registProduct(JungGoNohVO jungGoNoh) {
		return jungGoNohMapper.insertProduct(jungGoNoh);
	}
	


//========================중고 물품 상세보기==============================
	
		public JungGoNohVO getProduct(int product_idx) {

			JungGoNohVO jungGoNoh = jungGoNohMapper.selectProduct(product_idx);
				
				if(jungGoNoh != null) {

					jungGoNohMapper.updateReadcount(jungGoNoh);
				}
				

			return jungGoNoh;
		}


//========================== 작성자 확인========================================
		
		public boolean isProductWriter(int product_idx, String sId) {
			String id = sId;
			JungGoNohVO jungGoNoh = jungGoNohMapper.selectProduct(product_idx);

			return id.equals(jungGoNoh.getMem_id());

		}

//===========================삭제 프로============================================
		
		public int removeProduct(int product_idx) {
			return jungGoNohMapper.deleteProduct(product_idx);
		}
		
}
