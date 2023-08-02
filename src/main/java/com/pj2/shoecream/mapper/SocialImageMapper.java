package com.pj2.shoecream.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.pj2.shoecream.vo.SocialVO;

@Mapper
public interface SocialImageMapper {

	int insertPosts(SocialVO socialVO);

	List<String> findPostImageByMemIdx(int mem_idx);
	
//	소셜 스토리 (팔로우한 mem_idx 만 게시글 보이기)
	List<SocialVO> selectStory(
			@Param("sId") int sId,
			@Param("startRow") int startRow, 
			@Param("listLimit") int listLimit);
}
