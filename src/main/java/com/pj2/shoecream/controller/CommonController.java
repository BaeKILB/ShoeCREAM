package com.pj2.shoecream.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class CommonController {
	
	@GetMapping("RegisterForm")
	public String registerForm() {
		return "common/product_register";
	}
}
