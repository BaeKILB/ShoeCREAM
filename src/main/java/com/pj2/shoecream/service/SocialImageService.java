package com.pj2.shoecream.service;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import com.pj2.shoecream.config.PrincipalDetails;
import com.pj2.shoecream.mapper.SocialImageMapper;
import com.pj2.shoecream.vo.SocialVO;

@Service
public class SocialImageService {
	
	@Autowired
	private SocialImageMapper socialImageMapper;
	
//	private String uploadDir = "C:/Users/kikir/Documents/itwill/workspace_spring5/ShoeCREAM/src/main/webapp/resources/upload";
	
//	public void ImageUpload(SocialVO socialVO, PrincipalDetails mPrincipalDetails, HttpSession session) {
		public void ImageUpload(SocialVO socialVO, PrincipalDetails mPrincipalDetails, HttpSession session, Model model) {
		
		// 1. 간단한 방법 
//		MultipartFile mFile1 = socialVO.getFile1();
//		
//		String uuid = UUID.randomUUID().toString();
//		
//		socialVO.setPosts_image1("");
//
//		String fileName1 = uuid.substring(0, 8) + "-" + socialVO.getFile1().getOriginalFilename();
//		
//		if(!mFile1.getOriginalFilename().equals("")) {
//		socialVO.setPosts_image1(uploadDir + "/" + fileName1);
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
		String uploadDir = "/resources/upload/socail"; 
		String saveDir = session.getServletContext().getRealPath(uploadDir);
		System.out.println("실제 업로드 경로 : "+ saveDir);
		// 실제 업로드 경로 : D:\Shared\Spring\workspace_spring5\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Spring_MVC_Board\resources\ upload
		
		String subDir = ""; // 서브디렉토리(날짜 구분)
		
		try {
			// 1. Date 객체 생성(기본 생성자 호출하여 시스템 날짜 정보 활용)
			Date date = new Date(); // Mon Jun 19 11:26:52 KST 2023
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
			// 3. 기존 업로드 경로에 날짜 경로 결합하여 저장
			subDir = sdf.format(date);
			saveDir += "/" + subDir;
			// --------------------------------------------------------------
			Path path = Paths.get(saveDir);
			
			// Files 클래스의 createDirectories() 메서드를 호출하여
			// Path 객체가 관리하는 경로 생성(존재하지 않으면 거쳐가는 경로들 중 없는 경로 모두 생성)
			Files.createDirectories(path);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		// JungGoNohVO 객체에 전달된 MultipartFile 객체 꺼내기
		MultipartFile mFile1 = socialVO.getFile1();
//		MultipartFile mFile2 = socialVO.getFile2();
//		MultipartFile mFile3 = socialVO.getFile3();
//		MultipartFile mFile4 = socialVO.getFile4();
//		System.out.println("원본파일명1 : " + mFile1.getOriginalFilename());
//		System.out.println("원본파일명2 : " + mFile2.getOriginalFilename());
//		System.out.println("원본파일명3 : " + mFile3.getOriginalFilename());
		
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
//		
//		if(!mFile2.getOriginalFilename().equals("")) {
//			socialVO.setPosts_image2(subDir + "/" + fileName2);
//		}
//		
//		if(!mFile3.getOriginalFilename().equals("")) {
//			socialVO.setPosts_image3(subDir + "/" + fileName3);
//		}
//		
//		if(!mFile4.getOriginalFilename().equals("")) {
//			socialVO.setPosts_image4(subDir + "/" + fileName4);
//		}
		System.out.println("실제 업로드 파일명1 : " + socialVO.getPosts_image1());
//		System.out.println("실제 업로드 파일명2 : " + socialVO.getPosts_image2());
//		System.out.println("실제 업로드 파일명3 : " + socialVO.getPosts_image3());
//		System.out.println("실제 업로드 파일명3 : " + socialVO.getPosts_image4());
		
		int insertCount = socialImageMapper.insertPosts(socialVO);
		
		if(insertCount > 0) { // 성공
			try {
				// 업로드 된 파일은 MultipartFile 객체에 의해 임시 디렉토리에 저장되어 있으며
				// 글쓰기 작업 성공 시 임시 디렉토리 -> 실제 디렉토리로 이동 작업 필요
				// MultipartFile 객체의 transferTo() 메서드를 호출하여 실제 위치로 이동(업로드)
				// => 비어있는 파일은 이동할 수 없으므로(= 예외 발생) 제외
				// => File 객체 생성 시 지정한 디렉토리에 지정한 이름으로 파일이 이동(생성)됨
				//    따라서, 이동할 위치의 파일명도 UUID 가 결합된 파일명을 지정해야한다!
				if(!mFile1.getOriginalFilename().equals("")) {
					mFile1.transferTo(new File(saveDir, fileName1));
				}
				
//				if(!mFile2.getOriginalFilename().equals("")) {
//					mFile2.transferTo(new File(saveDir, fileName2));
//				}
//				
//				if(!mFile3.getOriginalFilename().equals("")) {
//					mFile3.transferTo(new File(saveDir, fileName3));
//				}
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
			
			// 글쓰기 작업 성공 시 글목록(BoardList)으로 리다이렉트
//			return "redirect:/insertCount";
		} else { // 실패
			model.addAttribute("msg", "글 쓰기 실패!");
		}
		
	}
	
}

