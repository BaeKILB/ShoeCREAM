package com.pj2.shoecream.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import com.pj2.shoecream.config.PrincipalDetails;
import com.pj2.shoecream.handler.CustomApiException;
import com.pj2.shoecream.service.FollowService;
import com.pj2.shoecream.vo.CMRespDto;
import com.pj2.shoecream.vo.FollowVO;

@RestController
public class FollowApiController {
	
	@Autowired
	private FollowService followService;
	
	@PostMapping("/api/follow/{followee_idx}")
	public ResponseEntity<?> follow(
			FollowVO Follow, @AuthenticationPrincipal PrincipalDetails principalDetails,
			@PathVariable int followee_idx, BindingResult bindingResult) {
//		int insertCount = followService.registFollow(follower_idx, followee_idx);
		// 1. 기존 방식
//		int insertCount = followService.registFollow(principalDetails.getMember().getMem_idx(), followee_idx);
//		return new ResponseEntity<>(new CMRespDto<>(insertCount, "구독하기 성공", null), HttpStatus.OK);
		// 2. 다른 방식
		// 세션 정보 가져오기
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        PrincipalDetails mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();
        int sId = mPrincipalDetails.getMember().getMem_idx(); // 세션에 저장된 mem_idx
        
        if (sId == followee_idx) {
//            return new ResponseEntity<>(new CMRespDto<>(-1, "자신을 팔로우할 수 없습니다.", null), HttpStatus.BAD_REQUEST);
      	  	throw new CustomApiException("자신을 팔로우할 수 없습니다.");
        }
        
        // 파라미터를 포함하는 FollowVO 객체를 생성
        FollowVO followVO = new FollowVO();
        followVO.setFollower_idx(sId);
        followVO.setFollowee_idx(followee_idx);
        
        // 이미 팔로우한 사용자인지 확인
        int existingFollowCount = followService.countExistingFollow(followVO);
        if (existingFollowCount > 0) {
//            return new ResponseEntity<>(new CMRespDto<>(-1, "이미 팔로우한 사용자입니다.", null), HttpStatus.BAD_REQUEST);
        	  throw new CustomApiException("이미 팔로우한 사용자입니다.");
        } else {
            followService.registFollow(followVO);
            return new ResponseEntity<>(new CMRespDto<>(1, "구독하기 성공", null), HttpStatus.OK);
        }
	}
	
	@DeleteMapping("/api/subscribe/{followee_idx}")
	public ResponseEntity<?> unfollow(@AuthenticationPrincipal PrincipalDetails principalDetails,
			@PathVariable int followee_idx) {
		// 1. 기존 방식
//		int deleteCount = followService.deleteFollow(principalDetails.getMember().getMem_idx(), followee_idx);
//		return new ResponseEntity<>(new CMRespDto<>(deleteCount, "구독취소하기 성공", null), HttpStatus.OK);
		// 2. 다른 방식
		followService.deleteFollow(principalDetails.getMember().getMem_idx(), followee_idx);
		return new ResponseEntity<>(new CMRespDto<>(1, "구독취소하기 성공", null), HttpStatus.OK);
		
	}
}
