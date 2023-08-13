package com.pj2.shoecream.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.pj2.shoecream.service.CategoryService;

@Controller
public class CommonController {
	
  @Autowired
  private CategoryService categoryService;
  
	@GetMapping("RegisterForm")
	public String registerForm(
	    Model model) {
	  List<Map<String, Object>> lc_category = categoryService.getLcList();
	  model.addAttribute("lc_category",lc_category);
		return "common/product_register";
	}
}
