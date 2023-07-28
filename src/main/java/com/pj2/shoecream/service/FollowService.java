package com.pj2.shoecream.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pj2.shoecream.mapper.FollowMapper;

@Service
public class FollowService {
	
	@Autowired
	private FollowMapper followMapper;
	
	// 1.번 방법
//	@Transactional
//	public int registFollow(int follower_idx, int followee_idx) {
//		int insertCount = followMapper.registFollow(follower_idx, followee_idx);
//		return insertCount;
//	}
	
	// 2.번 방법
	@Transactional
	public void registFollow(int follower_idx, int followee_idx) {
		followMapper.registFollow(follower_idx, followee_idx);
	}
	
	@Transactional
	public void deleteFollow(int follower_idx, int followee_idx) {
		followMapper.deleteFollow(follower_idx, followee_idx);
	}
}
