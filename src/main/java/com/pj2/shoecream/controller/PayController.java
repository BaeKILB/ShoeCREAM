package com.pj2.shoecream.controller;

import java.util.Map;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.pj2.shoecream.config.PrincipalDetails;

@Controller
public class PayController {
	
	
	// 결제 정보창 열기
	// payForm 사용시 필요한 파라미터
	/* 
	 * 중고 , 경매 또는 크림 중 하나 product_selector
	 * 
	 * 상품 번호 product_idx
	 * 상품 이름 product_title
	 * 상품 가격 product_price
	 * 상품 설명 product_info
	 * 
	 * 판매자 닉네임 mem_seller_nickname
	 * 판매자 유저 점수 mem_seller_rank
	 * 판매자 판매 횟수 mem_seller_sellCount
	 */
	@GetMapping("payForm")
	public String payForm(@RequestParam Map<String,Object> map , Model model) {
		
		// 로그인 되어있는지 확인하기
		try {			
			Authentication auth = SecurityContextHolder.getContext().getAuthentication();
			PrincipalDetails mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();
		}
		catch(Exception e) {
			// 로그인 안되어있으면 잘못된 접근이라고 띄우기
			model.addAttribute("msg","잘못된 접근입니다");
			return "inc/fail_back";
		}
		
		model.addAttribute("map" , map);
		return "inc/pay/pay_form";
	}
	
	@PostMapping("shoePay")
	public String shoePay(@RequestParam Map<String,Object> map , Model model) {
		// 로그인 되어있는지 확인하기
		try {
			Authentication auth = SecurityContextHolder.getContext().getAuthentication();
			PrincipalDetails mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();
		}
		catch(Exception e) {
			// 로그인 안되어있으면 잘못된 접근이라고 띄우기
			model.addAttribute("msg","잘못된 접근입니다");
			return "inc/fail_back";
		}
		
		return "";
	}
	
}
