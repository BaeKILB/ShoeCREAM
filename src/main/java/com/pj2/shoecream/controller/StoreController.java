package com.pj2.shoecream.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import com.pj2.shoecream.config.PrincipalDetails;
import com.pj2.shoecream.service.AdminService;
import com.pj2.shoecream.service.StoreService;
import com.pj2.shoecream.vo.CreamRequestVO;

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
		List<Map<String, Object>> productSellList = storeService.selectProductSellList(mem_idx);
		model.addAttribute("productSellList", productSellList);
		System.out.println("스토어 중고거래 값들 :" + productSellList);
		
		// 중고거래 구매 내역
		List<Map<String, Object>> productBuyList = storeService.selectProductBuyList(mem_idx);
		model.addAttribute("productBuyList", productBuyList);
		System.out.println("중고거래 구매내역 값들 :" + productBuyList);
		
		
		// 경매 등록 내역
		List<Map<String, Object>> auctionList = storeService.selectAuctionList(mem_idx); 
		model.addAttribute("auctionList", auctionList);
		System.out.println("내 경매 값들 :" + auctionList);
		
		// 경매 & 찜 내역
		List<Map<String, Object>> dibList = storeService.selectDibList(mem_idx);
		model.addAttribute("dibList", dibList);
		System.out.println("내 찜 값들 :" + dibList);
		
        // 상점 개인 페이지 정보 조회
		Map<String, Object> storeInfo = storeService.selectStoreInfo(mem_idx);
        model.addAttribute("storeInfo", storeInfo);
		
        // 중고 후기 조회
        List<Map<String, Object>> jungReivewList = storeService.selectJungReivewList(mem_idx);
        model.addAttribute("jungReivewList", jungReivewList);
		System.out.println("내 후기 값들 :" + jungReivewList);
		
		// 경매 참가 내역
		List<Map<String, Object>> auctionBidList = storeService.selectAuctionBidList(mem_idx);
		model.addAttribute("auctionBidList",auctionBidList);

		//크림 구매내역
		List<CreamRequestVO> creamList = storeService.selectCreamList(mem_idx);
		model.addAttribute("creamList", creamList);

		
		return "member/store/store";
   	}
}
