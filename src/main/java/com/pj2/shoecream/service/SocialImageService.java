package com.pj2.shoecream.service;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import com.pj2.shoecream.config.PrincipalDetails;
import com.pj2.shoecream.handler.CustomValidationException;
import com.pj2.shoecream.mapper.SocialImageMapper;
import com.pj2.shoecream.vo.SocialVO;

@Service
public class SocialImageService {
	
	@Autowired
	private SocialImageMapper socialImageMapper;
	
//	소셜 스토리 (팔로우한 mem_idx 만 게시글 보이기)
	@Transactional(readOnly = true)
	public List<SocialVO> ImageStory(int sId){
		return socialImageMapper.selectStory(sId);
	}
	
//	private String uploadDir = "C:/Users/kikir/Documents/itwill/workspace_spring5/ShoeCREAM/src/main/webapp/resources/upload/";
	
	// 포스트 등록
//	public void ImageUpload(SocialVO socialVO, PrincipalDetails mPrincipalDetails, HttpSession session) {
		@Transactional
		public void ImageUpload(SocialVO socialVO, PrincipalDetails mPrincipalDetails, HttpSession session, Model model) {
		
//		 1. 간단한 방법 
//		MultipartFile mFile1 = socialVO.getFile1();
//		
//		String uuid = UUID.randomUUID().toString();
//		
//		socialVO.setPosts_image1("");
//
//		String fileName1 = uuid.substring(0, 8) + "-" + socialVO.getFile1().getOriginalFilename();
//		
//		if(!mFile1.getOriginalFilename().equals("")) {
//		socialVO.setPosts_image1(uploadDir + fileName1);
//		}
//		
//		System.out.println("이미지 파일이름 : " + fileName1);
//		
//		Path imageFilePath = Paths.get(uploadDir + fileName1);
//		
//		try {
//			Files.write(imageFilePath, socialVO.getFile1().getBytes()); //
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		socialImageMapper.insertPosts(socialVO);
		
		// ----------------------------------------------------------------------
		
		// 2. 원래 배운 방법
		String uploadDir = "/resources/upload/social"; 
		String saveDir = session.getServletContext().getRealPath(uploadDir);
		System.out.println("실제 업로드 경로 : "+ saveDir);
		// 실제 업로드 경로 : C:\Users\kikir\Documents\itwill\workspace_spring5\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\ShoeCREAM\resources\ upload\social
		
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
		
		MultipartFile mFile1 = socialVO.getFile1();
//		MultipartFile mFile2 = socialVO.getFile2();
//		MultipartFile mFile3 = socialVO.getFile3();
//		MultipartFile mFile4 = socialVO.getFile4();
		
		String uuid = UUID.randomUUID().toString();
		
		socialVO.setPosts_image1("");
//		socialVO.setPosts_image2("");
//		socialVO.setPosts_image3("");
//		socialVO.setPosts_image4("");
		
		// 파일명을 저장할 변수 선언
		String fileName1 = uuid.substring(0, 8) + "_" + mFile1.getOriginalFilename();
//		String fileName2 = uuid.substring(0, 8) + "_" + mFile2.getOriginalFilename();
//		String fileName3 = uuid.substring(0, 8) + "_" + mFile3.getOriginalFilename();
//		String fileName4 = uuid.substring(0, 8) + "_" + mFile4.getOriginalFilename();
		
		if(!mFile1.getOriginalFilename().equals("")) {
			socialVO.setPosts_image1(subDir + "/" + fileName1);
		}
//		if(!mFile2.getOriginalFilename().equals("")) {
//			socialVO.setPosts_image2(subDir + "/" + fileName2);
//		}
//		if(!mFile3.getOriginalFilename().equals("")) {
//			socialVO.setPosts_image3(subDir + "/" + fileName3);
//		}
//		if(!mFile4.getOriginalFilename().equals("")) {
//			socialVO.setPosts_image4(subDir + "/" + fileName4);
//		}
		
		socialVO.setMem_idx(mPrincipalDetails.getMember().getMem_idx()); // 로그인한 mem_idx 저장
		socialVO.setMem_nickname(mPrincipalDetails.getMember().getMem_nickname()); // 로그인한 mem_nickname 저장
		int insertCount = socialImageMapper.insertPosts(socialVO);
		
		if(insertCount > 0) { // 성공
			try {
				if(!mFile1.getOriginalFilename().equals("")) {
					mFile1.transferTo(new File(saveDir, fileName1));
				}
//				if(!mFile2.getOriginalFilename().equals("")) {
//					mFile2.transferTo(new File(saveDir, fileName2));
//				}
//				if(!mFile3.getOriginalFilename().equals("")) {
//					mFile3.transferTo(new File(saveDir, fileName3));
//				}
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		} else { // 실패
			throw new CustomValidationException("오류가 발생했습니다.", null);
		}
		
		System.out.println("socialVO 에 뭐가 들었니 ? " + socialVO);
	}


		
		// 
		public List<String> findPostImagesByMemIdx(int mem_idx) {
		    return socialImageMapper.findPostImageByMemIdx(mem_idx);
		}
	
}

