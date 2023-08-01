package com.pj2.shoecream.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pj2.shoecream.mapper.SocialLikeMapper;

@Service
public class SocialLikeService {
	
	@Autowired
	SocialLikeMapper socialLikeMapper;
	
	// 좋아요
	@Transactional
	public void insertLike(int mem_idx, int sId) {
		socialLikeMapper.insertLike(mem_idx, sId);
	}
	// 좋아요 취소
	@Transactional
	public void deleteLike(int mem_idx, int sId) {
		socialLikeMapper.deleteLike(mem_idx, sId);
	}

}
