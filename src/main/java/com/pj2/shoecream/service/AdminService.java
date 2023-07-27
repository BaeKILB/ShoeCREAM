package com.pj2.shoecream.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.pj2.shoecream.mapper.AdminMapper;
import com.pj2.shoecream.vo.MemberVO;

@Service
public class AdminService {
	
	@Autowired
	private AdminMapper mapper;
	
	// 회원 목록 조회
	public List<MemberVO> getMemberInfo(String searchType, String searchKeyword, int startRow, int listLimit) {
		return mapper.selectMemberInfo(searchType, searchKeyword, startRow, listLimit);
	}
	public int getMemberListCount(String searchType, String searchKeyword) {
		return mapper.selectMemberListCount(searchType, searchKeyword);
	}
	public MemberVO selectMember(int mem_idx) {
		return mapper.getMemberInfo(mem_idx);
	}
//	public MemberVO updateMemberRank(int mem_idx) {
//		return mapper.updateMemberRank(mem_idx);
//	}
	public boolean deleteMember(int mem_idx) {
		return mapper.deleteMember(mem_idx);
	}

}
