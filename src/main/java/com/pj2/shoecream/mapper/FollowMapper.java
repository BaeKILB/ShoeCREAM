package com.pj2.shoecream.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.pj2.shoecream.vo.FollowVO;

@Mapper
public interface FollowMapper {

	void registFollow(FollowVO followVO);

	void deleteFollow(int follower_idx, int followee_idx);


}
