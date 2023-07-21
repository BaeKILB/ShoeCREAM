package com.pj2.shoecream.controller;

import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;


@Controller
public class JunggoController {
	
	@GetMapping("JunggoSearch")
	public String junggoSearch(@RequestParam Map<String,Object> map, Model model) {
		return "/junggo/junggo_product_search";
	}
	@GetMapping("JungChat")
	public String jungChat(@RequestParam Map<String,Object> map, Model model) {
		return "";
	}
	@GetMapping("JunggoPay")
	public String junggoPay(@RequestParam Map<String,Object> map, Model model) {
		return "";
	}
	@GetMapping("JunggoResults")
	public String junggoResults(@RequestParam Map<String,Object> map, Model model) {
		return "";
	}
	
	
	
	
	//========================================================================================
	//==================================노용석================================================
	
	//------------------- 물건 등록 폼 이동---------------------
	@GetMapping("productRegister")
	public String productRegister(Model model) {
	    return "junggo/product_register";
	}
	
	//------------------ 물건 등록 프로 ---------------------------
	@PostMapping("registProductPro")
	public String registProductPro() {
		System.out.println();
		
		// StudentService - registStudent() 메서드를 호출하여 학생 정보 등록 요청
		// => 파라미터 : StudentVO 객체   리턴타입 : int(insertCount)
//		StudentService service = new StudentService(); // 객체 자동 주입으로 인해 객체 생성 불필요
		// => 단, @Service 어노테이션이 적용된 Service 클래스 정의 및 @Autowired 필수!
		// => 해당 인스턴스 생성 없이도 자동 주입되므로 service 멤버변수를 바로 사용 가능
		//int insertCount = service.registProduct();
		
		// 등록 실패(insertCount == 0) 시 Model 객체에 "등록 실패!" 저장(속성명 msg) 후 fail_back.jsp 로 포워딩
//		if(insertCount == 0) {
//			model.addAttribute("msg", "등록 실패!");
//			return "fail_back";
//		}
		
		// studentList 서블릿 주소로 리다이렉트
		return "redirect:/junggo/JunggoSearch";
	}

	
	
	
	//------------------ 물건 상세 안내 폼 이동---------------------
	@GetMapping("productDetail")
	public String productDetail(Model model) {
	    return "junggo/product_detail";
	}

	//------------------------- 예약취소 폼 이동---------------------
	@GetMapping("resCancel")
	public String resCancel() {
		return "junggo/res_cancel";
		
	}
	
	//------------------------- 예약완료 폼 이동---------------------
	@GetMapping("resComplete")
	public String resComplete() {
		return "junggo/res_complete";
		
	}
	
	//------------------------- 결제완료 폼 이동---------------------
	@GetMapping("payComplete")
	public String payComplete() {
		return "junggo/pay_complete";
			
	}
	
	//------------------------- 거래취소 폼 이동---------------------
	@GetMapping("tradeCancel")
	public String tradeCancel() {
		return "junggo/trade_cancel";
		
	}

	//------------------------- 거래완료 폼 이동---------------------
	@GetMapping("tradeComplete")
	public String resCancelCom() {
		return "junggo/trade_complete";
	}
	
	
	
}
