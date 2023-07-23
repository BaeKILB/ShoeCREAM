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
import com.pj2.shoecream.vo.SignupVO;

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
	public String signup(@ModelAttribute @Valid SignupVO signupVO, BindingResult bindingResult) {
		
//		if(member.getMem_id().length() > 20) {
//			System.out.println("너 길이 초과했어");
//		}
		
		if (bindingResult.hasErrors()) {
			System.out.println("여기까지오긴 오니 ..?");
		     Map<String, String> errorMap = new HashMap<>();
		     for (FieldError error : bindingResult.getFieldErrors()) {
		         errorMap.put(error.getField(), error.getDefaultMessage());
		         System.out.println("================");
		         System.out.println(error.getDefaultMessage());
		         System.out.println("================");
		     }
		     throw new CustomValidationException("회원 가입 실패", errorMap);
	    } else {
	    	
//	        if(signupVO.getMem_id().length() > 20) {
//	            throw new CustomValidationException("아이디의 길이가 20자를 초과했습니다.", Map.of("mem_id", "아이디는 2자 이상 20자 이내로 입력해주세요."));
//	        }
	        
	        MemberVO member = signupVO.toMemberVO();
	        MemberVO memberEntity = memberService.registMember(member);
	        System.out.println(memberEntity);
	        return "member/login";
	    }
	}
	
	
}
