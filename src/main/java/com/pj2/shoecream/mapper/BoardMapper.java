package com.pj2.shoecream.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.pj2.shoecream.vo.Criteria;
import com.pj2.shoecream.vo.NoticeVO;

@Mapper
public interface BoardMapper {

	List<NoticeVO> getNoticeListPaging(@Param("cri") Criteria cri, @Param("searchType") String searchType, @Param("searchKeyword") String searchKeyword);

	int getTotal();

}
