package com.pj2.shoecream.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.pj2.shoecream.vo.CreamVO;

@Mapper
public interface CreamMapper {

	int insertCreamItem(CreamVO cream);

	int insertCreamOption(CreamVO cream);

}
