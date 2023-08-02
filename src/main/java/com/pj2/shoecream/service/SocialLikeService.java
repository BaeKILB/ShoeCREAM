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
	public void insertLike(int posts_idx, int sId) {
		socialLikeMapper.insertLike(posts_idx, sId);
	    incrementLikeCount(posts_idx);
	}
	// 좋아요 수 증가
	@Transactional
	public void incrementLikeCount(int postId) {
	    socialLikeMapper.incrementLikeCount(postId);
	}
	
	// 좋아요 취소
	@Transactional
	public void deleteLike(int mem_idx, int sId) {
		socialLikeMapper.deleteLike(mem_idx, sId);
	    decrementLikeCount(mem_idx);
	}
	// 좋아요 수 감소
	@Transactional
	public void decrementLikeCount(int postId) {
	    socialLikeMapper.decrementLikeCount(postId);
	}
	
	// 좋아요 상태
	public boolean isPostLikedByUser(int userId, int postId) {
		int countLikeResult = socialLikeMapper.selectCountLikes(userId, postId);
		return countLikeResult > 0;
	}
	// 좋아요 갯수
	public int likeCount(int userId, int postId) {
		return socialLikeMapper.selectCountLikes(userId, postId);
	}

}
