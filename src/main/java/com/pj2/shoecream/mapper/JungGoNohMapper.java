package com.pj2.shoecream.mapper;



import org.apache.ibatis.annotations.Mapper;

import com.pj2.shoecream.vo.JungGoNohVO;





@Mapper
public interface JungGoNohMapper {
	
	//물품 등록(중고)
	int insertProduct(JungGoNohVO jungGoNoh);
	int insertJungProduct(JungGoNohVO jungGoNoh);
	
	
	// 등록된 상품 상세 폼
	JungGoNohVO selectProduct(int product_idx);
	
	// 조회수 증가
	void updateReadcount(JungGoNohVO jungGoNoh);
	
	// 글 삭제 프로
	int deleteProduct(int product_idx);

	
	
	

	

	
}
