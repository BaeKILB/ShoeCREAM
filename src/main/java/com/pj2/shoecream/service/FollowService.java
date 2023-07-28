package com.pj2.shoecream.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pj2.shoecream.mapper.FollowMapper;
import com.pj2.shoecream.vo.FollowVO;

@Service
public class FollowService {
	
	@Autowired
	private FollowMapper followMapper;
	
	// 1번 방법
//	@Transactional
//	public int registFollow(int follower_idx, int followee_idx) {
//		int insertCount = followMapper.registFollow(follower_idx, followee_idx);
//		return insertCount;
//	}
	
	// 2번 방법
	// 팔로우 하기
	@Transactional
	public void registFollow(FollowVO followVO) {
		followMapper.registFollow(followVO);
	}
	
	// 팔로우 중복 확인
	@Transactional
	public int countExistingFollow(FollowVO followVO) {
		return followMapper.countExistingFollow(followVO);
	}
	
	@Transactional
	public void deleteFollow(int follower_idx, int followee_idx) {
		followMapper.deleteFollow(follower_idx, followee_idx);
	}
	
	
}
