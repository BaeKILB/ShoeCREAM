package com.pj2.shoecream.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.pj2.shoecream.config.PrincipalDetails;
import com.pj2.shoecream.handler.CustomValidationApiException;
import com.pj2.shoecream.service.MemberService;
import com.pj2.shoecream.service.SocialCommentService;
import com.pj2.shoecream.service.SocialImageService;
import com.pj2.shoecream.service.SocialLikeService;
import com.pj2.shoecream.vo.CMRespDto;
import com.pj2.shoecream.vo.MemberVO;
import com.pj2.shoecream.vo.SocialCommentVO;
import com.pj2.shoecream.vo.SocialVO;

@RestController
public class ImageApiController {

	@Autowired
	private SocialImageService socialImageService;
	@Autowired
	private SocialLikeService socialLikeService;
	@Autowired
	private SocialCommentService socialCommentService;
	@Autowired
	private MemberService memberService;
	
//	소셜 스토리 (팔로우한 mem_idx 만 게시글 보이기)
	@GetMapping("/api/image")
	public ResponseEntity<?> imageStory(@RequestParam(defaultValue = "1") int pageNum, SocialCommentVO socialCommentVO) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		PrincipalDetails mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();
		int sId = mPrincipalDetails.getMember().getMem_idx();

		// 페이징 처리를 위해 조회 목록 갯수 조절 시 사용될 변수 선언
		int listLimit = 3; // 한 페이지에서 표시할 목록 갯수 지정
		int startRow = (pageNum - 1) * listLimit; // 조회 시작 행(레코드) 번호

		List<SocialVO> images = socialImageService.ImageStory(sId, startRow, listLimit);
		
	   // 좋아요 상태를 images에 추가합니다.
		for (SocialVO image : images) {
		    image.setLikeState(socialLikeService.isPostLikedByUser(sId, image.getPosts_idx()));

		    List<SocialCommentVO> comments = socialImageService.getImageComments(image.getPosts_idx());

		    // 댓글 작성자의 mem_profileImageUrl을 추가합니다.
		    for (SocialCommentVO comment : comments) {
		        MemberVO member = memberService.getMemberByIdx(comment.getMem_idx());
		        comment.setMem_profileImageUrl(member.getMem_profileImageUrl());
		    }

		    // 댓글 목록을 이미지에 추가합니다.
		    image.setComment_contents(comments);

		    MemberVO postMember = memberService.getMemberByIdx(image.getMem_idx());
		    image.setMem_profileImageUrl(postMember.getMem_profileImageUrl());
		}
		
		System.out.println("images : " + images);
		
		return new ResponseEntity<>(new CMRespDto<>(1, "성공", images), HttpStatus.OK);
	}
	
	// 좋아요
	@PostMapping("/api/image/{posts_idx}/likes")
	public ResponseEntity<?> likes(@PathVariable int posts_idx) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		PrincipalDetails mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();
		int sId = mPrincipalDetails.getMember().getMem_idx();
		
		socialLikeService.insertLike(posts_idx, sId);
		return new ResponseEntity<>(new CMRespDto<>(1,"좋아요성공",null),HttpStatus.CREATED);
	}
	
	// 좋아요 취소
	@DeleteMapping("/api/image/{mem_idx}/likes")
	public ResponseEntity<?> unLikes(@PathVariable int mem_idx) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		PrincipalDetails mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();
		int sId = mPrincipalDetails.getMember().getMem_idx();
		
		socialLikeService.deleteLike(mem_idx, sId);
		return new ResponseEntity<>(new CMRespDto<>(1,"좋아요취소성공",null),HttpStatus.OK);
	}
	// 소셜 디테일
	@GetMapping("/api/image/{posts_idx}/detail")
	public ResponseEntity<?> imageDetailStory(@RequestParam(defaultValue = "1") int pageNum, SocialCommentVO socialCommentVO,@PathVariable int posts_idx) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		PrincipalDetails mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();
		int sId = mPrincipalDetails.getMember().getMem_idx();
		SocialVO socialVO = new SocialVO();
		socialVO.setPosts_idx(posts_idx);
		System.out.println("posts_idx 뭐야?" + socialVO.getPosts_idx());
		// 페이징 처리를 위해 조회 목록 갯수 조절 시 사용될 변수 선언
		int listLimit = 3; // 한 페이지에서 표시할 목록 갯수 지정
		int startRow = (pageNum - 1) * listLimit; // 조회 시작 행(레코드) 번호

//		List<SocialVO> images = socialImageService.ImageStory(sId, startRow, listLimit);
		List<SocialVO> images = socialImageService.ImageDetail(posts_idx, startRow, listLimit);
		System.out.println("디테일 images 뭐 들고오냐" + images);
	   // 좋아요 상태를 images에 추가합니다.
		for (SocialVO image : images) {
		    image.setLikeState(socialLikeService.isPostLikedByUser(sId, image.getPosts_idx()));

		    List<SocialCommentVO> comments = socialImageService.getImageComments(image.getPosts_idx());

		    // 댓글 작성자의 mem_profileImageUrl을 추가합니다.
		    for (SocialCommentVO comment : comments) {
		        MemberVO member = memberService.getMemberByIdx(comment.getMem_idx());
		        comment.setMem_profileImageUrl(member.getMem_profileImageUrl());
		    }

		    // 댓글 목록을 이미지에 추가합니다.
		    image.setComment_contents(comments);

		    MemberVO postMember = memberService.getMemberByIdx(image.getMem_idx());
		    image.setMem_profileImageUrl(postMember.getMem_profileImageUrl());
		}
		
		System.out.println("images : " + images);
		
		return new ResponseEntity<>(new CMRespDto<>(1, "성공", images), HttpStatus.OK);
	}
	
	
	
	
	
	// --------------- api/comment 댓글  ----------------
//	, @RequestParam("comment_content") String comment_content, @RequestParam("posts_idx") int posts_idx
//	@ResponseBody
	@PostMapping("/api/comment")
	public ResponseEntity<?> commentInsert(@Valid @RequestBody SocialCommentVO socialCommentVO, BindingResult bindingResult) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		PrincipalDetails mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();
		int sId = mPrincipalDetails.getMember().getMem_idx();
		String mem_nickname = mPrincipalDetails.getMember().getMem_nickname();
		
		if (bindingResult.hasErrors()) {
			System.out.println("여기까지오긴 오니 ..?");
		     Map<String, String> errorMap = new HashMap<>();
		     for (FieldError error : bindingResult.getFieldErrors()) {
		         errorMap.put(error.getField(), error.getDefaultMessage());
		         System.out.println("================");
		         System.out.println(error.getDefaultMessage());
		         System.out.println("================");
		     }
		     throw new CustomValidationApiException("유효성 검사 실패", errorMap);
		}
		socialCommentVO.setMem_idx(sId);
		socialCommentVO.setMem_nickname(mem_nickname);
		SocialCommentVO comment = socialImageService.writeComment(socialCommentVO);
		return new ResponseEntity<>(new CMRespDto<>(1,"댓글쓰기성공",comment),HttpStatus.CREATED);
	}
	
	@DeleteMapping("/api/comment/{comment_idx}")
	public ResponseEntity<?> commentInsert(@PathVariable int comment_idx) {
		socialImageService.deleteComment(comment_idx);
		System.out.println("삭제 comment_idx 뭐냐? " + comment_idx);
		return new ResponseEntity<>(new CMRespDto<>(1, "댓글 삭제 성공",null), HttpStatus.OK);
	}
	
}
