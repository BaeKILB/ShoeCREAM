package com.pj2.shoecream.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.pj2.shoecream.service.BoardService;
import com.pj2.shoecream.vo.Criteria;
import com.pj2.shoecream.vo.NoticeVO;
import com.pj2.shoecream.vo.PageDTO;



@Controller
public class AdminController {

	@Autowired
	private BoardService boardservice;
	
	//관리자메인
	@GetMapping("AdminMain")
	public String admin() {
		return "admin/admin_main";
	}

	
	@GetMapping("NoticeList")
	public String noticeList(Model model, Criteria cri, @RequestParam(defaultValue = "") String searchType, @RequestParam(defaultValue = "") String searchKeyword) {

		List<NoticeVO> noticeListWithPaging = boardservice.getNoticeListPaging(cri, searchType, searchKeyword);
		model.addAttribute("noticeListP", noticeListWithPaging);
		
		int total = boardservice.getTotal();
		PageDTO pageMaker = new PageDTO(cri, total);
		model.addAttribute("pageMaker", pageMaker);		
		
		return "admin/admin_board";
		
	}
	
	
	
	
	
	
}
