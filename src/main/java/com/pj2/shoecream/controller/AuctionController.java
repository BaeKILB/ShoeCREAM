package com.pj2.shoecream.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class AuctionController {//경매 컨트롤러 입니다.
	
	@PostMapping("AuctionDetail")
	public String AuctionDetail() { //경매 제품상세
		return "";
	}
	
	@GetMapping	("AuctionRecord")
	public String AuctionRecord() { //경매 기록
		return "";
	}

}
