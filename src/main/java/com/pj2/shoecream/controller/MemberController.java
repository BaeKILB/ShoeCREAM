package com.pj2.shoecream.controller;

import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pj2.shoecream.handler.CustomValidationException;
import com.pj2.shoecream.service.MemberService;
import com.pj2.shoecream.vo.MemberVO;

import jakarta.validation.Valid;



//@RequiredArgsConstructor
@Controller
public class MemberController {
	
	private static final Logger log = LoggerFactory.getLogger(MemberController.class);

	@Autowired
	private MemberService memberService;
	
	@GetMapping("login")
	public String loginform() {
		return "member/login";
	}
	
	@GetMapping("SignUpForm") 
	public String signupform() {
		return "member/signup";
	}
	
	@PostMapping("MemberJoinPro")
	public String signup(@ModelAttribute @Valid MemberVO member, BindingResult bindingResult, Model model) {
		
//		if(member.getMem_id().length() > 20) {
//			System.out.println("너 길이 초과했어");
//		}
		
	    if(bindingResult.hasErrors()) {
	        Map<String, String> errorMap = new HashMap<>();
	        for(FieldError error:bindingResult.getFieldErrors()) {
	            errorMap.put(error.getField(), error.getDefaultMessage());
	            System.out.println("============================");
	            System.out.println(error.getDefaultMessage());
	            System.out.println("============================");
	        }
	        throw new CustomValidationException("유효성검사 실패함", errorMap);
	    } else {
	    	
	    	int memberEntity = memberService.registMember(member);
	    	System.out.println(memberEntity);
	    	return "redirect:/login";
//	    	return "member/login";
	    }
	        
	}
	
	
}
