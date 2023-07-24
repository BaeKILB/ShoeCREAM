package com.pj2.shoecream.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.pj2.shoecream.vo.JungGoNohVO;


@Controller
public class JunggoController {
	
	
	@GetMapping("JunggoSearch")
	public String junggoSearch(@RequestParam Map<String,Object> map, Model model) {
		return "/junggo/junggo_product_search";
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
	
	//------------------ 물건 등록 프로 ---------------------------
	@PostMapping("registProductPro")
	public String registProductPro(HttpSession session, @RequestParam Map<String,Object> map, JungGoNohVO jungGoNoh, Model model, HttpServletRequest request) {
		String sId = (String)session.getAttribute("sId");
				return "redirect:/JunggoSearch";
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
