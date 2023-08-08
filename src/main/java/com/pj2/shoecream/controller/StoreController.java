package com.pj2.shoecream.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import com.pj2.shoecream.config.PrincipalDetails;
import com.pj2.shoecream.service.StoreService;

@Controller
public class StoreController {
	
	@Autowired
	private StoreService storeService;
	
    // 상점 개인 페이지
   	@GetMapping("/store/{mem_idx}")
   	public String profile(@PathVariable int mem_idx, Model model) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		PrincipalDetails mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();
		int sId = mPrincipalDetails.getMember().getMem_idx();

		// 중고거래 판매 내역
		List<HashMap<String, Object>> productSellList = storeService.selectProductSellList(mem_idx);
		model.addAttribute("productSellList", productSellList);
		System.out.println("스토어 중고거래 값들 :" + productSellList);
		
		// 경매 등록 내역
		List<HashMap<String, String>> auctionList = storeService.selectAuctionList(mem_idx); 
		model.addAttribute("auctionList", auctionList);
		System.out.println("내 경매 값들 :" + auctionList);
		
        // 상점 개인 페이지 정보 조회
        HashMap<String, Object> storeInfo = storeService.selectStoreInfo(mem_idx);
        model.addAttribute("storeInfo", storeInfo);
		
   		return "member/store/store";
   	}
}