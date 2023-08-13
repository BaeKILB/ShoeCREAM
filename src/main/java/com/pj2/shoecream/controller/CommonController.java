package com.pj2.shoecream.controller;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pj2.shoecream.config.PrincipalDetails;
import com.pj2.shoecream.service.AuctionService;
import com.pj2.shoecream.service.CategoryService;
import com.pj2.shoecream.service.CommonService;

@Controller
public class CommonController {

	@Autowired
	private CategoryService categoryService;
	
	@Autowired
	private CommonService service;
	
	private static final Logger logger = LoggerFactory.getLogger(CommonController.class);

	@GetMapping("RegisterForm")
	public String registerForm(Model model) {
		List<Map<String, Object>> lc_category = categoryService.getLcList();
		model.addAttribute("lc_category", lc_category);
		return "common/product_register";
	}

	@ResponseBody
	@PostMapping("deliveryRegister")
	public void deliveryRegister(@RequestParam Map<String, Object> map) {

		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		PrincipalDetails mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();
		int buyer_idx = mPrincipalDetails.getMember().getMem_idx();
		
		map.put("recipient_mem_idx", buyer_idx);
		
		Map<String, Object> deliveryInfo = service.getDeliveryInfo(buyer_idx);
		
		if(deliveryInfo == null) {
			service.registDeliveryInfo(map);
		} else {
			service.updateDeliveryInfo(map);
		}
	}
}
