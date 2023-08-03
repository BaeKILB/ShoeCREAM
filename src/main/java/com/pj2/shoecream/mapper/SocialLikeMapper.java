package com.pj2.shoecream.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface SocialLikeMapper {
	// 좋아요
	void insertLike(@Param("posts_idx") int posts_idx, @Param("sId") int sId);

	// 좋아요 취소
	void deleteLike(@Param("mem_idx") int mem_idx, @Param("sId") int sId);
	
	// 좋아요 상태 카운트
	int selectCountLikes(@Param("userId")int userId, @Param("postId")int postId);
	
	// 좋아요 수 증가
	void incrementLikeCount(@Param("postId") int postId);

	// 좋아요 수 감소
	void decrementLikeCount(@Param("postId") int postId);
	
}
