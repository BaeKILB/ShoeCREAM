package com.pj2.shoecream.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pj2.shoecream.mapper.FollowMapper;
import com.pj2.shoecream.vo.FollowVO;
import com.pj2.shoecream.vo.FollowingDto;

@Service
public class FollowService {
	
	@Autowired
	private FollowMapper followMapper;
	
	// 팔로우 하기
	@Transactional
	public void registFollow(FollowVO followVO) {
		followMapper.registFollow(followVO);
	}
	
	// 팔로우 취소하기
	@Transactional
	public void deleteFollow(int follower, int followee) {
		
		followMapper.deleteFollow(follower, followee);
	}
	
	// 팔로우 중복 확인
	@Transactional
	public int countExistingFollow(FollowVO followVO) {
		return followMapper.countExistingFollow(followVO);
	}
	
	// 팔로우 리스트 구현
	public List<FollowingDto> followList(int sId, int mem_idx) {
		return followMapper.selectFollowList(sId, mem_idx);
	}
	
	
	
}
