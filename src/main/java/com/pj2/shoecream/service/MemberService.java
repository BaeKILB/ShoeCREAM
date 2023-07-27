package com.pj2.shoecream.service;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestParam;

import com.pj2.shoecream.mapper.MemberMapper;
import com.pj2.shoecream.vo.MemberVO;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class MemberService {
	
    @Autowired
    private MemberMapper memberMapper;
    
    private final BCryptPasswordEncoder bCryptPasswordEncoder;
    
    private final Logger logger = LoggerFactory.getLogger(getClass());

    @Transactional
    public MemberVO registMember(MemberVO member) {
        // 회원가입 진행
        String rawPassword = member.getMem_passwd();
        String encPassword = bCryptPasswordEncoder.encode(rawPassword);
        member.setMem_passwd(encPassword); // 암호화 비번
        member.setRole("ROLE_USER"); // 멤버 권한 디폴트
        member.setMem_account_auth("N"); // 계좌 디폴트
        member.setMem_status("1"); // 멤버 상태 디폴트
        System.out.println(member.getMem_mtel());
        System.out.println(member.getMem_address());
        System.out.println(member.getMem_birthday());
        System.out.println("member 값들(service) : "+ member);

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
	
	@Transactional
	public MemberVO updateMemberInfo(int mem_idx, MemberVO member) {
		
		MemberVO memberEntity = memberMapper.updateMember(mem_idx, member);
		
        String rawPassword = member.getMem_passwd();
        String encPassword = bCryptPasswordEncoder.encode(rawPassword);
        
        memberEntity.setMem_passwd(encPassword);
        memberEntity.setMem_nickname(member.getMem_nickname());
        memberEntity.setMem_birthday(member.getMem_birthday());
        memberEntity.setMem_address(member.getMem_address());
        
		return memberEntity;
		
	}

	public int ModifyMember(MemberVO member, String newPasswd, @RequestParam String newPasswd1) {
		return memberMapper.updateMember(member,newPasswd, newPasswd1);
		
	}
	// 회원 수정 새로운 정보 담기
	public MemberVO loadMemberData(String mem_id) {
		// TODO Auto-generated method stub
		return memberMapper.selectMember(mem_id);
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
