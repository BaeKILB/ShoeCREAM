package com.pj2.shoecream.mapper;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface FollowMapper {

	void registFollow(int follower_idx, int followee_idx);

	void deleteFollow(int follower_idx, int followee_idx);


}
