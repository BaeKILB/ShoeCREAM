package com.pj2.shoecream.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface SocialLikeMapper {
	// 좋아요
	void insertLike(@Param("mem_idx") int mem_idx, @Param("sId") int sId);

	// 좋아요 취소
	void deleteLike(@Param("mem_idx") int mem_idx, @Param("sId") int sId);

}
