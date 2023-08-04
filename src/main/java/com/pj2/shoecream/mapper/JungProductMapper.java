package com.pj2.shoecream.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.pj2.shoecream.vo.JungProductVO;
import com.pj2.shoecream.vo.PageInfoVO;
import com.pj2.shoecream.vo.ProductVO;

@Mapper
public interface JungProductMapper {
	
	JungProductVO selectJungProductChat(String product_idx);
	
	//중고 물품 리스트로 가져오기
	List<JungProductVO> selectJungProductList(@Param("jproduct") JungProductVO jproduct,
			@Param("startCount") int startCount,
			@Param("setPageListLimit") int setPageListLimit,
			@Param("orderMethod") String orderMethod
			);
	
	//중고 물품 정보 idx에 맞춰 하나만 가져오기
	JungProductVO selectJungProduct(JungProductVO jproduct);

	// 중고 상품 정보로 이미지 , 판매자 정보 등 가져오기
	Map<String,Object> selectJungProductExtend(String product_idx);
	
	//페이징 처리를 위한 중고물품 총 갯수 가져오기
	int selectJungProductCount(JungProductVO jproduct);
	
	//중고 상품 예약자 변경(아무도 예약 안건 상품은 -1 값)
	int updateJungBuyerIdx(
			@Param("product_idx") String product_idx,
			@Param("product_buyer_idx") int product_buyer_idx
			);
	
}
