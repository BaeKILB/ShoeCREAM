package com.pj2.shoecream.controller;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

public class MainController {

	// 메인페이지
	@GetMapping("/")
	public String mainform(
			Model model) {
//		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
//		PrincipalDetails mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();
//		System.out.println("세션 정보2 : " + mPrincipalDetails.getMember());
//		
//		model.addAttribute("member", mPrincipalDetails.getMember());
		return "main_ex";
	}
}
