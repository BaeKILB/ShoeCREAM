package com.pj2.shoecream.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pj2.shoecream.mapper.MemberMapper;
import com.pj2.shoecream.vo.MemberVO;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class MemberService {
	
	@Autowired
	private MemberMapper mapper;
	
	private final BCryptPasswordEncoder bCryptPasswordEncoder;
	
	@Transactional
	public int registMember(@Valid MemberVO member) {
		String rawPassword = member.getMem_passwd();
		String encPassword = bCryptPasswordEncoder.encode(rawPassword);
		member.setMem_passwd(encPassword);
		member.setRole("ROLE_USER"); // 관리자 ROLE_ADMIN
	
		return mapper.insertMember(member);
	}
}
