package com.pj2.shoecream.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.pj2.shoecream.vo.Criteria;
import com.pj2.shoecream.vo.ReportVO;

@Mapper
public interface ReportMapper {

	List<ReportVO> getReportListPaging(@Param("cri") Criteria cri, @Param("searchType") String searchType, @Param("searchKeyword") String searchKeyword);

	int getTotal();

	int deleteReport(ReportVO report);

	int updateIdx(ReportVO report);

	int deleteProduct(int product_idx);

	int deletepro(int product_idx);

}