package com.pj2.shoecream.mapper;

import java.util.List;
import java.util.Map;

import javax.validation.Valid;

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
	List<Map<String, Object>> selectAllInfo();
//	List<SocialVO> selectPopular();
	
	// 소셜 인기페이지 프로필 (팔로우 많은 순서)
	List<Map<String, Object>> selectAllInfoWithFollows();
	

	// 소셜 디테일 (내가 클릭한 멤버의 게시물)
	List<SocialVO> selectDetail(@Param("posts_idx") int posts_idx,
			@Param("startRow") int startRow, 
			@Param("listLimit") int listLimit);

	// 소셜 디테일 정보 셀렉
	List<Map<String, Object>> selectImageDetail(int posts_idx);
	
	// 댓글 등록
	void insertComment(SocialCommentVO socialCommentVO);
	
    // 댓글 달 때 ref 초기화
	int updateComment_ref(SocialCommentVO socialCommentVO);
	
   // 댓글 쓸때 프로필 이미지 경로
    String findProfileImageUrlByMemberId(int mem_idx);
	
	// 댓글 등록 시 해당 프로필 이미지 셀렉
	List<SocialCommentVO> selectCommentsByPostId(int posts_idx);
	
	// 댓글 삭제
	void deleteCommentById(int comment_idx);
	
	// 소셜 디테일 수정 이미지 삭제
	int deletePostsImage(Map<String, Object> map);
	
	// 소셜 디테일 수정
	int updatePosts(SocialVO socialVO);
	
	// 소셜 디테일 수정 이미지 없을때 수정
	int updatePostsNoImage(SocialVO socialVO);
	
	// 소셜 포스트 삭제
	int deletePost(int posts_idx);
	
	// 소셜 포스트 삭제할 이미지 셀렉
	String selectPostsImage(int posts_idx);

	void insertReComment(SocialCommentVO socialCommentVO);

	SocialCommentVO findById(int comment_re_ref);

	SocialCommentVO findCommentById(int comment_idx);

	
	



	

}
