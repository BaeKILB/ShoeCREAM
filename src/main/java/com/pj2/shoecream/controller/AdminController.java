package com.pj2.shoecream.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pj2.shoecream.service.AdminService;
import com.pj2.shoecream.service.BoardService;
import com.pj2.shoecream.service.ReportService;
import com.pj2.shoecream.vo.Criteria;
import com.pj2.shoecream.vo.InquiryBoardVO;
import com.pj2.shoecream.vo.MemberVO;
import com.pj2.shoecream.vo.NoticeVO;
import com.pj2.shoecream.vo.PageDTO;
import com.pj2.shoecream.vo.PageInfoVO;
import com.pj2.shoecream.vo.ReportVO;



@Controller
public class AdminController {

	@Autowired
	private BoardService boardservice;
	@Autowired
	private AdminService service;
	@Autowired
	private ReportService reportservice;
	
	// 관리자메인
	@GetMapping("AdminMain")
	public String admin() {
		return "admin/admin_main";
	}
	
	// 관리자 회원 조회
	@GetMapping("AdminMember")
	public String adminMember() {
		return "admin/admin_member";
	}
	@ResponseBody
	@GetMapping("AdminMemberList")
	public Map<String, Object> adminListJson(@RequestParam(defaultValue = "") String searchType, @RequestParam(defaultValue = "") String searchKeyword, @RequestParam(defaultValue = "1") int pageNum, Model model) {
		Map<String, Object> result = new HashMap<String, Object>();
		int listLimit = 10;
		int startRow = (pageNum - 1) * listLimit;
		
		List<MemberVO> MemberList = service.getMemberInfo(searchType, searchKeyword, startRow, listLimit);
		int listCount = service.getMemberListCount(searchType, searchKeyword);
		
		// 총 페이지
		int maxPage = listCount / listLimit + (listCount % listLimit > 0 ? 1 : 0);
		
		// 시작 페이지
		int pageListLimit = 5;
		int startPage = (pageNum - 1) / pageListLimit * pageListLimit + 1;
		
		// 마지막 페이지
		int endPage = startPage + pageListLimit - 1;
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		
		PageInfoVO pageInfo = new PageInfoVO(listCount, pageListLimit, maxPage, startPage, endPage);
		result.put("memberList", MemberList);
		result.put("pageNum", pageNum);
		result.put("startPage", startPage);
		result.put("endPage", endPage);
		result.put("maxPage", maxPage);
		
		return result;
	}
		
	@GetMapping("MemberSelectInfo")
	@ResponseBody
	public MemberVO memberInfo(@RequestParam int mem_idx) {
		MemberVO member = service.selectMember(mem_idx);
		return member;
	}
	
	// 회원 삭제
	@GetMapping("MemberDelete")
	@ResponseBody
	public String memberDelete(@RequestParam int mem_idx) {
		String isDeleteMember;
		boolean isDelete = service.deleteMember(mem_idx);
		if(isDelete) {
			isDeleteMember = "true";
		} else {
			isDeleteMember = "false";
		}
		
		return isDeleteMember;
	}
	
	// 일대일 문의 목록 조회
	@GetMapping("InquiryList")
	public String inquiry(HttpSession session, @RequestParam(defaultValue = "1") int pageNum, @RequestParam(defaultValue = "") String searchType, Model model) {
		
		int listLimit = 10;
		int startRow = (pageNum - 1) * listLimit;
		
		List<InquiryBoardVO> qstList = service.getQstBoard(searchType, startRow, listLimit);
		System.out.println("★★★★★★★★★★★★★★★★★★★" + qstList);
		int listCount = service.getQstListCount(searchType);
		
		int pageListLimit = 5;
		
		int maxPage = listCount / listLimit + (listCount % listLimit > 0 ? 1 : 0);
		int startPage = (pageNum - 1) / pageListLimit * pageListLimit + 1;
		int endPage = startPage + pageListLimit - 1;
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		
		PageInfoVO pageInfo = new PageInfoVO(listCount, pageListLimit, maxPage, startPage, endPage);
		model.addAttribute("qstList", qstList);
		model.addAttribute("pageInfo", pageInfo);
		
		return "admin/admin_question";
	}
	
	// 공지사항 글 작성 폼
	@GetMapping("noticeWriteForm")
	public String noticeWriteForm(HttpSession session, Model model) {
//			String sId = (String)session.getAttribute("sId");
//			if(sId == null || !sId.equals("admin@admin.com")) {
//				model.addAttribute("msg", "잘못된 접근입니다");
//				return "inc/fail_back";
//			}

		return "admin/notice_write_form";
	}

	// 공지사항 글 작성
	@PostMapping("noticeWritePro")
	public String noticeWritePro(HttpSession session, NoticeVO notice, Model model) {
//			String sId = (String)session.getAttribute("sId");
//			if(sId == null || !sId.equals("admin@admin.com")) {
//				model.addAttribute("msg", "잘못된 접근입니다");
//				return "inc/fail_back";
//			}
		
		int insertCount = boardservice.insertNotice(notice);
		
		if(insertCount == 0) {
			model.addAttribute("msg", "등록 실패");
			return "inc/fail_back";
		}
		
		return "redirect:/NoticeList";
	}
		
	// 공지사항 목록 리스트
	@GetMapping("NoticeList")
	public String noticeList(Model model, Criteria cri, @RequestParam(defaultValue = "") String searchType, @RequestParam(defaultValue = "") String searchKeyword) {

		List<NoticeVO> noticeListWithPaging = boardservice.getNoticeListPaging(cri, searchType, searchKeyword);
		model.addAttribute("noticeListP", noticeListWithPaging);

		int total = boardservice.getTotal();
		PageDTO pageMaker = new PageDTO(cri, total);
		model.addAttribute("pageMaker", pageMaker);
		return "admin/admin_board";

	}

	// 공지사항 글 상세 보기
	@GetMapping("noticeDetail")
	public String noticeDetail(NoticeVO notice, Model model, HttpServletRequest request, HttpServletResponse response,
			Criteria cri) {

		NoticeVO noticeResult = boardservice.noticeDetail(notice);
		model.addAttribute("noticeDetail", noticeResult);
		model.addAttribute("cri", cri);
//			System.out.println("나오니?" + noticeResult);

		return "admin/notice_detail";

	}

	// 공지사항 글 수정 폼
	@GetMapping("noticeModify")
	public String noticeModify(HttpSession session, NoticeVO notice, Model model, Criteria cri) {
//			
//			String sId = (String) session.getAttribute("sId");
//			if(sId == null || !sId.equals("admin@admin.com")) {
//				model.addAttribute("msg", "잘못된 접근입니다");
//				return "html/member/notice/fail_back";
//			}
		NoticeVO noticeResult = boardservice.noticeDetail(notice);
		model.addAttribute("noticeDetail", noticeResult);
		model.addAttribute("cri", cri);

		return "admin/notice_modify";
	}

	// 공지사항 글 수정
	@PostMapping("noticeModifyPro")
	public String noticeModifyPro(HttpSession session, NoticeVO notice, Model model, Criteria cri) {
//			String sId = (String)session.getAttribute("sId");
//			if(sId == null || !sId.equals("admin@admin.com")) {
//				model.addAttribute("msg", "잘못된 접근입니다");
//				return "inc/fail_back";
//			}

		int ModifySuccess = boardservice.modifyBoard(notice);
		if (ModifySuccess < 0) {
			model.addAttribute("msg", "수정 실패");
			return "inc/fail_back";
		}

		return "redirect:/noticeDetail?pageNum=" + cri.getPageNum() + "&bo_idx=" + notice.getBo_idx();
	}

	// 공지사항 삭제
	@GetMapping("noticeDelete")
	public String noticeDelete(HttpSession session, NoticeVO notice, Model model) {
		
		int deleteNoticeCount = boardservice.deleteNotice(notice);

		if (deleteNoticeCount < 0) {
			model.addAttribute("msg", "삭제 실패");
			return "inc/fail_back";
		}

		int updateCount = boardservice.updateIdx(notice);
		if (updateCount < 0) {
			model.addAttribute("msg", "업데이트 실패");
			return "inc/fail_back";
		}
		return "redirect:/NoticeList";

	}

		
	// 신고 처리 목록
	@GetMapping("reportProcess")
	public String reportProcess(Model model, Criteria cri, @RequestParam(defaultValue = "") String searchType,
			@RequestParam(defaultValue = "") String searchKeyword) {

		List<ReportVO> reportProcessing = reportservice.getReportListPaging(cri, searchType, searchKeyword);
		model.addAttribute("report", reportProcessing);
//					System.out.println("가가가" + reportProcessing);

		int total = reportservice.getTotal();
		PageDTO pageMaker = new PageDTO(cri, total);
		model.addAttribute("pageMaker", pageMaker);

		return "admin/admin_report";
	}

	// 신고 처리하기(해당 상품 삭제)
	@GetMapping("reportDelete")
	public String reportDelete(HttpSession session, ReportVO report, Model model, @RequestParam int product_idx) {

		int deleteReportCount = reportservice.deleteReport(report);

		if (deleteReportCount < 0) {
			model.addAttribute("msg", "삭제 실패");
			return "inc/fail_back";
		}

		int updateCount = reportservice.updateIdx(report);
		if (updateCount < 0) {
			model.addAttribute("msg", "업데이트 실패");
			return "inc/fail_back";
		}

		int deleteReport = reportservice.deleteProduct(product_idx);
		int deleteProduct = reportservice.deletepro(product_idx);

		return "redirect:/reportProcess";

	}

}
	

