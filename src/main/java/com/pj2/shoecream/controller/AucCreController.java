package com.pj2.shoecream.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.pj2.shoecream.config.PrincipalDetails;
import com.pj2.shoecream.service.CommonService;
import com.pj2.shoecream.service.CreamService;
import com.pj2.shoecream.service.MemberService;
import com.pj2.shoecream.service.PayService;
import com.pj2.shoecream.vo.MemberVO;
import com.pj2.shoecream.vo.PayInfoVO;
import com.pj2.shoecream.vo.PointInoutVO;

@Controller
public class AucCreController {
	@Autowired
	private MemberService memService;
	
	@Autowired
	private PayService payService;
	
	@Autowired
	private CreamService creamService;
	
	@Autowired
	private CommonService commonService;
  
	
	
	   
   @GetMapping("payForm2") //크림용
	public String payForm22(@RequestParam Map<String,Object> map , Model model) {
	   
//	   {cream_idx=C1691664108524, mem_idx=2}
//		int idx = -1;
	   
	   	int mem_idx = 0;
	   	
	   	try {
				Authentication auth = SecurityContextHolder.getContext().getAuthentication();
				PrincipalDetails mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();
				mem_idx = mPrincipalDetails.getMember().getMem_idx();
			} catch (Exception e) {
				e.printStackTrace();
			}
		
		 // map에서 mem_idx 추출
	   	MemberVO buyer = memService.getMemberByIdx(mem_idx);
	   	System.out.println("!@#$"+buyer);
		// 구매자 정보 받기
		model.addAttribute("buyer" , buyer);
		System.out.println(map);
		model.addAttribute("map" , map);
		
		// 구매자 배송지 정보 받기
		Map<String, Object> deliveryInfo = commonService.getDeliveryInfo(mem_idx);
		model.addAttribute("deliveryInfo",deliveryInfo);
		
		
		//--------------여기는 크림 정보 받아오는 곳입니다 성혁씨---------------
		//--------------내가 테스트를 할수 있을까? ---------------
		// selectedSize -- cream.size+selectedSize
		String selectedSize = (String) map.get("selectedSize");
		String key = "size" + selectedSize;

		// 구매 제품 정보 불러오기
		// cream_idx
		String cream_idx = (String) map.get("cream_idx");
		Map<String, Object> cream = creamService.getCream(cream_idx);
		Integer price = (Integer) cream.get(key);

		model.addAttribute("cream", cream);
		model.addAttribute("price", price);
		//-----------여기까쥐---------------------------------------------
		return "common/pay_form";
	}
	   
	   
   @PostMapping("commonPayPro")
   	public String commonPayPro(@RequestParam Map<String,Object> map , Model model) {
	   
	   
	   
	   	int mem_idx = 0;
	   	
	   	try {Authentication auth = SecurityContextHolder.getContext().getAuthentication();
			 PrincipalDetails mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();
		     mem_idx = mPrincipalDetails.getMember().getMem_idx();
			} catch (Exception e) {
				e.printStackTrace();
			}
		
	   
	   //멤버정보 받아옴 ->구매자 정보에 뿌렸음
	  MemberVO buyer = memService.getMemberByIdx(mem_idx);
	   
	   //주소랑 결제한내역 받아와야함
	   
	   String product_idx = (String) map.get("cream_idx");
	   System.out.println(product_idx);
	   
	   int charge_point = buyer.getCharge_point();
	   
	   System.out.println("^&*^&*"+charge_point);
	   
	   int price = Integer.parseInt((String) map.get("price"));
	 
	   System.out.println("★★★★"+map);
	   
	   //포인트 있는경우 없는경우 따져봐야함 
	   int paymentResult = 0;
	   
	   //새로운 마음으로 새롭게 시작하는 결제~^^ payService
	   
	   //포인트 출금 result 1
	   //charge_point 뭐하는앤데?
	   PointInoutVO pointInout = new PointInoutVO();
	   pointInout.setMem_idx(mem_idx);
	   pointInout.setCharge_point(price);
	   pointInout.setPoint_usage("결제사용");
	   
	   paymentResult= payService.withdrawPoints(pointInout);
	   
	   
	   
	   System.out.println("%^&*"+paymentResult);
	   
	   
	   
	    if(paymentResult==1) {
	    	creamService.insertCreamDelivery(map);
	    }
	   //포인트 결제 result2
	   //여기 왜 안되는지 모르겠다?
	  
	   PayInfoVO payInfo= new PayInfoVO();
	   payInfo.setMem_idx(mem_idx);
	   payInfo.setProduct_idx(product_idx);
	   payInfo.setPay_method(2);
	   payInfo.setPay_total(price);
	   
	   int paymentResult2 = payService.productPayment(payInfo, pointInout);
	   
	   System.out.println("%^&*"+paymentResult2);
	   
	   
//	   PointInoutVO pointInout = new PointInoutVO();
//	   pointInout.setMem_idx(mem_idx);
//	   pointInout.setCharge_point(price);
//	   pointInout.setPoint_usage("결제사용");
//	   
//	   paymentResult = payService.withdrawPoints(pointInout); // 결제서비스.입출금메소드();
//		
//	   System.out.println("%^&*"+paymentResult);
//
//	   if(charge_point > price) {
//		   PointInoutVO inVO = new PointInoutVO();
//			inVO.setMem_idx(buyer.getMem_idx());
//			inVO.setCharge_point(price);
//			inVO.setPoint_usage("결제사용");
//			paymentResult = payService.withdrawPoints(inVO); // 결제서비스.입출금메소드();
//			System.out.println("%^&*"+paymentResult);
//			if(paymentResult == 1) {
//				//결제가 성공하면 
//				//일단 크림 배송 정보 테이블 업데이트
//				creamService.insertCreamDelivery(map);
//				
//				
//		        
//		        return "redirect:/store/" + buyer.getMem_idx();
//			}else {
//				System.out.println("결제 실패함 왜??왜??");
//				
//				
//				return "";
//			}
//		   
//	   }else {
////		   model.addAttribute("msg","포인트 충전하셈");
//		   
	   	return "redirect:/store/" + buyer.getMem_idx();
	   }

}