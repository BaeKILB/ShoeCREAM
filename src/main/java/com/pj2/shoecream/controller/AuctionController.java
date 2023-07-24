package com.pj2.shoecream.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import com.pj2.shoecream.service.AuctionService;

@Controller
public class AuctionController {
	@Autowired
	private AuctionService service;
	
	@GetMapping("Auction")
	public String auctionMain() {
		return "auction/auction_main";
	}
	
    @PostMapping("AuctionDetail")
    public String AuctionDetail() { //경매 제품상세
        return "auction/auction_detail";
    }

    @GetMapping("AuctionRecord")
    public String AuctionRecord() { //경매 기록
        return "auction/auction_record";
    }
}