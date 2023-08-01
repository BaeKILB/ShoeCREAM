package com.pj2.shoecream.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.pj2.shoecream.config.PrincipalDetails;
import com.pj2.shoecream.service.SocialImageService;
import com.pj2.shoecream.vo.CMRespDto;
import com.pj2.shoecream.vo.SocialVO;

@RestController
public class ImageApiController {
	
	@Autowired
	private SocialImageService socialImageService;
	
//	소셜 스토리 (팔로우한 mem_idx 만 게시글 보이기)
	@GetMapping("/api/image")
	public ResponseEntity<?> imageStory(){
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        PrincipalDetails mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();
		int sId = mPrincipalDetails.getMember().getMem_idx();
		
		List<SocialVO> images = socialImageService.ImageStory(sId);
		return new ResponseEntity<>(new CMRespDto<>(1,"성공",images), HttpStatus.OK);
	}
	
}
