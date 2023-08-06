package com.pj2.shoecream.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.pj2.shoecream.vo.SocialCommentVO;
import com.pj2.shoecream.vo.SocialVO;

@Mapper
public interface SocialImageMapper {
	
	// 소셜 프로필 (소셜 게시물 등록)
	int insertPosts(SocialVO socialVO);

	// 소셜 프로필 (소셜 게시물 정보 가져가기)
	List<SocialVO> SelectSocialProfile(int mem_idx);
	
	//	소셜 스토리 (팔로우한 mem_idx 만 게시글 보이기)
	List<SocialVO> selectStory(
			@Param("sId") int sId,
			@Param("startRow") int startRow, 
			@Param("listLimit") int listLimit);
	
	// 소셜 인기페이지 (좋아요 많은 순서)
	List<SocialVO> selectPopular();
	
	// 소셜 디테일 (내가 클릭한 멤버의 게시물)
	List<SocialVO> selectDetail(@Param("posts_idx") int posts_idx,
			@Param("startRow") int startRow, 
			@Param("listLimit") int listLimit);

	// 소셜 디테일 정보 셀렉
	List<Map<String, Object>> selectImageDetail(int posts_idx);
	
	void insertComment(SocialCommentVO socialCommentVO);
	
   // 댓글 쓸때 프로필 이미지 경로
    String findProfileImageUrlByMemberId(int mem_idx);
	
	int updateComment_ref(SocialCommentVO socialCommentVO);

	List<SocialCommentVO> selectCommentsByPostId(int posts_idx);

	void deleteCommentById(int comment_idx);

	int deletePostsImage(Map<String, Object> map);
	



	

}
