package com.pj2.shoecream.controller;

import java.util.Date;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.pj2.shoecream.service.AuctionService;

@Controller
public class AuctionController {
	@Autowired
	private AuctionService service;
	
	private static final Logger logger = LoggerFactory.getLogger(AuctionController.class);
	
	@GetMapping("Auction")
	public String auctionMain() {
		return "auction/auction_main";
	}
	
    @GetMapping("AuctionDetail")
    public String AuctionDetail(HttpSession session, Model model, @RequestParam int product_idx) { //경매 제품상세
    	//로그인 해야 이용 가능한걸로.. 버튼마다 session 체크 귀찮으니까..;
		String sId = (String)session.getAttribute("sId");
		
		if(sId == null) {
			model.addAttribute("msg","로그인 후 이용해주세요!");
			model.addAttribute("target","auction_loginForm");
			return "success";
		}
		
    	
    	//상품idx만 파라미터에 붙이면 되지 않을까?
    	//카테고리 붙인 이유가 뭐지? 카테고리만 눌렀을때 나오게 할려구여 아마도
    	//<a href="auction_detail?auction_idx=${product.auction_idx}&param=${product.auction_Scategory}">
    	
    	//가장 기본적인 가져와야할 정보 불러오자
    	//product 테이블의 정보 받아오기 
//    	Map<String, String> product = service.product(product_idx);
    	
    	
    	//auction 테이블 정보 가져오기
//    	Map<String, String> auction = service.auction(product_idx);
    	
    	//이미지 테이블 정보 가져오기
//    	List<String> images = service.image(product_idx);
    	
        return "auction/auction_detail";
    }

    @GetMapping("AuctionRecord")
    public String AuctionRecord() { //경매 기록
        return "auction/auction_record";
    }
    
    @PostMapping("AuctionRegister")
    public String auctionRegister(
    		@RequestParam Map<String, Object> map
    		, HttpSession session) {
    	
    	System.out.println(map.toString());
    	
    	session.setAttribute("sId", "1"); // 가상의 회원번호
    	String id = (String)session.getAttribute("sId"); // 회원번호 
    	id += new Date().getTime(); // 상품번호
    	System.out.println(id);
    	
    	int insertCount = 0;
    	insertCount = service.AuctionRegist(map);
    	
    	
    	return "redirect:/Auction";
    }
}