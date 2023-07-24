package com.pj2.shoecream.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.pj2.shoecream.service.AuctionService;

@Controller
public class AuctionController {
	@Autowired
	private AuctionService service;
	
	@GetMapping("Auction")
	public String auctionMain() {
		return "auction/auction_main";
	}
}
