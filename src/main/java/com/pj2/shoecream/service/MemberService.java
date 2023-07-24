package com.pj2.shoecream.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pj2.shoecream.mapper.MemberMapper;
import com.pj2.shoecream.vo.MemberVO;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class MemberService {
	
    @Autowired
    private MemberMapper memberMapper;
    private final BCryptPasswordEncoder bCryptPasswordEncoder;
    
 
    @Transactional
    public MemberVO registMember(MemberVO member) {
        // 회원가입 진행
        String rawPassword = member.getMem_passwd();
        String encPassword = bCryptPasswordEncoder.encode(rawPassword);
        member.setMem_passwd(encPassword);
        member.setRole("ROLE_USER");
        memberMapper.insertMember(member);
        return member;
    }

	public boolean isMemberIdDuplicated(String mem_id) {
	    return memberMapper.isMemberIdDuplicated(mem_id) > 0;

	}

	//아이디 중복체크 mapper 접근
//	public int idCheck(String id) {
//		int cnt = memberMapper.idCheck(id);
//		System.out.println("cnt: " + cnt);
//		return cnt;
//	}
	
	// 프론트단 아이디 중복체크
	public int memIdCheck(Map<String, String> map) {
		return memberMapper.selectIdCheck(map);
	}

    
    
    
//    public boolean isIdUnique(String mem_id) {
//        return memberMapper.selectMemberById(mem_id) == null;
//    }
//
//    public boolean isNameUnique(String mem_name) {
//        return memberMapper.selectMemberByName(mem_name) == null;
//    }
//
//    public boolean isEmailUnique(String mem_email) {
//        return memberMapper.selectMemberByEmail(mem_email) == null;
//    }
//
//    public boolean isMtelUnique(String mem_mtel) {
//        return memberMapper.selectMemberByMtel(mem_mtel) == null;
//    }
}
