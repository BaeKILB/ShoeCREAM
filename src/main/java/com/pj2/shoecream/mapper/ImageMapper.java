package com.pj2.shoecream.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.pj2.shoecream.vo.ProductImageVO;

@Mapper
public interface ImageMapper {

	int insertProductImage(ProductImageVO image);

	int modifyProductImage(ProductImageVO image);

}
