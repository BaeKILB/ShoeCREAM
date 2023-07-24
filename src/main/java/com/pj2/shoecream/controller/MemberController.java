package com.pj2.shoecream.controller;

import java.util.HashMap;
import java.util.Map;

import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pj2.shoecream.handler.CustomValidationException;
import com.pj2.shoecream.service.MemberService;
import com.pj2.shoecream.vo.MemberVO;
import com.pj2.shoecream.vo.SignupVO;




//@RequiredArgsConstructor
@Controller
public class MemberController {
	
	// 로그 확인
	private static final Logger log = LoggerFactory.getLogger(MemberController.class);

	@Autowired
	private MemberService memberService;
	
	// 로그인 폼
	@GetMapping("login")
	public String loginform() {
		return "member/login";
	}
	
	// 회원가입 폼
	@GetMapping("SignUpForm") 
	public String signupform() {
		return "member/signup";
	}
		
	// 회원가입
	@PostMapping("MemberJoinPro")
	public String signup(@ModelAttribute @Valid MemberVO member, BindingResult bindingResult) {
//		public String signup(@ModelAttribute @Valid SignupVO signupVO, BindingResult bindingResult) {
		
		// 아이디 중복 유효성 검사
	    if (memberService.isMemberIdDuplicated(member.getMem_id())) {
	    	throw new CustomValidationException("이미 사용 중인 아이디입니다.", null);
	    }
		
	    // 회원가입 유효성 검사 - 유효성 검사 에러 난 애들 한 곳에 모아서(bindingResult에 의해) 처리 errorMap에 담긴 메세지는 Vaildation 에 의해서 자동으로 적절한게 간다.
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
	        
//	        MemberVO member = signupVO.toMemberVO(); // signupVO 쓸 필요 없을 듯 ? 
	        MemberVO memberEntity = memberService.registMember(member);
	        System.out.println(memberEntity);
	        return "member/login";
	    }
	}
	
	//id 중복 확인
    @ResponseBody
	@GetMapping("idCheck")
	public int idCheck(@RequestParam Map<String,String> map) {
		return memberService.memIdCheck(map);
	}
	
}
