package com.pj2.shoecream.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pj2.shoecream.mapper.JungProductMapper;
import com.pj2.shoecream.vo.JungProductVO;
import com.pj2.shoecream.vo.PageInfoVO;

@Service
public class JungProductService {
	@Autowired
	private JungProductMapper mapper;
	
	// 중고 상품 정보 리스트 받아오기(추후 리미트로 불러올 상품수 제한)
	public List<JungProductVO> getJungProductList(JungProductVO jproduct, PageInfoVO pageInfo, String orderMethod) {
		int startCount = pageInfo.getStartPage() * pageInfo.getPageListLimit();
		return mapper.selectJungProductList(jproduct,startCount,pageInfo.getPageListLimit(),orderMethod );
	}
	
	// 중고 상품 정보 리스트 받아오기(이미지, 판매자 정보 들고옴)
	public List<Map<String,Object>> getJungProductExList(JungProductVO jproduct, PageInfoVO pageInfo, String orderMethod) {
		int startCount = pageInfo.getStartPage() * pageInfo.getPageListLimit();
		return mapper.selectJungProductExList(jproduct,startCount,pageInfo.getPageListLimit(),orderMethod );
	}
	
	// 중고 상품 정보 idx로 하나 불러오기
	public JungProductVO getJungProduct(JungProductVO jproduct) {
		return mapper.selectJungProduct(jproduct);
	}
	
	// 중고 상품 정보로 이미지 , 판매자 정보 등 가져오기
	public Map<String,Object> getJungProductExtend(String product_idx) {
		return mapper.selectJungProductExtend(product_idx);
	}
	
	public JungProductVO getJungProductChat(String product_idx) {
		return mapper.selectJungProductChat(product_idx); 
	}
	
	// 페이징 처리를 위한 중고 상품 총 갯수 가져오기
	public int getMaxJungProduct(JungProductVO jproduct) {
		return mapper.selectJungProductCount(jproduct);
	}
	
	public int updateSellStatus(String product_idx, String product_sell_status) {
		return mapper.updateSellStatus(product_idx, product_sell_status);
	}
	
	public int updateSellStatusNBuyerIdx(
			String product_idx,
			String product_sell_status,
			int buyerIdx) {
		return mapper.updateSellStatusNBuyerIdx(product_idx, product_sell_status, buyerIdx);
	}
}
