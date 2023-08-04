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
import com.pj2.shoecream.service.JungProductService;
import com.pj2.shoecream.service.MemberService;
import com.pj2.shoecream.vo.MemberVO;

@Controller
public class PayController {
	
	@Autowired
	private MemberService memService;
	
	@Autowired
	private JungProductService jProductService;
	
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
		int idx = -1;
		// 로그인 되어있는지 확인하기
		try {			
			Authentication auth = SecurityContextHolder.getContext().getAuthentication();
			PrincipalDetails mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();
			
			// 구매자 회원번호
			idx = mPrincipalDetails.getMember().getMem_idx();
		}
		catch(Exception e) {
			// 로그인 안되어있으면 잘못된 접근이라고 띄우기
			model.addAttribute("msg","잘못된 접근입니다");
			return "inc/fail_back";
		}
		System.out.println(map);
		model.addAttribute("map" , map);
		model.addAttribute("member" , memService.getProfileMember(idx));
		return "inc/pay/pay_form";
	}
	
	@GetMapping("shoePay")
	public String shoePay(@RequestParam Map<String,Object> map , Model model) {
		int idx = -1;
		// 로그인 되어있는지 확인하기
		try {
			Authentication auth = SecurityContextHolder.getContext().getAuthentication();
			PrincipalDetails mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();
			// 구매자 회원번호
			idx = mPrincipalDetails.getMember().getMem_idx();		
		}
		catch(Exception e) {
			// 로그인 안되어있으면 잘못된 접근이라고 띄우기
			model.addAttribute("msg","잘못된 접근입니다");
			return "inc/fail_back";
		}
		
		Integer product_selector = Integer.parseInt((String)map.get("product_selector"));
		
		
		// 결제가 어디서 왔는지 따라서 데이터 받기
		if(product_selector != null) {
			if(product_selector == 0) {
				
				Map<String,Object> productEx = jProductService.getJungProductExtend((String)map.get("product_idx"));
				String product_sell_status = (String)productEx.get("product_sell_status");
				String product_payment = (String)productEx.get("product_payment");
				// 현재 물품의 거래 상황과 예약중인 유저 체크
				if(productEx != null 
						&& (product_sell_status).equals("예약중")
						&& (product_payment.equals("안전페이") || product_payment.equals("안전페이,직거래"))
						&& (Integer)productEx.get("product_buyer_idx") == idx) {			
					model.addAttribute("map",productEx);
					return "inc/pay/shoe_pay";
				} 
				// 만약 다른 거래 상황이면 ...
				else if(product_sell_status.equals("대기중")){
					model.addAttribute("msg","예약 진행중이 아닙니다 예약 진행 먼저 해주세요");
				}
				// 이미 자신이 아닌 다른 사람이 예약, 거래 중 이라면
				else if(product_sell_status.equals("예약중")
						|| product_sell_status.equals("거래대기중")){
					model.addAttribute("msg","다른 유저가 예약중에 있습니다!");
				}
				else if(product_sell_status.equals("거래완료")){
					model.addAttribute("msg","이미 거래가 완료된 상품입니다");
				}
				else {
					model.addAttribute("msg","잘못된 접근입니다");
				}
				return "inc/fail_back";
			}	
		}
		return "";
	}
	
	
	// ==================== ajax =====================
	@GetMapping("payPoint")
	public String payPoint(@RequestParam Map<String,Object> map , Model model) {
		int idx = -1;
		MemberVO member = null;
		// 로그인 되어있는지 확인하기
		try {
			Authentication auth = SecurityContextHolder.getContext().getAuthentication();
			PrincipalDetails mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();
			
			// 현재 접속회원
			member = mPrincipalDetails.getMember();
			// 구매자 회원번호
			idx = mPrincipalDetails.getMember().getMem_idx();		
		}
		catch(Exception e) {
			// 로그인 안되어있으면 잘못된 접근이라고 띄우기
			model.addAttribute("msg","잘못된 접근입니다");
			return "inc/fail_back";
		}
		
		Integer product_selector = Integer.parseInt((String)map.get("product_selector"));
		boolean isPayReady = false;
		// 결제가 어디서 왔는지 따라서 데이터 받기
		if(product_selector != null) {
			
			// =========== 중고거래일때
			if(product_selector == 0) {
				
				Map<String,Object> productEx = jProductService.getJungProductExtend((String)map.get("product_idx"));
				String product_sell_status = (String)productEx.get("product_sell_status");
				String product_payment = (String)productEx.get("product_payment");
				// 현재 물품의 거래 상황과 예약중인 유저 체크
				if(productEx != null 
						&& (product_sell_status).equals("예약중")
						&& (product_payment.equals("안전페이") || product_payment.equals("안전페이,직거래"))
						&& (Integer)productEx.get("product_buyer_idx") == idx) {			
					model.addAttribute("map",productEx);
					model.addAttribute("member", member);
					isPayReady = true;
				} 
				// 만약 다른 거래 상황이면 ...
				else if(product_sell_status.equals("대기중")){
					model.addAttribute("msg","예약 진행중이 아닙니다 예약 진행 먼저 해주세요");
				}
				// 이미 자신이 아닌 다른 사람이 예약, 거래 중 이라면
				else if(product_sell_status.equals("예약중")
						|| product_sell_status.equals("거래대기중")){
					model.addAttribute("msg","다른 유저가 예약중에 있습니다!");
				}
				else if(product_sell_status.equals("거래완료")){
					model.addAttribute("msg","이미 거래가 완료된 상품입니다");
				}
				else {
					model.addAttribute("msg","잘못된 접근입니다");
				}
				
				
			}	// =========== 중고거래일때 끝
		}
		if(!isPayReady)
			return "";
		return "inc/fail_back";
		
	}
	
}
