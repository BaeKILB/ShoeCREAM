package com.pj2.shoecream.mapper;

import java.util.List;

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
			@Param("setPageListLimit") int setPageListLimit
			);
	
	//중고 물품 정보 idx에 맞춰 하나만 가져오기
	JungProductVO selectJungProduct(JungProductVO jproduct);
	
	//페이징 처리를 위한 중고물품 총 갯수 가져오기
	int selectJungProductCount(JungProductVO jproduct);
}
