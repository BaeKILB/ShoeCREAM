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
	
}
