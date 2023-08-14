package com.pj2.shoecream.controller;

import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.context.HttpSessionSecurityContextRepository;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.pj2.shoecream.config.PrincipalDetails;
import com.pj2.shoecream.handler.BankHandler;
import com.pj2.shoecream.handler.CustomValidationException;
import com.pj2.shoecream.service.BankService;
import com.pj2.shoecream.service.MemberService;
import com.pj2.shoecream.util.FindUtil;
import com.pj2.shoecream.util.SendUtil;
import com.pj2.shoecream.vo.KakaoProfile;
import com.pj2.shoecream.vo.MemberUpdatePasswdVO;
import com.pj2.shoecream.vo.MemberUpdateVO;
import com.pj2.shoecream.vo.MemberVO;
import com.pj2.shoecream.vo.OAuthToken;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
public class MemberController {
	
	// 로그 확인
	private static final Logger log = LoggerFactory.getLogger(MemberController.class);
	
	@Autowired
	private MemberService memberService;
	private Map<String, String> codeMap; 
	
	@Autowired
	private BankService bankService;
	
	@Autowired
	private BankHandler bankHandler;
	
    private final BCryptPasswordEncoder bCryptPasswordEncoder;
		
//	==========================Member(auth)==================
	//폰 중복 확인
	@PostMapping("/phondCheck")
	@ResponseBody
	public int phoneCheck(@RequestParam("phone") String phone) {
		int cnt = memberService.phoneCheck(phone);
		return cnt;
	}
	
	//문자인증
	@PostMapping("/send-phone-authentication")
	@ResponseBody
    public String sendOne(@RequestParam("phone") String phone) {
		
		//인증번호 생성
		String code  = FindUtil.getRandomNum();
		String msg = "[슈크림 회원가입] 인증번호 ["+code+"]를 입력해 주세요.";
//		SingleMessageSentResponse response = 
		SendUtil.sendMsg(phone, msg);
		
		//코드랑 번호 저장
		codeMap = new HashMap<String, String>();
		codeMap.put("phone", code);

		return "0";
    }
	
	@PostMapping("/verify-phone-authentication")
	@ResponseBody
	public boolean phoneAut(@RequestParam("newCode") String newCode, HttpServletRequest request) {
		String code= codeMap.get("phone");
	
		boolean isCorrectCode = false;
		
		if(code.equals(newCode)) {
			System.out.println("인증완료");
			isCorrectCode = true;
		}
		
		return isCorrectCode;//
	}
	
	
	// 로그인 폼
	@GetMapping("login")
	public String loginform(Model model) {
		return "member/auth/login";
	}
	
	// 카카오 OAuth2 로그인 콜백
	@GetMapping(value = "auth/kakao/callback", produces = "application/json;charset=utf-8")
	public String kakaoCallback(String code, HttpSession httpSession) { // Data를 리턴해주는 컨트롤러 함수
		// POST 방식으로 key=value 데이터를 요청 (카카오쪽으로)
		// Restrofit2
		// OkHttp
		// RestTemplate
		RestTemplate rt = new RestTemplate();
		
		// HttpHeader 오브젝트 생성
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
		
		// HttpBody 오브젝트 생성
		MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
		params.add("grant_type", "authorization_code");
		params.add("client_id", "29eee1b4771daa5dc16c4084cc6defc9");
		params.add("redirect_uri", "http://localhost:8089/shoecream/auth/kakao/callback");
		params.add("code", code);
		
		// HttpHeader와 HttpBody를 하나의 오브젝트에 담기
		HttpEntity<MultiValueMap<String, String>> kakaoTokenRequest = 
				new HttpEntity<>(params,headers);
		
		// Http 요청하기 - Post방식으로 - 그리고 response 변수의 응답 받음.
		ResponseEntity<String> response = rt.exchange(
				"https://kauth.kakao.com/oauth/token",
				HttpMethod.POST,
				kakaoTokenRequest,
				String.class
		);
		
		// Gson, Json Simple, ObjectMapper
		ObjectMapper objectMapper = new ObjectMapper();
		OAuthToken oauthToken = null;
		
		try {
			oauthToken = objectMapper.readValue(response.getBody(), OAuthToken.class);
		} catch (JsonParseException e) {
			e.printStackTrace();
		} catch (JsonMappingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		System.out.println("카카오 엑세스 토큰 :" + oauthToken.getAccess_token());
		
		RestTemplate rt2 = new RestTemplate();
		
		// HttpHeader 오브젝트 생성
		HttpHeaders headers2 = new HttpHeaders();
		headers2.add("Authorization", "Bearer "+oauthToken.getAccess_token());
		headers2.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
//		headers2.add("property_keys", "['kakao_account.email', 'kakao_account.profile']");
		
		// HttpBody에 property_keys 추가
//		MultiValueMap<String, String> body2 = new LinkedMultiValueMap<>();
//		body2.add("property_keys", "[\"kakao_account.email\", \"kakao_account.profile\"]");
//		
//		// HttpHeader와 HttpBody를 하나의 오브젝트에 담기
		HttpEntity<MultiValueMap<String, String>> kakaoProfileRequest2 = 
				new HttpEntity<>(headers2);
		
		// Http 요청하기 - Post방식으로 - 그리고 response 변수의 응답 받음.
		ResponseEntity<String> response2 = rt2.exchange(
				"https://kapi.kakao.com/v2/user/me",
				HttpMethod.POST,
				kakaoProfileRequest2,
				String.class
		);
		System.out.println("response2.getBody() 값 :" + response2.getBody());
		
	
		ObjectMapper objectMapper2 = new ObjectMapper();
		KakaoProfile kakaoProfile = null;
		
		try {
			kakaoProfile = objectMapper2.readValue(response2.getBody(), KakaoProfile.class);
		} catch (JsonParseException e) {
			e.printStackTrace();
		} catch (JsonMappingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		System.out.println("카카오 아이디(번호) : " + kakaoProfile.getId());
		System.out.println("카카오 이메일 : " + kakaoProfile.getKakao_account().getEmail());
		System.out.println("카카오 닉네임 : " + kakaoProfile.getProperties().getNickname());
		
		System.out.println("슈크림서버 유저네임(mem_id) : " + kakaoProfile.getKakao_account().getEmail() +"_"+ kakaoProfile.getId());
		System.out.println("슈크림서버 이메일(mem_email) : " + kakaoProfile.getKakao_account().getEmail());
		System.out.println("슈크림서버 닉네임(mem_nickname) : " + kakaoProfile.getProperties().getNickname());
		UUID garbagePassword = UUID.randomUUID();
		System.out.println("슈크림서버 패스워드 : " + garbagePassword);
		
		MemberVO kakaoMember = new MemberVO();
		kakaoMember.setMem_id(kakaoProfile.getKakao_account().getEmail() +"_"+ kakaoProfile.getId());
		kakaoMember.setMem_passwd(garbagePassword.toString());
		kakaoMember.setMem_name(kakaoProfile.getProperties().getNickname());
		kakaoMember.setMem_nickname(kakaoProfile.getProperties().getNickname());
		kakaoMember.setMem_email(kakaoProfile.getKakao_account().getEmail());
		
		// 가입자 혹은 비가입자 체크 해서 처리
		MemberVO originMember =  memberService.selectMember(kakaoMember.getMem_id());
		
		if (originMember == null) {
		    System.out.println("신규 회원입니다.");
		    memberService.registMember(kakaoMember);
		    originMember = memberService.selectMember(kakaoMember.getMem_id()); // 신규 회원 가입 후 mem_idx를 포함한 회원 정보를 조회
		} else {
		    System.out.println("기존 회원입니다.");
		    originMember = memberService.updateAndReturnMemberWithKakao(kakaoMember);
		}
		
		// 로그인 처리
		PrincipalDetails user = new PrincipalDetails(originMember);
		Authentication authentication = new UsernamePasswordAuthenticationToken(user, null, user.getAuthorities());
		SecurityContextHolder.getContext().setAuthentication(authentication);
		httpSession.setAttribute(HttpSessionSecurityContextRepository.SPRING_SECURITY_CONTEXT_KEY, SecurityContextHolder.getContext());
		
		//		return response2.getBody();
		return "redirect:/";
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
	    if (memberService.isMemberIdDuplicated(member.getMem_id())) {
	    	throw new CustomValidationException("이미 사용 중인 아이디입니다.", null);
	    }

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
	
//	@PostMapping("auth/kakao/callback")
	 
	
	//id 중복 확인 - signup.js
    @ResponseBody
	@GetMapping("idCheck")
	public int idCheck(@RequestParam Map<String,String> map) {
		return memberService.memIdCheck(map);
	}
    
	//아이디 비밀번호 찾기페이지
	@GetMapping("find/memid")
	public String memberFind() {
		return "member/auth/find";
	}
	
	// 아이디 찾기
	@PostMapping("find/findIdPro")
	public String findIdPro(MemberVO member, Model model) {
		//로그인 방식으로 다시 시도 해봅니다..
		String idResult = memberService.getId(member);
//		System.out.println(idResult);
		model.addAttribute("idResult",idResult);
		
		//성공 실패 나누기
		if(idResult == null) {
			model.addAttribute("msg", "입력하신 정보와 일치하는 아이디가 없습니다.");
			return "member/auth/fail_back";
		}
		return "member/auth/find_id";
	}
	
	// 비밀번호 찾기
	@PostMapping("find/findPwPro")
	public String findPwPro(MemberVO member, Model model) {
		//아이디 이름 번호 받아와서 일치하면(DB작업1)
		String mem_id = memberService.isExistUser(member);
		System.out.println("비번 찾을 mem_id : " + mem_id);
		if(mem_id == null) {
			model.addAttribute("msg", "입력하신 정보와 일치하는 아이디가 없습니다.");
			return "member/auth/fail_back";
		}
//		String mem_email = memberService.selectEmail(member);
		//조회된 정보가 있으면
		//임시 비밀번호 만들기
		String newPwd = FindUtil.getRamdomPassword();
		
		//임시 비밀번호 암호화
		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		String securePasswd = passwordEncoder.encode(newPwd);
		member.setMem_passwd(securePasswd);
		
		//파라미터가 고민이 된다 암호화 한 비밀번호를 넣어야함
		//어쨋든 암호화한 비밀번호 DB에 수정하는 작업.
		int updateCount = memberService.changePw(member);
		
		System.out.println(updateCount);
		
		if(updateCount>0) {
			//메일 발송 하자구
			String subject = "[Gabolcar] 임시 비밀번호 입니다.";
			String msg = "회원님의 임시 비밀번호는 "+newPwd+" 입니다.\n 로그인 후 비밀번호를 변경 하세요";
			SendUtil.sendMail(mem_id, subject, msg);
			System.out.println("발송완료");
		}
		//메일로 임시 비밀번호를 발송 했습니다. 실패시 정보를 확인해주세요 등의  msg
		//비밀번호 어떻게 발송 합니까?
		//비밀번호 발송 하고 임시 비밀번호를 DB에 등록 해야한다(DB작업2)
		model.addAttribute("mem_id",mem_id);
		
		return "member/auth/find_pw";
	}
		
	// 회원탈퇴 (role = USER_REST 로 바꾸기)
	@GetMapping("mypage/delete")
	public String deleteForm() {
		return "member/mypage/delete";
	}
	
	@PostMapping("MemberDeletePro")
	public String deletePro(Model model) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        PrincipalDetails mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();
		int sId = mPrincipalDetails.getMember().getMem_idx();
		
		int deleteCount = memberService.deleteMember(sId);
		if(deleteCount == 0) {
			model.addAttribute("msg", "회원 탈퇴 실패!");
			return "member/fail_back";
		} else {
			model.addAttribute("msg", "회원 탈퇴가 완료되었습니다!");
			model.addAttribute("targetURL", "login");
			return "member/success_forward";
		}
	}
	
//    ===========================MyPage===========================
    
    // 회원수정 정보 폼 (마이페이지 메인)
//    @GetMapping("mypage/{mem_idx}/update")
    @GetMapping("mypage/update")
    public String updateForm(Model model) {//@AuthenticationPrincipal 이녀석을 통해 시큐리티가 저장한 세션을 접근할 수 있다.
//    	public String updateForm(@PathVariable int mem_idx, @AuthenticationPrincipal PrincipalDetails principalDetails, Model model) {//@AuthenticationPrincipal 이녀석을 통해 시큐리티가 저장한 세션을 접근할 수 있다.
    	// 1. 실패..
//    	System.out.println("세션 정보 :" + principalDetails.getMember());
		
    	// 2. 쓰읍 이 방법을 써야하는가 .. 
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		PrincipalDetails mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();
		
		// 주소 관련 값 설정
		if(mPrincipalDetails.getMember().getMem_address() != null) {
			mPrincipalDetails.getMember().setSample6_postcode(mPrincipalDetails.getMember().getMem_address().split("/")[0]); 
			mPrincipalDetails.getMember().setSample6_address(mPrincipalDetails.getMember().getMem_address().split("/")[1]);  
			mPrincipalDetails.getMember().setSample6_detailAddress(mPrincipalDetails.getMember().getMem_address().split("/")[2]);  
			mPrincipalDetails.getMember().setSample6_extraAddress(mPrincipalDetails.getMember().getMem_address().split("/")[3]); 
		} else { 
			mPrincipalDetails.getMember().setSample6_postcode(""); 
			mPrincipalDetails.getMember().setSample6_address("");  
			mPrincipalDetails.getMember().setSample6_detailAddress("");  
			mPrincipalDetails.getMember().setSample6_extraAddress(""); 
		}
      // 생년월일 관련 값 설정
		if(mPrincipalDetails.getMember().getMem_birthday() != null) {
			mPrincipalDetails.getMember().setMem_bir1(mPrincipalDetails.getMember().getMem_birthday().toString().split("-")[0]);  
			mPrincipalDetails.getMember().setMem_bir2(mPrincipalDetails.getMember().getMem_birthday().toString().split("-")[1]);  
			mPrincipalDetails.getMember().setMem_bir3(mPrincipalDetails.getMember().getMem_birthday().toString().split("-")[2]);  
		} else {
			mPrincipalDetails.getMember().setMem_bir1("");  
			mPrincipalDetails.getMember().setMem_bir2("");  
			mPrincipalDetails.getMember().setMem_bir3("");
		}
//
//      // 휴대폰번호 관련 값 설정
		if(mPrincipalDetails.getMember().getMem_mtel() != null) {
			mPrincipalDetails.getMember().setPhone1(mPrincipalDetails.getMember().getMem_mtel().split("-")[0]);  
			mPrincipalDetails.getMember().setPhone2(mPrincipalDetails.getMember().getMem_mtel().split("-")[1]);  
			mPrincipalDetails.getMember().setPhone3(mPrincipalDetails.getMember().getMem_mtel().split("-")[2]); 
		} else {
			mPrincipalDetails.getMember().setPhone1("");  
			mPrincipalDetails.getMember().setPhone2("");  
			mPrincipalDetails.getMember().setPhone3(""); 
		}
		
		System.out.println("세션 정보2 : " + mPrincipalDetails.getMember());
    	
		model.addAttribute("member", mPrincipalDetails.getMember());
		
    	return "member/mypage/update";
    }	
    
    // 회원수정 프로
    @PostMapping("MemberUpdatePro")
    public String updatePro(@Valid MemberUpdateVO member, BindingResult bindingResult, HttpSession session, Model model) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        PrincipalDetails mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();

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
            int insertCount = memberService.ModifyMember(member);

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
    
    
    
    // 회원수정 비밀번호 번경 폼
    @GetMapping("mypage/updatePasswd")
    public String updatePasswdForm(Model model) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		PrincipalDetails mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();
		System.out.println("회원수정 비밀번호 변경 폼 : " + mPrincipalDetails.getMember());
		model.addAttribute("member", mPrincipalDetails.getMember());
    	return "member/mypage/updatePasswd";
    }
    
 // 회원수정 패스워드
    @PostMapping("MemberPasswdUpdatePro")
    public String updatePasswdPro(@Valid MemberUpdatePasswdVO member, BindingResult bindingResult,
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
            int insertCount = memberService.ModifyMemberPasswd(member, newPasswd, encodedNewPassword);

            if (insertCount > 0) {
                model.addAttribute("msg", "회원 정보 수정 성공!");
                model.addAttribute("targetURL", "mypage/updatePasswd");
            }

            return "member/success_forward";
        }
    }
    
    // 마이페이지 프로필
    @GetMapping("/mypage/profile")
    public String profileImageForm(Model model) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        PrincipalDetails mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();
        int sId = mPrincipalDetails.getMember().getMem_idx();
        
        // 프로필 관리에 들고갈 모델값
        Map<String, Object> member = memberService.getProfileMember(sId);
        model.addAttribute("member", member);
    	return "member/mypage/profile";
    }
    
    @PostMapping("ProfileUpdatePro")
    public String profileImagePro(MemberVO member, HttpSession session, Model model, BindingResult bindingResult) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		PrincipalDetails mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();
    	
		memberService.ProfileUpload(member, mPrincipalDetails, session);
        return "redirect:/mypage/profile";

    }
    
    // 마이페이지 - 내 계좌 및 포인트
    // 0811 경인 수정 
    // 계좌 정보와 포인트 출력을 위한 정보 넘겨주기
    @GetMapping("mypage/account")
    public String accountform(Model model) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		PrincipalDetails mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();
		
		
		// 현재 접속 유저 idx 가져오기
		int idx = mPrincipalDetails.getMember().getMem_idx();
		
		// 최신 유저정보 불러오기
		// 이유 : spring security 의 유저 정보가 항상 새 데이터가 아님
		MemberVO member = memberService.getMemberByIdx(idx);

		if(!member.getMem_account_auth().equals("Y")) {
			model.addAttribute("msg", "계좌인증이 되지 않았습니다! 회원 정보 수정에서 계좌 인증을 진행해주세요!");
			return "/inc/fail_back";
		}

		// 계좌 정보 가져오기
		Map<String,Object> account = bankService.getMemAccount(idx);
		
		// 계좌정보 확인
		if(account == null) {
			model.addAttribute("msg", "사용자 계좌 정보를 불러올수 없습니다! 관리자에게 문의해주세요");
			return "/inc/fail_back";
		}
		
		System.out.println(account);
		// 은행 코드로 은행 이름 가져오기
		String bankName = bankHandler.bankCode2BankName((String)account.get("bank_code_std"));
		
		model.addAttribute("account", account);
		model.addAttribute("member", member);
		if(bankName == null) {
			bankName = "기타은행(관리자 문의)";
		}
		model.addAttribute("bank_name",bankName);
    	
		return "member/mypage/account";
    }
   	
}
