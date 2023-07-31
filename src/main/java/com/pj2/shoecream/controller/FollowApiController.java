package com.pj2.shoecream.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import com.pj2.shoecream.config.PrincipalDetails;
import com.pj2.shoecream.handler.CustomApiException;
import com.pj2.shoecream.service.FollowService;
import com.pj2.shoecream.vo.CMRespDto;
import com.pj2.shoecream.vo.FollowVO;
import com.pj2.shoecream.vo.FollowingDto;

@RestController
public class FollowApiController {

	@Autowired
	private FollowService followService;
	
	// 팔로우 하기
	@PostMapping("/api/follow/{mem_idx}")
	public ResponseEntity<?> follow(FollowVO Follow, @AuthenticationPrincipal PrincipalDetails principalDetails,
			@PathVariable int mem_idx, BindingResult bindingResult) {

		// 현재 로그인한 mem_idx 값 들고 오기
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		PrincipalDetails mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();
		int sId = mPrincipalDetails.getMember().getMem_idx(); // 세션에 저장된 mem_idx
		if (sId == mem_idx) {
//            return new ResponseEntity<>(new CMRespDto<>(-1, "자신을 팔로우할 수 없습니다.", null), HttpStatus.BAD_REQUEST);
			throw new CustomApiException("자신을 팔로우할 수 없습니다.");
		}

		// 파라미터를 포함하는 FollowVO 객체를 생성
		FollowVO followVO = new FollowVO();
		followVO.setFollower_idx(sId);
		followVO.setFollowee_idx(mem_idx);

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
	
	// 팔로우 취소
	@DeleteMapping("/api/follow/{mem_idx}")
	public ResponseEntity<?> unfollow(@AuthenticationPrincipal PrincipalDetails principalDetails,
			@PathVariable int mem_idx) {

		// 현재 로그인한 mem_idx 값 들고 오기
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		PrincipalDetails mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();
		int sId = mPrincipalDetails.getMember().getMem_idx();

		// 구독 취소 서비스
		followService.deleteFollow(mPrincipalDetails.getMember().getMem_idx(), mem_idx);
		System.out.println("구독취소할 때 현재 로그인 한 sId : " + sId);
		System.out.println("구독취소할 때 현재 프로필 페이지 mem_idx : " + mem_idx);
		return new ResponseEntity<>(new CMRespDto<>(1, "구독취소하기 성공", null), HttpStatus.OK);

	}
	
	// 현제 프로필 페이지 회원의 팔로잉 리스트 
	@GetMapping("api/social/{mem_idx}/follow") // mem_idx 는 해당 페이지 유저
	public ResponseEntity<?> followList(@PathVariable int mem_idx, @AuthenticationPrincipal PrincipalDetails principalDetails) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		PrincipalDetails mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();
		int sId = mPrincipalDetails.getMember().getMem_idx();
		
		// sId = 현재 로그인 한 mem_idx // mem_dix = 해당 페이지 mem_idx
		List<FollowingDto> followingDto = followService.followList(sId, mem_idx);
		
		return new ResponseEntity<>(new CMRespDto<>(1,"구독자 정보 리스트 불러오기 성공", followingDto),HttpStatus.OK);
	}
	
}
