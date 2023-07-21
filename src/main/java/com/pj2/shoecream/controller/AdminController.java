package com.pj2.shoecream.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class AdminController {

	//관리자메인
	@GetMapping("AdminMain")
	public String admin() {
		return "admin/admin_main";
	}
	
}
