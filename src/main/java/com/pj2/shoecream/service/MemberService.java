package com.pj2.shoecream.service;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Date;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.pj2.shoecream.config.PrincipalDetails;
import com.pj2.shoecream.handler.CustomValidationException;
import com.pj2.shoecream.mapper.FollowMapper;
import com.pj2.shoecream.mapper.MemberMapper;
import com.pj2.shoecream.vo.MemberProfileDto;
import com.pj2.shoecream.vo.MemberVO;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class MemberService {
	
    @Autowired
    private MemberMapper memberMapper;
    
    @Autowired
    private FollowMapper followMapper;
    
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
        member.setMem_bio("반갑습니다."); // 멤버 상태 디폴트
        member.setMem_profileImageUrl("default_profile_image_url"); // 
//        System.out.println(member.getMem_mtel());
//        System.out.println(member.getMem_address());
//        System.out.println(member.getMem_birthday());
        System.out.println("member 값들(service) : "+ member);

        memberMapper.insertMember(member);
        
        return member;
    }
    // -----------------백엔드단 중복체크 -----------------------------
	// 아이디 중복 체크
    public boolean isMemberIdDuplicated(String mem_id) {
	    return memberMapper.isMemberIdDuplicated(mem_id) > 0;
	}
    // 폰 중복 체크
	public boolean isMemberPhoneDuplicated(String mem_mtel) {
		System.out.println("isMemberPhoneDuplicated 여기까지 오긴 오냐 ");
		return memberMapper.isMemberPhoneDuplicated(mem_mtel) > 0;
	}
	public boolean isMemberEmailDuplicated(String mem_email) {
		System.out.println("isMemberEmailDuplicated 여기까지 오긴 오냐 ");
		return memberMapper.isMemberEmailDuplicated(mem_email) > 0;
	}

	// 프론트단 아이디 중복체크
	public int memIdCheck(Map<String, String> map) {
		return memberMapper.selectIdCheck(map);
	}
	
	// 회원 정보 수정
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
	
	// 회원 정보 수정
	public int ModifyMember(MemberVO member, String newPasswd, @RequestParam String newPasswd1) {
		return memberMapper.updateMember(member,newPasswd, newPasswd1);
		
	}
	// 회원 수정 새로운 정보 담기
	public MemberVO loadMemberData(String mem_id) {
		return memberMapper.selectMember(mem_id);
	}
	
	//핸드폰 중복확인
	public int phoneCheck(String phone) {
		int cnt = memberMapper.phoneCheck(phone);
		System.out.println("cnt: " + cnt);
		return cnt;
	}
	
	//아이디 찾기 - find.jsp
	public String getId(MemberVO member) {
		System.out.println("아디찾기");
		return memberMapper.getId(member);
	}
	
	// 일치하는 회원 레코드 있는지 확인(비밀번호 찾기 과정 1) - find.jsp
	public String isExistUser(MemberVO member) {
		return memberMapper.isExistUser(member);
	}
	
	// 비밀번호 찾기 
	public String selectEmail(MemberVO member) {
		return memberMapper.selectSendEmail(member);
	}
	
	// 비밀번호 찾기
	public int changePw(MemberVO member) {
		return memberMapper.changePw(member);
	}
	
	// --------------- 마이페이지 ---------------
	// 프로필 관리
	public Map<String, Object> getProfileMember(int sId) {
		return memberMapper.selectProfileMember(sId);
	}
	
	// 프로필 사진 변경
	public void ProfileUpload(MemberVO member, PrincipalDetails mPrincipalDetails, HttpSession session) {
		member.setMem_idx(mPrincipalDetails.getMember().getMem_idx());
		member.setMem_nickname(member.getMem_nickname());
		member.setMem_bio(member.getMem_bio());
		member.setMem_profileImageUrl("");
		
		String uploadDir = "/resources/upload/profile";
		String saveDir = session.getServletContext().getRealPath(uploadDir);
		String subDir = ""; // 서브디렉토리(날짜 구분)
		
		try {
			Date date = new Date(); // Mon Jun 19 11:26:52 KST 2023
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
			subDir = sdf.format(date);
			saveDir += "/" + subDir;
			Path path = Paths.get(saveDir);
			Files.createDirectories(path);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		MultipartFile mFile = member.getFile();
		String uuid = UUID.randomUUID().toString();
		member.setMem_profileImageUrl("");
		String fileName = uuid.substring(0, 8) + "_" + mFile.getOriginalFilename();
		
		if(!mFile.getOriginalFilename().equals("")) {
			member.setMem_profileImageUrl(subDir + "/" + fileName);
		} 
		
		System.out.println("실제 업로드 파일명1 : " + member.getMem_profileImageUrl());	

		int updateCount = memberMapper.updateProfile(member);
		if(updateCount > 0) { // 성공
			try {
				if(!mFile.getOriginalFilename().equals("")) {
					mFile.transferTo(new File(saveDir, fileName));
				}
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		} else { // 실패
			throw new CustomValidationException("오류가 발생했습니다.", null);
		}
		
	}
	
	
// ------------------------소셜 프로필--------------------------------
//	// 프로필 사진 나오기 (로그인 한 사람이 아니라 각 회원 mem_idx 에 해당하는 프로필이 떠야함)
//	public void MemberProfile(int MemIdx) { // MemId = "/social/{mem_idx}" 여기의 {mem_idx} 요녀석 받아서 처리 할 거임
//		// SELECT * FROM social_posts WHRER MemId = :MemId; 이렇게 써보자
////		MemberVO memberEntity = memberMapper.findMemberByIdx(MemIdx);
//	}
	public MemberProfileDto memberProfile(int mem_idx, int sId) { // MemId = "/social/{mem_idx}" 여기의 {mem_idx} 요녀석 받아서 처리 할 거임
		MemberProfileDto dto = new MemberProfileDto();
		
		MemberVO memberEntity = memberMapper.findMemberByMemIdx(mem_idx);
		
		dto.setMember(memberEntity);
		dto.setPageOwnerState(mem_idx == sId);
		
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("sId", sId);
        paramMap.put("mem_idx", mem_idx);
		System.out.println("현재 프로필 페이지 sId 는 뭐냐 ? " + sId);
		System.out.println("현재 프로필 페이지 mem_idx 는 뭐냐 ? " + mem_idx);
        int followState = followMapper.mfollowState(paramMap);
        int followCount = followMapper.mfollowCount(mem_idx);
		
		dto.setFollowState(followState == 1);
		dto.setFollowCount(followCount);
		System.out.println("해당 프로필페이지 유저와 팔로우 했니? : " + followState);
		System.out.println("팔로우 수 : " +dto.getFollowCount());
		
		return dto;
	}
	
//	스토리에 들고갈 프로필을 위한 셀렉 아이디
	public MemberVO getMemberByIdx(int mem_idx) {
        return memberMapper.findMemberByIdx(mem_idx);
	}
	
	// 회원탈퇴 : (상태 ROLE_REST) 로 업데이트
	public int deleteMember(int sId) {
		return memberMapper.deleteMember(sId);
	}


	





	
	// ------------------ 0809 배경인 추가 ---------------------
	// 계좌 인증 여부 확인 체크
	public String getAccountAuth(int mem_idx) {
		return (memberMapper.findMemberByIdx(mem_idx)).getMem_account_auth();
	
	}
	
	
	// 계좌 인증 여부 업데이트
	public boolean changeMemAccountAuth(int mem_idx, String mem_account_auth) {
		return memberMapper.updateMemAccountAuth(mem_idx, mem_account_auth) > 0;
	}
	
	// 멤버 포인트 충전,출금 액수 업데이트
	public boolean updatePointAmount(int mem_idx, int pointAmount) {
		return memberMapper.updatePointAmount(mem_idx,pointAmount) > 0;
	}

	//아이디 중복체크 mapper 접근
//	public int idCheck(String id) {
//		int cnt = memberMapper.idCheck(id);
//		System.out.println("cnt: " + cnt);
//		return cnt;
//	}
}
