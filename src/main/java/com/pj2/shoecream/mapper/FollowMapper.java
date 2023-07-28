package com.pj2.shoecream.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.pj2.shoecream.vo.FollowVO;

@Mapper
public interface FollowMapper {
	// 팔로우 하기
	void registFollow(FollowVO followVO);

	// 팔로우 중복 확인
	int countExistingFollow(FollowVO followVO);
	
	void deleteFollow(int follower_idx, int followee_idx);
	

}
