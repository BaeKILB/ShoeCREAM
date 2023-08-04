package com.pj2.shoecream.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import com.pj2.shoecream.config.PrincipalDetails;
import com.pj2.shoecream.handler.CustomValidationException;
import com.pj2.shoecream.service.MemberService;
import com.pj2.shoecream.service.SocialImageService;
import com.pj2.shoecream.vo.MemberProfileDto;
import com.pj2.shoecream.vo.SocialVO;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
public class SocialController {
	
	@Autowired
	private SocialImageService SocialImageService;
	
	@Autowired
	private MemberService memberService;
//  =========================social============================
	// 소셜 팔로잉 디테일 페이지 (홈 버튼 클릭)
	@GetMapping("/social/story")
	public String story() {
		return "member/social/story";
	}
	
	// 소셜 인기 페이지
	@GetMapping("/social/popular")
	public String popular(Model model) {
		
		List<SocialVO> images = SocialImageService.popularImage();
		model.addAttribute("images", images);
		System.out.println("인기 페이지로 뭐 뭐 들고 가니 ? " + images);
		
		return "member/social/popular";
	}
  
	// 소셜 개인 프로필 페이지
	@GetMapping("/social/{mem_idx}")
	public String profile(@PathVariable int mem_idx, Model model) {
//		User userEntity = userService.회원프로필(id);
//		model.addAttribute("user", userEntity);
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        PrincipalDetails mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();
		int sId = mPrincipalDetails.getMember().getMem_idx();
        
		MemberProfileDto dto = memberService.memberProfile(mem_idx, mPrincipalDetails.getMember().getMem_idx());
		model.addAttribute("dto", dto);
		List<SocialVO> social = SocialImageService.findSocialProfile(mem_idx);
		model.addAttribute("social", social);
		System.out.println("프로필 페이지에서 social :" + social);
		
		return "member/social/profile";
	}
	
	@GetMapping("/social/{posts_idx}/detail")
	public String profileDetail() {
		return "member/social/story2";
	}
	
//	=======================social-image========================
	
	// 소셜 포스트 페이지
	@GetMapping("/image/upload")
	public String upload() {
		return "member/social/upload";
	}
	
	@PostMapping("ImageUploadPro")
	public String imageUpload(SocialVO socialVO, @AuthenticationPrincipal PrincipalDetails principalDetails, HttpSession session, Model model) {
		// 서비스 호출
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        PrincipalDetails mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();
        mPrincipalDetails.getMember().getMem_idx();
        
        if(socialVO.getFile1().isEmpty()) {
//        	System.out.println("이미지가 첨부 안됐으");
        	throw new CustomValidationException("이미지가 첨부되지 않았습니다.", null);
        }
        
        SocialImageService.ImageUpload(socialVO, mPrincipalDetails, session, model);
		return "redirect:/social/"+mPrincipalDetails.getMember().getMem_idx();
		
	}
//	===================social_ex====================
	@GetMapping("/social/mainex")
	public String socialMainEx() {
		return "member/socialex/instamain";
	}
	
	@GetMapping("/social/profileex")
	public String socialProfileEx() {
		return "member/socialex/instaprofile";
	}
	
}
