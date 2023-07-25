package com.pj2.shoecream.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.pj2.shoecream.service.MemberService;
import com.pj2.shoecream.vo.CMRespDto;
import com.pj2.shoecream.vo.MemberVO;

@RestController
public class MypageApiController {
	
	private static final Logger logger = LoggerFactory.getLogger(MypageApiController.class);

	@Autowired
	MemberService memberService;
	
    @PutMapping("/api/mypage/{mem_idx}")
    public CMRespDto<?> update(
    	    @PathVariable int mem_idx, MemberVO member) {
    	System.out.println("여기까지 오니?");
    	MemberVO memberEntity = memberService.updateMemberInfo(mem_idx, member);
    	System.out.println("api 업데이트 잘받니? " + memberEntity);

        return new CMRespDto<>(1,"회원수정완료",memberEntity);
    }
}
