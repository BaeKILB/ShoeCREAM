package com.pj2.shoecream.service;

import java.util.List;

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

	public int deleteProduct(int product_idx) {
		
		return mapper.deleteProduct(product_idx);
	}

	public int deletepro(int product_idx) {
		
		return mapper.deletepro(product_idx);
	}
	
}
