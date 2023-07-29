package com.pj2.shoecream.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.pj2.shoecream.vo.SocialVO;

@Mapper
public interface SocialImageMapper {

	int insertPosts(SocialVO socialVO);

	List<String> findPostImageByMemIdx(int mem_idx);
	
}
