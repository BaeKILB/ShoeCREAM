package com.pj2.shoecream.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.pj2.shoecream.vo.FollowVO;
import com.pj2.shoecream.vo.FollowingDto;

@Mapper
public interface FollowMapper {
	// 팔로우 하기
	void registFollow(FollowVO followVO);
	
	// 팔로우 취소
	void deleteFollow(@Param("follower_idx") int follower, @Param("followee_idx") int followee);
	
	// 팔로우 중복 확인
	int countExistingFollow(FollowVO followVO);
	
	// 팔로우 상태 
	int mfollowState(Map<String, Object> paramMap);
	
	// 팔로우 수 
	int mfollowCount(int mem_idx);
	
	// 팔로우 리스트
	List<FollowingDto> selectFollowList(@Param("sId")int sId, @Param("mem_idx") int mem_idx);
	
	// 팔로우 리스트 구현
}
