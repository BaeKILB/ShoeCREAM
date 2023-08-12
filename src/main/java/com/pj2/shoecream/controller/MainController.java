package com.pj2.shoecream.controller;

import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
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
	
	// 헤더 검색창에 검색시 이동
	@GetMapping("productSearch")
	public String productSearch(Map<String,String> map, Model model) {
		model.addAttribute("product_search", map.get("product_search").trim());
		return "common/product_search";
	}
}
