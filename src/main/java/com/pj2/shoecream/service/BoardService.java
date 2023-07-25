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

	// 공지사항 글 목록
	public List<NoticeVO> getNoticeListPaging(Criteria cri, String searchType, String searchKeyword) {
		return mapper.getNoticeListPaging(cri, searchType, searchKeyword);
	}
	
	// 공지사항 게시판 총 개수
	public int getTotal() {
		return mapper.getTotal();
	}
	
	// 공지사항 글 상세 보기
	public NoticeVO noticeDetail(NoticeVO notice) {
		return mapper.noticeDetail(notice);
	}
	
	// 공지사항 글 수정
	public int modifyBoard(NoticeVO notice) {
		return mapper.modifyBoard(notice);
	}
	
	// 공지사항 글 삭제
	public int deleteNotice(NoticeVO notice) {
		return mapper.deleteNotice(notice);
	}
	
	// 공지사항 글 삭제 시 글 번호 업데이트
	public int updateIdx(NoticeVO notice) {
		return mapper.updateIdx(notice);
	}
	
	// 공지사항 글 작성
	public int insertNotice(NoticeVO notice) {
		// 최대 글번호 선택
		int maxIdx = mapper.selectMaxIdx();
		notice.setBo_idx(maxIdx);
		return mapper.insertNotice(notice);
	}
	
	
	
	
}
