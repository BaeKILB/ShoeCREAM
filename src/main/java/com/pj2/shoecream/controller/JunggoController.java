package com.pj2.shoecream.controller;

import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class JunggoController {
	
	@GetMapping("JunggoSearch")
	public String junggoSearch(@RequestParam Map<String,Object> map, Model model) {
		return "";
	}
	@GetMapping("JungChat")
	public String jungChat(@RequestParam Map<String,Object> map, Model model) {
		return "";
	}
	@GetMapping("JunggoPay")
	public String junggoPay(@RequestParam Map<String,Object> map, Model model) {
		return "";
	}
	@GetMapping("JunggoResults")
	public String junggoResults(@RequestParam Map<String,Object> map, Model model) {
		return "";
	}
	
	
	
	
	//========================================================================================
	//==================================노용석================================================
	
	//------------------- 물건 등록 폼 이동---------------------
	@GetMapping("productRegister")
	public String productRegister(Model model) {
	    return "junggo/product_register";
	}
	
	//------------------ 물건 상세 안내 폼 이동---------------------
	@GetMapping("productDetail")
	public String productDetail(Model model) {
	    return "junggo/product_detail";
	}

	//------------------------- 예약취소 폼 이동---------------------
	@GetMapping("resCancel")
	public String resCancel() {
		return "junggo/res_cancel";
		
	}
	
	//------------------------- 예약완료 폼 이동---------------------
	@GetMapping("resComplete")
	public String resComplete() {
		return "junggo/res_complete";
		
	}
	
	//------------------------- 결제완료 폼 이동---------------------
	@GetMapping("payComplete")
	public String payComplete() {
		return "junggo/pay_complete";
			
	}
	
	//------------------------- 거래취소 폼 이동---------------------
	@GetMapping("tradeCancel")
	public String tradeCancel() {
		return "junggo/trade_cancel";
		
	}

	//------------------------- 거래완료 폼 이동---------------------
	@GetMapping("tradeComplete")
	public String resCancelCom() {
		return "junggo/trade_complete";
	}
	
	
	
}
