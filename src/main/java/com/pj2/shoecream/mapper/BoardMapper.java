package com.pj2.shoecream.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.pj2.shoecream.vo.Criteria;
import com.pj2.shoecream.vo.NoticeVO;

@Mapper
public interface BoardMapper {

	// 공지사항 목록
	List<NoticeVO> getNoticeListPaging(@Param("cri") Criteria cri, @Param("searchType") String searchType, @Param("searchKeyword") String searchKeyword);

	// 게시판 총 갯수
	int getTotal();

	// 글 상세 보기
	NoticeVO noticeDetail(NoticeVO notice);

	// 글 수정
	int modifyBoard(NoticeVO notice);

	// 글 삭제
	int deleteNotice(NoticeVO notice);

	// 글 삭제 시 글 번호 업데이트
	int updateIdx(NoticeVO notice);

	// 최대 글 번호 선택
	int selectMaxIdx();

	// 글 작성
	int insertNotice(NoticeVO notice);

}
