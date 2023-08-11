package com.pj2.shoecream.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.pj2.shoecream.config.PrincipalDetails;
import com.pj2.shoecream.service.AuctionService;
import com.pj2.shoecream.service.CreamService;
import com.pj2.shoecream.service.MemberService;
import com.pj2.shoecream.service.PayService;
import com.pj2.shoecream.vo.MemberVO;

import ch.qos.logback.classic.Logger;


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
	   	MemberVO buyer = memService.getMemberByIdx(mem_idx);
	   	System.out.println("!@#$"+buyer);
		// 구매자 정보 받기
		model.addAttribute("buyer" , buyer);
		System.out.println(map);
		model.addAttribute("map" , map);
		
		
		//--------------여기는 크림 정보 받아오는 곳입니다 성혁씨---------------
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
		//-----------여기까쥐---------------------------------------------
		return "common/pay_form";
	}
	   
	   
   @PostMapping("commonPayPro")
   	public String commonPayPro(@RequestParam Map<String,Object> map , Model model) {
	   //결제 성공시 넘어오는 페이지임
	   
	   	int mem_idx = 0;
	   	
	   	try {Authentication auth = SecurityContextHolder.getContext().getAuthentication();
			 PrincipalDetails mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();
		     mem_idx = mPrincipalDetails.getMember().getMem_idx();
			} catch (Exception e) {
				e.printStackTrace();
			}
		
	   
	   //멤버정보
	   memService.getMemberByIdx(mem_idx);
	   
	   //주소랑 결제한내역 받아와야함
	   
	   String product_idx = (String) map.get("cream_idx");
	   System.out.println(product_idx);
	   
	   //
	   
	   //포인트 있는경우 없는경우 따져봐야함 
//	   if(포인트>결제금액) {
		   //결제로직
		   //회원 포인트에서price만큼 차감하고 관리자 포인트는 업뎃 시켜야함
		   //크림 테이블, 택배테이블 업데이트 해야함
		   //결제가 완료되면 상점페이지로 넘겨주나? 
		   
//	   }else {
		   //포인트 충전창
		   //포인트를 충전하면 어떻게함? 어디로 보내줘야함?
//	   }
	   

	   
	   
	   return "";
   }

}
