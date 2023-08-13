package com.pj2.shoecream.controller;

import java.util.HashMap;
import java.util.Map;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pj2.shoecream.config.PrincipalDetails;
import com.pj2.shoecream.service.ChatService;
import com.pj2.shoecream.service.JungProductService;
import com.pj2.shoecream.service.MemberService;
import com.pj2.shoecream.service.PayService;
import com.pj2.shoecream.vo.MemberVO;
import com.pj2.shoecream.vo.PayInfoVO;
import com.pj2.shoecream.vo.PointInoutVO;

@Controller
public class PayController {
	
	@Autowired
	private PayService service;
	
	@Autowired
	private MemberService memService;
	
	@Autowired
	private JungProductService jProductService;
	
	@Autowired
	private ChatService chatService;
	
	// 결제 정보창 열기
	// payForm 사용시 필요한 파라미터
	/* 
	 * 중고 , 경매 또는 크림 중 하나 product_selector
	 * 
	 * 상품 번호 product_idx
	 * 상품 이름 product_title
	 * 상품 가격 product_price
	 * 상품 설명 product_info
	 * 
	 * 판매자 닉네임 mem_seller_nickname
	 * 판매자 유저 점수 mem_seller_rank
	 * 판매자 판매 횟수 mem_seller_sellCount
	 */
	@GetMapping("payForm")
	public String payForm(@RequestParam Map<String,Object> map , Model model) {
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
		// 구매자 정보 받기
		model.addAttribute("member" , memService.getMemberByIdx(idx));
		System.out.println(map);
		model.addAttribute("map" , map);
		
		return "inc/pay/pay_form";
	}
	
	@GetMapping("shoePay")
	public String shoePay(@RequestParam Map<String,Object> map , Model model) {
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
		// 구매자 정보 담기
		model.addAttribute("member",memService.getMemberByIdx(idx));
		
		Integer product_selector = Integer.parseInt((String)map.get("product_selector"));
		
		
		// 결제가 어디서 왔는지 따라서 데이터 받기
		if(product_selector != null) {
			// 중고의 경우
			if(product_selector == 0) {
				
				Map<String,Object> productEx = jProductService.getJungProductExtend((String)map.get("product_idx"));
				String product_sell_status = (String)productEx.get("product_sell_status");
				String product_payment = (String)productEx.get("product_payment");
				// 현재 물품의 거래 상황과 예약중인 유저 체크
				if(productEx != null 
						&& (product_sell_status).equals("예약중")
						&& (product_payment.equals("안전페이") || product_payment.equals("안전페이,직거래"))
						&& (Integer)productEx.get("product_buyer_idx") == idx) {			
					model.addAttribute("map",productEx);
					return "inc/pay/shoe_pay";
				} 
				// 만약 다른 거래 상황이면 ...
				else if(product_sell_status.equals("대기중")){
					model.addAttribute("msg","예약 진행중이 아닙니다 예약 진행 먼저 해주세요");
				}
				else if( product_sell_status.equals("거래대기중") 
						&& (Integer)productEx.get("product_buyer_idx") == idx) {
					model.addAttribute("msg","이미 결제된 상태 입니다!!");
					
				}
				// 이미 자신이 아닌 다른 사람이 예약, 거래 중 이라면
				else if(product_sell_status.equals("예약중")
						|| product_sell_status.equals("거래대기중")){
					model.addAttribute("msg","다른 유저가 예약중에 있습니다!");
				}
				else if(product_sell_status.equals("거래완료")){
					model.addAttribute("msg","이미 거래가 완료된 상품입니다");
				}
				else {
					model.addAttribute("msg","잘못된 접근입니다");
				}
				return "inc/fail_back";
			}	
		}
		model.addAttribute("msg","잘못된 접근입니다");
		return "inc/fail_back";
	}
	

	
	
	
	// ==================== ajax =====================
	
	@RequestMapping(
			value = "payWithPoint.ajax",
			method = RequestMethod.POST,
			produces = "application/text; charset=UTF-8"
	)	
	@ResponseBody
	public String payPoint(@RequestParam Map<String,Object> map , Model model) {
		
		// 리턴 보낼 json 
		JSONObject jo = new JSONObject();
		
		//에러 기록 string
		String error = "etc";
		int idx = -1;
		MemberVO member = null;
		// 로그인 되어있는지 확인하기
		try {
			Authentication auth = SecurityContextHolder.getContext().getAuthentication();
			PrincipalDetails mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();
			
			// 구매자 회원번호
			idx = mPrincipalDetails.getMember().getMem_idx();		
		}
		catch(Exception e) {
			// 로그인 안되어있으면 잘못된 접근이라고 띄우기
			jo.put("error", "login error");
			return jo.toString();
		}
		
		// 현재 접속중 멤버 가져오기
		member = memService.getMemberByIdx(idx);
		// 페이 정보 저장 객체 2개
		PayInfoVO payInfo = new PayInfoVO();
		PointInoutVO pointInout = new PointInoutVO();
		
		// 결제가 어디에서(중고 , 경매 등) 왔는지 받아오기
		Integer product_selector = Integer.parseInt((String)map.get("product_selector"));
		boolean isPayReady = false;
		// 결제가 어디서 왔는지 따라서 데이터 받기
		if(product_selector != null) {
			
			// =========== 중고거래일때
			if(product_selector == 0) {
				
				// 상품 정보 가져오기
				Map<String,Object> productEx = jProductService.getJungProductExtend((String)map.get("product_idx"));
				String product_sell_status = (String)productEx.get("product_sell_status");
				String product_payment = (String)productEx.get("product_payment");
				// 현재 물품의 거래 상황과 예약중인 유저 체크
				if(productEx != null 
						&& (product_sell_status).equals("예약중")
						&& (product_payment.equals("안전페이") || product_payment.equals("안전페이,직거래"))
						&& (Integer)productEx.get("product_buyer_idx") == idx) {			
					isPayReady = true;
					
					// 페이 결제 시작 
					// 페이 결제시 사용할 객체에 정보 담기
					payInfo.setMem_idx(idx);
					payInfo.setProduct_idx((String)productEx.get("product_idx"));
					payInfo.setProduct_selector((int)productEx.get("product_selector"));;
					payInfo.setPay_method(2);
					payInfo.setPay_total((int)productEx.get("product_price"));
					
					pointInout.setMem_idx(idx);
					pointInout.setPoint_usage("결제사용");
				} 
				// 이미 결제 되었으면
				else if( product_sell_status.equals("거래대기중") 
						&& (Integer)productEx.get("product_buyer_idx") == idx) {
					error = "이미 결제된 상태 입니다!!";
					
				}
				// 만약 다른 거래 상황이면 ...
				else if(product_sell_status.equals("대기중")){
					error = "예약 진행중이 아닙니다 예약 진행 먼저 해주세요";
				}
				// 이미 자신이 아닌 다른 사람이 예약, 거래 중 이라면
				else if(product_sell_status.equals("예약중")
						|| product_sell_status.equals("거래대기중")){
					error = "다른 유저가 예약중에 있습니다!";
				}
				else if(product_sell_status.equals("거래완료")){
					error = "이미 거래가 완료된 상품입니다";
				}
				else {
					error = "잘못된 접근입니다";
				}
				
				
			}	// =========== 중고거래일때 끝
		}
		if(!isPayReady) {
			jo.put("error", "isPayReady == false");
			return jo.toString();
		}
		
		// 결제 시작
		// 위에서 받아온 결제 객체들을 넣어 결제 시작
		int result = service.productPayment(payInfo, pointInout);
		if(result == 1) {
			
			// 결제 성공시 상품분류코드(중고, 경매등) 에 따른 동작
			
			if(product_selector == 0) {
				jProductService.updateSellStatus((String)map.get("product_idx"), "거래대기중");
				// 내부에서 원하는 시점에 stomp 메시지 보내기
				
				// ChatMessage 객체 생성하기
				Map<String,Object> msg = new HashMap<String, Object>();
				msg.put("member",member);
				msg.put("chat_room_idx",(String)map.get("chat_room_idx"));
				msg.put("chat_msg_content",member.getMem_nickname() + " 님이 결제를 진행하였습니다.");
				msg.put("product_sell_status","거래대기중");
				chatService.sandchatInJava(msg);
			}
			
			jo.put("result",true);
			return jo.toString();
		}

		jo.put("error", "productPayment error : " + result + " / " + error);
		return jo.toString();
		
	}
	
}
