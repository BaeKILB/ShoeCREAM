package com.pj2.shoecream.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.pj2.shoecream.vo.JungProductVO;
import com.pj2.shoecream.vo.ProductVO;

@Mapper
public interface JungProductMapper {
	JungProductVO selectJungProductChat(int product_idx);
}
