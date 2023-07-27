package com.pj2.shoecream.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pj2.shoecream.config.PrincipalDetails;
import com.pj2.shoecream.handler.CustomValidationException;
import com.pj2.shoecream.service.MemberService;
import com.pj2.shoecream.vo.MemberVO;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
public class MemberController {
	
	// 로그 확인
	private static final Logger log = LoggerFactory.getLogger(MemberController.class);
	
	@Autowired
	private MemberService memberService;
	
    private final BCryptPasswordEncoder bCryptPasswordEncoder;
	
	// 메인페이지
	@GetMapping("/")
	public String mainform(
			@AuthenticationPrincipal PrincipalDetails principalDetails, 
			Model model) {
//		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
//		PrincipalDetails mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();
//		System.out.println("세션 정보2 : " + mPrincipalDetails.getMember());
//		
//		model.addAttribute("member", mPrincipalDetails.getMember());

		return "main_ex";
	}
	
//	==========================Member(auth)==================
	
	
	// 로그인 폼
	@GetMapping("login")
	public String loginform() {
		return "member/auth/login";
	}
	
	// 회원가입 폼
	@GetMapping("signup") 
	public String signupform() {
		return "member/auth/signup";
	}
		
	// 회원가입
	@PostMapping("MemberJoinPro")
	public String signup(@ModelAttribute @Valid MemberVO member, BindingResult bindingResult) {
//		public String signup(@ModelAttribute @Valid SignupVO signupVO, BindingResult bindingResult) {
		
		
		// 아이디 중복 유효성 검사
//	    if (memberService.isMemberIdDuplicated(member.getMem_id())) {
//	    	throw new CustomValidationException("이미 사용 중인 아이디입니다.", null);
//	    }

		// 생년월일 유효성 검사
		Date mem_birthday = member.getMem_birthday();
		if (mem_birthday == null) {
			throw new CustomValidationException("생년월일을 입력해주세요.", null);
		}
		
	    // 휴대폰 번호 유효성 검사
		if (memberService.isMemberPhoneDuplicated(member.getMem_mtel())) {
			throw new CustomValidationException("이미 사용 중인 번호입니다.", null);
		}  
			
		// 이메일 유효성 검사
		if (memberService.isMemberEmailDuplicated(member.getMem_email())) {
			throw new CustomValidationException("이미 사용 중인 이메일입니다.", null);
		}
		
	    // 회원가입 유효성 검사 - 유효성 검사 에러 난 애들 한 곳에 모아서(bindingResult에 의해) 처리 errorMap에 담긴 메세지는 @Vaildation 에 의해서 자동으로 적절한게 간다.
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
	        MemberVO memberEntity = memberService.registMember(member);
	        System.out.println("회원가입 성공 값들 " + memberEntity);
	        return "member/auth/login";
	    }

	}
	
	//id 중복 확인 - signup.js
    @ResponseBody
	@GetMapping("idCheck")
	public int idCheck(@RequestParam Map<String,String> map) {
		return memberService.memIdCheck(map);
	}
	
//    ===========================MyPage===========================
    // 마이페이지 폼
    @GetMapping("mypage")
    public String myPageForm(MemberVO member, Model model) {
//    	public String myPageForm(@PathVariable int mem_idx, Model model) {
//    	System.out.println("마이페이지 member" + member);
//		model.addAttribute("member", member);
    	
    	return "member/mypage/mypage2";
    }
    
    // 회원수정 폼
//    @GetMapping("mypage/{mem_idx}/update")
    @GetMapping("mypage/update")
    public String updateForm(@AuthenticationPrincipal PrincipalDetails principalDetails, Model model) {//@AuthenticationPrincipal 이녀석을 통해 시큐리티가 저장한 세션을 접근할 수 있다.
//    	public String updateForm(@PathVariable int mem_idx, @AuthenticationPrincipal PrincipalDetails principalDetails, Model model) {//@AuthenticationPrincipal 이녀석을 통해 시큐리티가 저장한 세션을 접근할 수 있다.
    	// 1. 실패..
    	System.out.println("세션 정보 :" + principalDetails.getMember());
		
    	// 2. 쓰읍 이 방법을 써야하는가 .. 
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		PrincipalDetails mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();
      
		// 주소 관련 값 설정
		if(mPrincipalDetails.getMember().getMem_address() != null) {
			mPrincipalDetails.getMember().setSample6_postcode(mPrincipalDetails.getMember().getMem_address().split("/")[0]); 
			mPrincipalDetails.getMember().setSample6_address(mPrincipalDetails.getMember().getMem_address().split("/")[1]);  
			mPrincipalDetails.getMember().setSample6_detailAddress(mPrincipalDetails.getMember().getMem_address().split("/")[2]);  
			mPrincipalDetails.getMember().setSample6_extraAddress(mPrincipalDetails.getMember().getMem_address().split("/")[3]); 
		}

      // 생년월일 관련 값 설정
		mPrincipalDetails.getMember().setMem_bir1(mPrincipalDetails.getMember().getMem_birthday().toString().split("-")[0]);  
		mPrincipalDetails.getMember().setMem_bir2(mPrincipalDetails.getMember().getMem_birthday().toString().split("-")[1]);  
		mPrincipalDetails.getMember().setMem_bir3(mPrincipalDetails.getMember().getMem_birthday().toString().split("-")[2]);  

      // 휴대폰번호 관련 값 설정
		mPrincipalDetails.getMember().setPhone1(mPrincipalDetails.getMember().getMem_mtel().split("-")[0]);  
		mPrincipalDetails.getMember().setPhone2(mPrincipalDetails.getMember().getMem_mtel().split("-")[1]);  
		mPrincipalDetails.getMember().setPhone3(mPrincipalDetails.getMember().getMem_mtel().split("-")[2]); 
		
		System.out.println("세션 정보2 : " + mPrincipalDetails.getMember());
    	
		model.addAttribute("member", mPrincipalDetails.getMember());
		
    	return "member/mypage/update";
    }	
    	
//    회원 수정 - ajax
//    @PostMapping("MemberUpdatePro")
//    public CMRespDto<?> updatePro(
//    	    @PathVariable int mem_idx, MemberVO member) {
//    	System.out.println("여기까지 오니?");
//    	MemberVO memberEntity = memberService.updateMemberInfo(mem_idx, member);
//    	System.out.println("업데이트 잘받니? " + memberEntity);
//
//        return new CMRespDto<>(1,"회원수정완료",memberEntity);
//    }
    
 // 회원수정
    @PostMapping("MemberUpdatePro")
    public String updatePro(@Valid MemberVO member, BindingResult bindingResult,
            @RequestParam String newPasswd, @RequestParam String newPasswd1,
            HttpSession session, Model model) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        PrincipalDetails mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();
        String securePasswd = member.getMem_passwd();
        String currentPasswd = mPrincipalDetails.getMember().getMem_passwd();
        System.out.println("currentPasswd : " + currentPasswd);
        System.out.println("member는 무슨 값 들고 있냐 ? " + member);

        if (member.getMem_passwd() == null || member.getMem_passwd().equals("")) {
            model.addAttribute("msg", "패스워드 입력 필수!");
            return "member/fail_back";
        } else if (!bCryptPasswordEncoder.matches(member.getMem_passwd(), currentPasswd)) {
            model.addAttribute("msg", "현재 비밀번호 불일치!");
            return "member/fail_back";
        }

        // 새 비밀번호가 둘 다 입력되었고 두 비밀번호 요소가 일치하면 새 비밀번호 유효성 검사를 수행합니다.
        if (!newPasswd.isEmpty() && !newPasswd1.isEmpty() && newPasswd.equals(newPasswd1)) {
            if (newPasswd.length() < 8 || newPasswd.length() > 20) {
                throw new CustomValidationException("새 비밀번호는 8자 이상 20자 이내로 입력해주세요.", null);
            } else {
                member.setNewPasswd1(newPasswd);
            }
        } else if (!newPasswd.equals(newPasswd1)) { // 새로운 비밀번호 두 개가 일치하지 않았을 경우
            model.addAttribute("msg", "비밀번호 확인 불일치!");
            return "member/fail_back";
        }

        if (bindingResult.hasErrors()) {
            System.out.println("회원수정 에러로 오니? ..?");
            Map<String, String> errorMap = new HashMap<>();
            for (FieldError error : bindingResult.getFieldErrors()) {
                errorMap.put(error.getField(), error.getDefaultMessage());
                System.out.println("================");
                System.out.println("회원수정 유효성 에러" + error.getDefaultMessage());
                System.out.println("================");
            }
            throw new CustomValidationException("회원 수정 실패", errorMap);
        } else {
            // 새 비밀번호 유효성 검사를 통과한 경우에만 인코딩된 새 비밀번호를 사용합니다.
            String encodedNewPassword = newPasswd.isEmpty() ? null : bCryptPasswordEncoder.encode(newPasswd);
            int insertCount = memberService.ModifyMember(member, newPasswd, encodedNewPassword);

            if (insertCount > 0) {
                MemberVO updatedMember = memberService.loadMemberData(member.getMem_id());
                mPrincipalDetails.setMember(updatedMember);
                model.addAttribute("member", updatedMember);
            }

            System.out.println("회원정보성공해서 member에 뭐가 들었음 ? " + mPrincipalDetails.getMember());
            model.addAttribute("msg", "회원 정보 수정 성공!");
            model.addAttribute("targetURL", "mypage/update");

            return "member/success_forward";
        }
    }
    
    // 회원탈퇴 폼
    @GetMapping("mypage/delete")
    public String deletForm() {
    	return "member/mypage/delete";
    }
    
//    =========================social============================
	@GetMapping("/social")
	public String story() {
		return "member/social/story";
	}
    
    
	@GetMapping("/social/{mem_idx}")
	public String profile(@PathVariable int mem_idx, Model model) {
//		User userEntity = userService.회원프로필(id);
//		model.addAttribute("user", userEntity);
		return "member/social/profile";
	}
    
    
}
