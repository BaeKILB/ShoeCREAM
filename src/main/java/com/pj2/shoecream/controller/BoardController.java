package com.pj2.shoecream.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
public class BoardController {
	@Autowired BoardService boardservice;
	
	@GetMapping("UserNotice")
	public String usernotice(Model model, Criteria cri, @RequestParam(defaultValue = "") String searchType, @RequestParam(defaultValue = "") String searchKeyword) {
		
		List<NoticeVO> noticeListWithPaging = boardservice.getNoticeListPaging(cri, searchType, searchKeyword);
		model.addAttribute("noticeListP", noticeListWithPaging);

		int total = boardservice.getTotal();
		PageDTO pageMaker = new PageDTO(cri, total);
		model.addAttribute("pageMaker", pageMaker);
		
		return "member/notice/user_notice";
	}
	
	@GetMapping("noticedetail")
	public String noticedetail(NoticeVO notice, Model model, HttpServletRequest request, HttpServletResponse response,
			Criteria cri) {
		
		NoticeVO noticeResult = boardservice.noticeDetail(notice);
		model.addAttribute("noticeDetail", noticeResult);
		model.addAttribute("cri", cri);
		
		System.out.println("+++++++++++++++++++++++" +noticeResult);
		
		
		return "member/notice/user_notice_detail";
	}
	
	
}
