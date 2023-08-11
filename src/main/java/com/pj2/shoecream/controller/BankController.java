package com.pj2.shoecream.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pj2.shoecream.config.PrincipalDetails;
import com.pj2.shoecream.service.BankApiService;
import com.pj2.shoecream.service.BankService;
import com.pj2.shoecream.service.MemberService;
import com.pj2.shoecream.vo.AdminAccountInoutVO;
import com.pj2.shoecream.vo.BankAccountDetailVO;
import com.pj2.shoecream.vo.BankAccountVO;
import com.pj2.shoecream.vo.MemberVO;
import com.pj2.shoecream.vo.ResponseDepositVO;
import com.pj2.shoecream.vo.ResponseTokenVO;
import com.pj2.shoecream.vo.ResponseUserInfoVO;
import com.pj2.shoecream.vo.ResponseWithdrawVO;

@Controller
public class BankController {
	
	@Autowired
	private BankApiService bankApiService;
	
	@Autowired
	private MemberService memService;
	
	@Autowired
	private BankService bankService;
	
	// 로그 출력을 위한 변수 선언 => getLogger() 메서드 파라미터로 로그를 처리할 현재 클래스 지정
	private static final Logger logger = LoggerFactory.getLogger(BankController.class);
	
	// 사용자 인증 생략
	@ResponseBody
	@GetMapping("authorize")
	public String requestAuth(HttpSession session, Model model) {
		String access_token = (String)session.getAttribute("access_token");
		String user_seq_no = (String)session.getAttribute("user_seq_no");
		
		return bankApiService.requestAuth(access_token, user_seq_no);
	}
	
	// 2.1.1. 사용자인증 API (3-legged)
	// 사용자 인증 요청에 따른 콜백을 통해 인증코드를 전달받기
	// => 파라미터 : Map<String, String>, Model, HttpSession
	//               (Map 타입 객체로 응답데이터를 모두 저장)
	@GetMapping("callback")
	public String responseAuthCode(
			@RequestParam Map<String, String> authResponse, Model model, HttpSession session) {
		// 로거 사용 시 logger.xxx() 메서드로 로그에 출력할 데이터를 파라미터로 전달
		logger.info(authResponse.toString());
		
		// spring security 에서 회원번호 받아오기
		int idx = -1;
		MemberVO member = null;
		try {
			Authentication auth = SecurityContextHolder.getContext().getAuthentication();
			PrincipalDetails mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();
			

			// 구매자 회원번호
			idx = mPrincipalDetails.getMember().getMem_idx();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			System.out.println("error : JunggoPay");
			// 로그인 안되어있으면 로그인 화면으로 되돌려 보내기
			model.addAttribute("msg","권한이 없습니다 ! 로그인 해주세요");
			model.addAttribute("targetURL","login"); // 로그인 페이지 넘어갈 때 리다이렉트 할수있는거 있어야 될듯?
			return "inc/fail_forward";
		}
		
		// 인증 실패 시(= 인증 정보 존재하지 않을 경우) 오류 메세지 출력 및 인증 창 닫기
		if(authResponse == null || authResponse.get("code") == null) {
			// Model 객체를 통해 출력할 메세지(msg) 전달 및 창 닫기 여부(isClose)도 전달
			model.addAttribute("msg", "인증 오류 발생! 다시 인증하세요!");
			return "inc/close";
		}
		
		// 2.1.2. 토큰발급 API - 토큰 발급 요청
		// REST 방식 요청을 통해 인증코드를 사용하여 엑세스토큰 발급 요청
		// => BankApiService - requestToken() 메서드를 호출하여 엑세스토큰 발급 요청
		// => 파라미터 : 사용자 인증을 통해 전달받은 정보(Map 객체)
		//    리턴타입 : 엑세스토큰 관련 정보를 관리할 ResponseTokenVO 타입(responseToken)
		ResponseTokenVO responseToken = bankApiService.requestToken(authResponse);
		logger.info("★★★★★ Access Token : " + responseToken.toString());
		
		// 만약, 리턴받은 엑세스토큰이 없을 경우 오류 메세지 출력 및 인증창 닫기
//		if(responseToken.getAccess_token() == null) {
//			// Model 객체를 통해 출력할 메세지(msg) 전달 및 창 닫기 여부(isClose)도 전달
//			model.addAttribute("msg", "토큰 발급 오류 발생! 다시 인증하세요!");
//			return "inc/close";
//		}
		
		// BankService - registToken() 메서드를 호출하여 토큰 관련 정보를 DB 에 저장(fintech5.token)
		// => 파라미터 : 세션 아이디, 응답데이터가 저장된 ResponseTokenVO 객체
		//    리턴타입 : boolean(isRegistSuccess)
		
//		boolean isRegistSuccess = bankService.registToken(idx, responseToken);
//		
//		if(!isRegistSuccess) {
//			model.addAttribute("msg", "계좌정보 등록 오류 발생! 다시 인증하세요!");
//			return "inc/close";
//		}
		
		// 은행 상세 정보 저장
		
		String access_token = responseToken.getAccess_token();
		String user_seq_no = responseToken.getUser_seq_no();
		
		// BankApiService - requestUserInfo() 메서드 호출하여 핀테크 이용자 정보 조회
		// => 파라미터 : 엑세스토큰, 사용자번호   리턴타입 : ResponseUserInfoVO(userInfo)
		ResponseUserInfoVO userInfo = bankApiService.requestUserInfo(access_token, user_seq_no);
		
		// 인증 실패 시(= 인증 정보 존재하지 않을 경우) 오류 메세지 출력 및 인증 창 닫기
		if(userInfo == null) {
			// Model 객체를 통해 출력할 메세지(msg) 전달 및 창 닫기 여부(isClose)도 전달
			model.addAttribute("msg", "계좌 정보 조회에 실패하였습니다! 다시 시도해주세요");
			return "inc/close";
		}
		
		
		// 요청에 사용될 엑세스토큰을 Map 객체에 추가
		List<BankAccountVO> resList = userInfo.getRes_list();
		BankAccountVO account = resList.get(resList.size() - 1);

		Map<String, String> map = new HashMap<String,String>();
		
		map.put("access_token", access_token);
		map.put("fintech_use_num", account.getFintech_use_num());
		map.put("account_num_masked", account.getAccount_num_masked());
		logger.info("●●●●● bankAccountDetail : " + map);
		
		// BankApiService - requestAccountDetail() 메서드 호출하여 계좌 상세정보 조회 요청
		// => 파라미터 : Map 객체   리턴타입 : BankAccountDetailVO(accountDetail)
		BankAccountDetailVO accountDetail = bankApiService.requestAccountDetail(map);
		
		
		// 세션 객체에 엑세스토큰(access_token)과 사용자번호(user_seq_no) 저장
		session.setAttribute("access_token",access_token );		
		session.setAttribute("user_seq_no", user_seq_no);	
		
		// db에 필요한 항목 들고와서 저장
		// map 으로 받기
		Map<String,Object> result = new HashMap<String,Object>();
		
		result.put("mem_idx", idx);
		result.put("mem_seq_no", user_seq_no);
		result.put("access_token", access_token);
		result.put("refresh_token",responseToken.getRefresh_token());
		result.put("bank_code_std", account.getBank_code_std());
		result.put("account_num", account.getAccount_num_masked());
		result.put("fintech_use_num", account.getFintech_use_num());
		result.put("balance_amt", accountDetail.getBalance_amt());
		
		// db 에 저장하기
		if(!bankService.registAccount(result)) {
			// Model 객체를 통해 출력할 메세지(msg) 전달 및 창 닫기 여부(isClose)도 전달
			model.addAttribute("msg", "계좌 정보 등록에 실패하였습니다! 다시 시도해주세요");
			return "inc/close";
		}
		
		// 유저 db에 저장하기
		if(!memService.changeMemAccountAuth(idx, "Y")) {
			model.addAttribute("msg", "계좌 인증 완료 정보 등록에 실패하였습니다! 다시 시도해주세요");
			return "inc/close";			
		}
		
		model.addAttribute("msg", "계좌인증 완료!");
		model.addAttribute("targetURL", "/mypage/update");
		model.addAttribute("isClose", true); // true : 창 닫기, false : 창 닫기 X(이전페이지로 돌아가기)
		
		return "inc/success_forward";
	}
	
	
	// 계좌에서 포인트 충전폼 
	@GetMapping("chargePointForm")
	public String chargePointForm(@RequestParam Map<String,Object> map , Model model) {
		int idx = -1;
		// 로그인 되어있는지 확인하기
		try {
			Authentication auth = SecurityContextHolder.getContext().getAuthentication();
			PrincipalDetails mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();
			// 구매자 회원번호
			idx = mPrincipalDetails.getMember().getMem_idx();		

		}
		catch(Exception e) {
			// 로그인 안되어있으면 잘못된 접근이라고 띄우기
			model.addAttribute("msg","잘못된 접근입니다");
			return "inc/fail_back";
		}
		
		// 현재 맴버가 계좌등록이 되어있는지 확인
		if(!memService.getAccountAuth(idx).equals("Y")) {
			model.addAttribute("msg","계좌 인증이 필요합니다!");
			return "inc/fail_back";
		}
		
		// 충전 회원 정보 담기
		model.addAttribute("member",memService.getMemberByIdx(idx));
		model.addAttribute("account", bankService.getMemAccount(idx));
		
		// 충전 후 되돌아갈 url 담기 (없으면 비워도 됨)
		model.addAttribute("return_url",map.get("return_url"));
		return "inc/pay/point_charge";
	}
	
	// 계좌에서 돈 빼고 포인트 충전
	// 되돌아갈 url 받아오기 !!
	@GetMapping("chargePointPro")
	public String chargePointPro(@RequestParam Map<String,String> map , Model model) {
		int idx = -1;
		// 로그인 되어있는지 확인하기
		try {
			Authentication auth = SecurityContextHolder.getContext().getAuthentication();
			PrincipalDetails mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();
			// 구매자 회원번호
			idx = mPrincipalDetails.getMember().getMem_idx();		
			
		}
		catch(Exception e) {
			// 로그인 안되어있으면 잘못된 접근이라고 띄우기
			model.addAttribute("msg","잘못된 접근입니다");
			return "inc/fail_back";
		}
		
		// 현재 맴버가 계좌등록이 되어있는지 확인
		if(!memService.getAccountAuth(idx).equals("Y")) {
			model.addAttribute("msg","계좌 인증이 필요합니다!");
			return "inc/fail_back";
		}
		
		Map<String, Object> account = bankService.getMemAccount(idx);
		
		// Map 객체에 엑세스토큰 추가
		map.put("access_token", (String)account.get("access_token"));
		
		// BankApiService - requestWithdraw() 메서드를 호출하여 출금이체 요청
		// => 파라미터 : Map 객체   리턴타입 : ResponseWithdrawVO
		ResponseWithdrawVO withdrawResult = bankApiService.requestWithdraw(map);
		
		// 입금 상태 확인하여 실패시 에러처리
		if(!withdrawResult.getBank_rsp_code().equals("000")) {
			model.addAttribute("msg","포인트 충전이 정상적으로 진행되지 않았습니다! (출금 문제)");
			return "inc/fail_back";
		}
		
		// 멤버 db 에 업데이트 처리
		if(!memService.updatePointAmount(idx,Integer.parseInt( map.get("point_amount")))) {
			model.addAttribute("msg","포인트 충전이 정상적으로 진행되지 않았습니다!(DB error)");
			return "inc/fail_back";
		}
		
		// 관리자 계좌 현황과 관리자 계좌 잔액 업데이트 하기
		
		AdminAccountInoutVO admAccountInout = new AdminAccountInoutVO();
		admAccountInout.setMem_idx(idx);
		admAccountInout.setTran_amount(Integer.parseInt( map.get("point_amount")));
		admAccountInout.setTran_type("w");		
		
		if(!bankService.addAdmAccountLog(admAccountInout)) {
			model.addAttribute("msg","포인트 충전이 정상적으로 진행되지 않았습니다!(DB error)");
			return "inc/fail_back";
		}
		
		
		// Model 객체에 ResponseWithdrawVO 객체 저장
//		model.addAttribute("withdrawResult", withdrawResult);
		logger.debug(withdrawResult.toString());
		model.addAttribute("msg","포인트가 충전되었습니다!");
		
		// 되돌아갈 url 이 있다면 그 url 로 되돌아가기
		if(map.get("return_url") != null) {
			model.addAttribute((String)map.get("return_url"));
			return "success_forward";
		}
		else {
			return "inc/fail_back";
		}
		
		
	}
	
	
	// =========== 
	
	// 2.2. 사용자/계좌 관리 
	// - 2.2.1. 사용자정보조회 API
	@GetMapping("bankUserInfo")
	public String requestUserInfo(HttpSession session, Model model) {
		// 세션에 저장된 엑세스토큰 및 사용자 번호를 변수에 저장
		String access_token = (String)session.getAttribute("access_token");
		String user_seq_no = (String)session.getAttribute("user_seq_no");
		logger.info("●●●●● access_token : " + access_token);
		logger.info("●●●●● user_seq_no : " + user_seq_no);
		
		// 엑세스토큰이 없을 경우 "계좌 인증 필수!" 메세지 출력 후 이전페이지로 돌아가기
		if(access_token == null) {
			model.addAttribute("msg", "계좌 인증 필수!");
			return "fail_back";
		}
		
		// BankApiService - requestUserInfo() 메서드 호출하여 핀테크 이용자 정보 조회
		// => 파라미터 : 엑세스토큰, 사용자번호   리턴타입 : ResponseUserInfoVO(userInfo)
		ResponseUserInfoVO userInfo = bankApiService.requestUserInfo(access_token, user_seq_no);
		logger.info("●●●●● userInfo : " + userInfo);
		
		// Model 객체에 ResponseUserInfoVO 객체 저장
		model.addAttribute("userInfo", userInfo);
		
		return "member/mypage/bank_user_info";
	}
	
	// 2.3. 조회서비스(사용자) - 2.3.1. 잔액조회 API
	// => 예금주명, 계좌번호(마스킹), 핀테크이용번호 파라미터 => Map 타입으로 처리
	@PostMapping("bankAccountDetail")
	public String requestAccountDetail(@RequestParam Map<String, String> map, HttpSession session, Model model) {
		// 미로그인 또는 엑세스토큰 없으면 "권한이 없습니다!" 출력 후 이전페이지로 돌아가기
		if(session.getAttribute("sId") == null || session.getAttribute("access_token") == null) {
			model.addAttribute("msg", "권한이 없습니다!");
			return "fail_back";
		}
		
		// 요청에 사용될 엑세스토큰을 Map 객체에 추가
		map.put("access_token", (String)session.getAttribute("access_token"));
		logger.info("●●●●● bankAccountDetail : " + map);
		
		// BankApiService - requestAccountDetail() 메서드 호출하여 계좌 상세정보 조회 요청
		// => 파라미터 : Map 객체   리턴타입 : BankAccountDetailVO(accountDetail)
		BankAccountDetailVO accountDetail = bankApiService.requestAccountDetail(map);
		logger.info("●●●●● BankAccountDetailVO : " + accountDetail);
		
		// Model 객체에 조회 결과 저장 - BankAccountDetailVO 객체, 예금주명, 계좌번호(마스킹)
		model.addAttribute("accountDetail", accountDetail);
		model.addAttribute("account_num_masked", map.get("account_num_masked"));
		model.addAttribute("user_name", map.get("user_name"));
		
		return "bank/bank_account_detail";
	}
	
	// 2.5. 이체서비스 - 2.5.1. 출금이체 API 요청을 위한 폼 생성(PDF p74)
	// 출금이체? 나(사용자) -> 핀테크이용기관(핀테크에서의 출금이체) 또는 나 -> 상대방(일반적인 개념의 이체)
	// 이 때, 나 -> 상대방의 경우 나 -> 핀테크이용기관 -> 상대방의 과정을 거쳐야하며
	// 나 -> 핀테크이용기관은 출금이체, 핀테크이용기관 -> 상대방은 입금이체를 수행해서 이체가 완료된다.
	@PostMapping("bankWithdraw")
	public String requestWithdraw(@RequestParam Map<String, String> map, HttpSession session, Model model) {
		// 미로그인 또는 엑세스토큰 없으면 "권한이 없습니다!" 출력 후 이전페이지로 돌아가기
		if(session.getAttribute("sId") == null || session.getAttribute("access_token") == null) {
			model.addAttribute("msg", "권한이 없습니다!");
			return "fail_back";
		}
		
		// Map 객체에 엑세스토큰 추가
		map.put("access_token", (String)session.getAttribute("access_token"));
		
		// BankApiService - requestWithdraw() 메서드를 호출하여 출금이체 요청
		// => 파라미터 : Map 객체   리턴타입 : ResponseWithdrawVO
		ResponseWithdrawVO withdrawResult = bankApiService.requestWithdraw(map);
		
		// Model 객체에 ResponseWithdrawVO 객체 저장
		model.addAttribute("withdrawResult", withdrawResult);
		
		return "bank/bank_withdraw_result";
	}
	
	@PostMapping("bankDeposit")
	public String requestDeposit(@RequestParam Map<String, String> map, HttpSession session, Model model) {
		// 미로그인 또는 엑세스토큰 없으면 "권한이 없습니다!" 출력 후 이전페이지로 돌아가기
		if(session.getAttribute("sId") == null || session.getAttribute("access_token") == null) {
			model.addAttribute("msg", "권한이 없습니다!");
			return "fail_back";
		}
		
		// Map 객체에 엑세스토큰 추가
		map.put("access_token", (String)session.getAttribute("access_token"));
		
		// BankApiService - requestDeposit() 메서드를 호출하여 입금이체 요청
		// => 파라미터 : Map 객체   리턴타입 : ResponseDepositVO
		ResponseDepositVO depositResult = bankApiService.requestDeposit(map);
		
		// Model 객체에 ResponseDepositVO 객체 저장
		model.addAttribute("depositResult", depositResult);
		
		return "bank/bank_deposit_result";
	}
	
}






















