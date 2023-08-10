package com.pj2.shoecream.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.pj2.shoecream.config.PrincipalDetails;
import com.pj2.shoecream.service.AuctionService;
import com.pj2.shoecream.service.CreamService;
import com.pj2.shoecream.service.MemberService;
import com.pj2.shoecream.service.PayService;


@Controller
public class AucCreController {
	@Autowired
	private MemberService memService;
	
	@Autowired
	private PayService payService;
	
	  @Autowired
	  private CreamService creamService;
	  
	  @Autowired
	  private AuctionService aucService;
	
	
	   
   @GetMapping("payForm2")
	public String payForm(@RequestParam Map<String,Object> map , Model model) {
	   
//	   {cream_idx=C1691664108524, mem_idx=2}
//		int idx = -1;
	   
	   	int mem_idx = 0;
	   	
	   	try {
				Authentication auth = SecurityContextHolder.getContext().getAuthentication();
				PrincipalDetails mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();
				mem_idx = mPrincipalDetails.getMember().getMem_idx();
			} catch (Exception e) {
				e.printStackTrace();
			}
		
		 // map에서 mem_idx 추출

		// 구매자 정보 받기
		model.addAttribute("buyer" , memService.getMemberByIdx(mem_idx));
		System.out.println(map);
		model.addAttribute("map" , map);
		// 여기 맵안에 들어가있긴하죠//
		
		// selectedSize -- cream.size+selectedSize
		String selectedSize = (String) map.get("selectedSize");
		String key = "size" + selectedSize;

		// 구매 제품 정보 불러오기
		// cream_idx
		String cream_idx = (String) map.get("cream_idx");
		Map<String, Object> cream = creamService.getCream(cream_idx);
		Integer price = (Integer) cream.get(key);

		model.addAttribute("cream", cream);
		model.addAttribute("price", price);
		return "common/pay_form";
	}
	   
	   

}
