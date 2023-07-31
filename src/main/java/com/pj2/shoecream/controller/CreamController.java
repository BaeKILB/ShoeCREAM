package com.pj2.shoecream.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class CreamController {//크림 컨트롤러 입니다.
	
	@GetMapping("Cream")
	public String creamMain() {
		return "cream/cream_main";
	}
}
