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
	public NoticeVO noticeDetail(NoticeVO notice) {
		return mapper.noticeDetail(notice);
	}
	public int modifyBoard(NoticeVO notice) {
		return mapper.modifyBoard(notice);
	}
	public int deleteNotice(NoticeVO notice) {
		return mapper.deleteNotice(notice);
	}
	public int updateIdx(NoticeVO notice) {
		return mapper.updateIdx(notice);
	}
	
	public int insertNotice(NoticeVO notice) {
		// 최대 글번호 선택
		int maxIdx = mapper.selectMaxIdx();
		notice.setBo_idx(maxIdx);
		return mapper.insertNotice(notice);
	}
	
	
	
	
}
