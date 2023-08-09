package com.pj2.shoecream.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pj2.shoecream.mapper.ReportMapper;
import com.pj2.shoecream.vo.Criteria;
import com.pj2.shoecream.vo.ReportVO;

@Service
public class ReportService {

	@Autowired ReportMapper mapper;

	public List<ReportVO> getReportListPaging(Criteria cri, String searchType, String searchKeyword) {
		return mapper.getReportListPaging(cri, searchType, searchKeyword);
	}

	public int getTotal() {
		return mapper.getTotal();
	}

	public int deleteReport(ReportVO report) {
		return mapper.deleteReport(report);
	}

	public int updateIdx(ReportVO report) {
		return mapper.updateIdx(report);
	}


	public int deleteProduct(String product_idx) {
		
		return mapper.deleteProduct(product_idx);
	}

	public List<ReportVO> getAuctionReportListPaging(Criteria cri, String searchType, String searchKeyword) {
		return mapper.getAuctionReportListPaging(cri, searchType, searchKeyword);
	}

	public int deleteAuctionlist(ReportVO report) {
		
		return mapper.deleteAuctionlist(report);
	}

	public int deleteAuction(String product_idx) {
	
		return mapper.deleteAuction(product_idx);
	}

	public int registAuctionReport(Map<String, Object> map) {
		return mapper.insertAuctionReport(map);
	}
}


	
	
	

