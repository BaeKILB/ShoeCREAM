package com.pj2.shoecream.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.pj2.shoecream.vo.SocialVO;

@Mapper
public interface SocialImageMapper {

	int insertPosts(SocialVO socialVO);
	
}
