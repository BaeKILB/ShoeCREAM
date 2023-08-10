package com.pj2.shoecream.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.pj2.shoecream.config.PrincipalDetails;
import com.pj2.shoecream.handler.CustomValidationException;
import com.pj2.shoecream.service.MemberService;
import com.pj2.shoecream.service.SocialImageService;
import com.pj2.shoecream.vo.MemberProfileDto;
import com.pj2.shoecream.vo.SocialVO;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
public class SocialController {
	
	@Autowired
	private SocialImageService socialImageService;
	
	@Autowired
	private MemberService memberService;
//  =========================social============================
	// 소셜 팔로잉 디테일 페이지 (홈 버튼 클릭)
	@GetMapping("/social/story")
	public String story() {
		return "member/social/story";
	}
	
	// 소셜 인기 페이지
	@GetMapping("/social/popular")
	public String popular(Model model) {
		
		List<SocialVO> images = socialImageService.popularImage();
		model.addAttribute("images", images);
		System.out.println("인기 페이지로 뭐 뭐 들고 가니 ? " + images);
		
		return "member/social/popular";
	}
  
	// 소셜 개인 프로필 페이지
	@GetMapping("/social/{mem_idx}")
	public String profile(@PathVariable int mem_idx, Model model) {
//		User userEntity = userService.회원프로필(id);
//		model.addAttribute("user", userEntity);
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        PrincipalDetails mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();
		int sId = mPrincipalDetails.getMember().getMem_idx();
        
		MemberProfileDto dto = memberService.memberProfile(mem_idx, mPrincipalDetails.getMember().getMem_idx());
		model.addAttribute("dto", dto);
		System.out.println("dto 값 :" + dto);
		List<SocialVO> social = socialImageService.findSocialProfile(mem_idx);
		model.addAttribute("social", social);
		System.out.println("socaial 값 :" + social);
		System.out.println("프로필 페이지에서 social :" + social);
		
		return "member/social/profile";
	}
	// 소셜 디테일 폼
	@GetMapping("/social/{posts_idx}/detail")
	public String profileDetail(@PathVariable int posts_idx, Model model) {
	    model.addAttribute("posts_idx", posts_idx);
	    return "member/social/detail";
	}
	
	// 소셜 디테일 수정 폼
	@GetMapping("/social/{posts_idx}/update")
	public String ImageUpdate(@PathVariable int posts_idx, Model model) {
		model.addAttribute("posts_idx", posts_idx);
		
		List<Map<String, Object>> image  = socialImageService.getImageDetail(posts_idx);
		System.out.println("디테일 수정 잘가져왔니? :" + image);
		model.addAttribute("image", image);
		return "member/social/update";
	}
	
	// 소셜 디테일 이미지 삭제
	@PostMapping("/social/{posts_idx}/ImageFileDelete")
	public void ImageDelete(
			@RequestParam String posts_image1,
			@RequestParam String posts_idx,
			@RequestParam Map<String,Object> map,
			HttpServletResponse response,
			HttpSession session,
			Model model) {
		System.out.println("소셜 디테일 이미지 삭제 버튼 클릭 도;ㅣ니..?");
	    response.setCharacterEncoding("UTF-8");
	    // 결과를 저장할 변수를 선언합니다.
	    boolean isFileDeleted;
	    
	//  int deleteCount = socialImageService.removePostsImage(map);
	    int deleteCount = socialImageService.removePostsImage(map);

	    if(deleteCount > 0) {
	        String uploadDir = "/resources/upload/social";
	        String saveDir = session.getServletContext().getRealPath(uploadDir);
	        // 경로 생성
	        Path path = Paths.get(saveDir + "/" + posts_image1);
	        System.out.println("path 경로: " + path);

	        // 파일 삭제
	        try {
	            Files.deleteIfExists(path);
	            // 파일 삭제 성공
	            isFileDeleted = true;
	        } catch (IOException e) {
	            e.printStackTrace();
	            // 파일 삭제 실패
	            isFileDeleted = false;
	        }
	    } else {
	        // 파일 삭제 실패
	        isFileDeleted = false;
	    }

	    // 응답을 작성하고, 클라이언트에 전송합니다.
	    PrintWriter out;
	    try {
	        out = response.getWriter();
	        out.println(isFileDeleted);
	        out.flush();
	        out.close();
	    } catch (IOException e) {
	        e.printStackTrace();
	    }
	}
	
	
	// 소셜 디테일 수정
	@PostMapping("ImageUpdatePro")
	public String ImageUpdatePro(@ModelAttribute SocialVO socialVO, HttpSession session, Model model) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        PrincipalDetails mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();
        socialVO.setMem_idx(mPrincipalDetails.getMember().getMem_idx()); // 로그인한 mem_idx를 SocialVO에 설정
        
        socialImageService.ImageUpdate(socialVO, mPrincipalDetails, session, model);
		return "redirect:/social/"+mPrincipalDetails.getMember().getMem_idx();
	}
	
	// 소셜 디테일 삭제
	@GetMapping("social/{posts_idx}/ImageDeletePro")
	public String ImageDeletePro(@PathVariable int posts_idx, String posts_image1, HttpSession session, Model model) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        PrincipalDetails mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();
        // 해당 포스트 이미지 셀렉
        String postsImage = socialImageService.getPostImage(posts_idx);
        // 포스트 삭제
        int deleteCount = socialImageService.postDelete(posts_idx);
       
        if(deleteCount > 0) {
		    String uploadDir = "/resources/upload/social"; 
		    String saveDir = session.getServletContext().getRealPath(uploadDir);
		    
		    try {
		        Path path = Paths.get(saveDir + "/" + postsImage);
		        System.out.println("삭제할 파일 경로" + path);
		        Files.deleteIfExists(path);
		    } catch (IOException e) {
		        e.printStackTrace();
		    }
    	} else {
    		model.addAttribute("msg","포스트 삭제 실패");
    		return "member/fail_back";
    	}
		return "redirect:/social/"+mPrincipalDetails.getMember().getMem_idx();
    }
        
//	=======================social-image========================
	
	// 소셜 포스트 페이지
	@GetMapping("/image/upload")
	public String upload() {
		return "member/social/upload";
	}
	
	// 소셜 게시물 업로드
	@PostMapping("ImageUploadPro")
	public String imageUpload(SocialVO socialVO, @AuthenticationPrincipal PrincipalDetails principalDetails, HttpSession session, Model model) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        PrincipalDetails mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();
        mPrincipalDetails.getMember().getMem_idx();
        
        if(socialVO.getFile1().isEmpty()) {
//        	System.out.println("이미지가 첨부 안됐으");
        	throw new CustomValidationException("이미지가 첨부되지 않았습니다.", null);
        }
        
        socialImageService.ImageUpload(socialVO, mPrincipalDetails, session, model);
		return "redirect:/social/"+mPrincipalDetails.getMember().getMem_idx();
		
	}
//	===================social_ex====================
	@GetMapping("/social/mainex")
	public String socialMainEx() {
		return "member/socialex/instamain";
	}
	
	@GetMapping("/social/profileex")
	public String socialProfileEx() {
		return "member/socialex/instaprofile";
	}
	
	@GetMapping("/social/story2")
	public String socialStory() {
		return "member/socialex/story2";
	}
	
}
