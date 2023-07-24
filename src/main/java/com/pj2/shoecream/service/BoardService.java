package com.pj2.shoecream.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pj2.shoecream.mapper.BoardMapper;
import com.pj2.shoecream.vo.Criteria;
import com.pj2.shoecream.vo.NoticeVO;

@Service
public class BoardService {

	@Autowired BoardMapper mapper;
	public List<NoticeVO> getNoticeListPaging(Criteria cri, String searchType, String searchKeyword) {
		return mapper.getNoticeListPaging(cri, searchType, searchKeyword);
	}
	public int getTotal() {
		return mapper.getTotal();
	}

	
	
}
