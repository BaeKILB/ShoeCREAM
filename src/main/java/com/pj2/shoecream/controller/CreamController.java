package com.pj2.shoecream.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.pj2.shoecream.config.PrincipalDetails;
import com.pj2.shoecream.service.AuctionService;
import com.pj2.shoecream.service.CreamService;
import com.pj2.shoecream.service.ImageService;
import com.pj2.shoecream.service.JungGoNohService;
import com.pj2.shoecream.service.PayService;
import com.pj2.shoecream.vo.CreamVO;
import com.pj2.shoecream.vo.Criteria;
import com.pj2.shoecream.vo.JungGoNohVO;
import com.pj2.shoecream.vo.ProductImageVO;

@Controller
public class CreamController {//크림 컨트롤러 입니다.
	
	  @Autowired
	   private ImageService isService;
	  
	  @Autowired
	  private CreamService service;
	  
	  @Autowired
	  private AuctionService aucService;
	  
	  @Autowired
	  private PayService payService;
	  
	  @Autowired
	  private JungGoNohService jungGoNohService;
	
	@GetMapping("Cream")
	public String creamMain(
			   @RequestParam(required = false) Map<String, Object> map
			   , Model model) {
		if (map != null) model.addAttribute("code", map);
		
		return "cream/cream_main";
	}
	
	
	
    @ResponseBody
    @RequestMapping(value= "getCreamList", method = RequestMethod.GET, produces = "application/text; charset=UTF-8")
    public String getCreamList(
          @RequestParam Map<String, Object> map) {
       
		int pageNum = Integer.parseInt(String.valueOf(map.get("pageNum")));
		int listLimit = 12;
		if (map.containsKey("main")) {
			listLimit = 4;
		}
		int startRow = (pageNum - 1) * listLimit;
       
		map.put("startRow", startRow);
		map.put("listLimit", listLimit);
      
		List<Map<String, Object>> creamList = service.getCreamList(map);

		map.remove("startRow");
		map.remove("listLimit");

		int listCount = service.getCreamList(map).size();
		int pageListLimit = 20;
		int maxPage = listCount / listLimit + (listCount % listLimit > 0 ? 1 : 0);
		int startPage = (pageNum - 1) / pageListLimit * pageListLimit + 1;
		int endPage = startPage + pageListLimit - 1;
		if (endPage > maxPage) {
			endPage = maxPage;
		}

		Map<String, Object> pageInfo = new HashMap<String, Object>();
		pageInfo.put("listCount", listCount);
		pageInfo.put("pageListLimit", pageListLimit);
		pageInfo.put("maxPage", maxPage);
		pageInfo.put("startPage", startPage);
		pageInfo.put("endPage", endPage);
		pageInfo.put("pageNum", pageNum);

		creamList.add(pageInfo);

		JSONArray jsonArray = new JSONArray(creamList);
		return jsonArray.toString();
	}
	
	
   @PostMapping("CreamRegister")
    public String creamRegister(CreamVO cream , ProductImageVO image, HttpSession session) {


		String productId = "C" + String.valueOf(new Date().getTime()); // 상품번호
		cream.setCream_idx(productId); // 상품번호 추가
		image.setProduct_idx(productId);

		String uploadDir = "/resources/upload/cream";
		String saveDir = session.getServletContext().getRealPath(uploadDir);
		String subDir = "";
		try {
           Date date = new Date();
           SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
           subDir = sdf.format(date);
           saveDir += "/" + subDir;
           Path path = Paths.get(saveDir);
           Files.createDirectories(path);
        } catch (IOException e) {
            e.printStackTrace();
        }

        image.setProduct_idx(productId);
        image.setImage_path(uploadDir+"/"+subDir);
        
        MultipartFile mFile1 = image.getImage1();
        MultipartFile mFile2 = image.getImage2();
        MultipartFile mFile3 = image.getImage3();
        MultipartFile mFile4 = image.getImage4();
        
        String uuid = UUID.randomUUID().toString();
        
        image.setImage1_name("");
        image.setImage2_name("");
        image.setImage3_name("");
        image.setImage4_name("");
        
        String imageName1 = uuid.substring(0, 8) + "_" + mFile1.getOriginalFilename();
		String imageName2 = uuid.substring(0, 8) + "_" + mFile2.getOriginalFilename();
		String imageName3 = uuid.substring(0, 8) + "_" + mFile3.getOriginalFilename();
		String imageName4 = uuid.substring(0, 8) + "_" + mFile4.getOriginalFilename();
	      
		if(!mFile1.getOriginalFilename().equals("")) image.setImage1_name(imageName1);
		if(!mFile2.getOriginalFilename().equals("")) image.setImage2_name(imageName2);
		if(!mFile3.getOriginalFilename().equals("")) image.setImage3_name(imageName3);
		if(!mFile4.getOriginalFilename().equals("")) image.setImage4_name(imageName4);
	        
	      
		int insertCount = isService.registProductImage(image);
	       
		if (insertCount > 0) {
		    try {
			if (!mFile1.getOriginalFilename().equals("")) mFile1.transferTo(new File(saveDir, imageName1));
			if (!mFile2.getOriginalFilename().equals("")) mFile2.transferTo(new File(saveDir, imageName2));
			if (!mFile3.getOriginalFilename().equals("")) mFile3.transferTo(new File(saveDir, imageName3));
			if (!mFile4.getOriginalFilename().equals("")) mFile4.transferTo(new File(saveDir, imageName4));
		    } catch (IllegalStateException e) {
			e.printStackTrace();
		    } catch (IOException e) {
			e.printStackTrace();
		    }
		    service.registCreamItem(cream);
		}
		return "admin/admin_cream";
    }	
   
   @GetMapping("CreamDetail")
   public String CreamDetail(
       HttpSession session
       , Model model
       , @RequestParam Map<String, Object> map) { //경매 제품상세
   	
		// 회원번호
   	int sId = 0;
   	
   	try {
			Authentication auth = SecurityContextHolder.getContext().getAuthentication();
			PrincipalDetails mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();
			sId = mPrincipalDetails.getMember().getMem_idx();
		} catch (Exception e) {
			e.printStackTrace();
		}
   	map.put("mem_idx", sId);
   	
   	String cream_idx = (String)map.get("cream_idx");
   	
   		// 조회수 카운트
		String readAuction = (String) session.getAttribute("readAuction");
		if (readAuction == null || !readAuction.equals(cream_idx)) {
			int updateCount = service.updateReadCount(cream_idx);
			if (updateCount > 0)
				session.setAttribute("readCream", cream_idx);
		}
		//상품정보
		Map<String, Object> cream = service.getCream(cream_idx);
		cream.put("isLogin", sId);
		model.addAttribute("cream", cream);


		 //찜
		Map<String, Object> dibs = service.getCreamDibs(map);
		model.addAttribute("dibs", dibs);

		//찜카운트
		int dibsCount = service.getDibsCount(map);
		model.addAttribute("dibsCount", dibsCount);
		
		//연관상품
//		List<Map<String, Object>> relatedProducts = service.getRelatedCreamList(cream);
//		model.addAttribute("relatedProducts",relatedProducts);
//		
		//크림 판매물품
		
       return "cream/cream_detail";
   }
   
   
   @ResponseBody
   @RequestMapping(value= "dibsEvent2", method = RequestMethod.POST, produces = "application/text; charset=UTF-8")
   public String dibsEvent2(
   		@RequestParam Map<String,Object> map
   		, Model model) {
       Authentication auth = SecurityContextHolder.getContext().getAuthentication();
       PrincipalDetails mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();
       int sId = mPrincipalDetails.getMember().getMem_idx();
       
   	map.put("mem_idx", sId);
   	
   	Map<String, Object> dibs = service.getCreamDibs(map);
   	
   	if (dibs == null) {
   		service.registDibs(map);
   		dibs = service.getCreamDibs(map);
   		dibs.put("result", true);
   	} else {
   		service.deleteDibs(map);
   		dibs = service.getCreamDibs(map);
   		dibs = new HashMap<String, Object>();
   		dibs.put("result", false);
   	}
   
   	int count = service.getDibsCount(map);
   	dibs.put("dibsCount", count);
   	
   	JSONObject jsonObject = new JSONObject(dibs);
		return jsonObject.toString();
   }
   
   //크림 수정 폼 
   @GetMapping("CreamModify")
   public String CreamModifyForm(HttpSession session
	        , Model model,Criteria cri
	        , @RequestParam Map<String, Object> map ) {
		String cream_idx = (String)map.get("cream_idx");
		model.addAttribute("cri", cri);
		
		Map<String, Object> cream = service.getCream(cream_idx);
		model.addAttribute("cream", cream); 
		model.addAttribute("cri", cri);
		
	   
	   return "admin/admin_cream_modify";
   }
   
   //크림 수정 작업
   @PostMapping("CreamModifyPro")
   public String CreamModifyPro(Model model, ProductImageVO image
	          , HttpSession session, @RequestParam Map<String, Object> map) {
	   
	   System.out.println("넘어오나 ?");
	   
	      Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	        PrincipalDetails mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();
	        int sId = mPrincipalDetails.getMember().getMem_idx();


	        String productId = (String) map.get("cream_idx");
	        
			String uploadDir = "/resources/upload/cream";
			String saveDir = session.getServletContext().getRealPath(uploadDir);
			String subDir = "";
			try {
	           Date date = new Date();
	           SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
	           subDir = sdf.format(date);
	           saveDir += "/" + subDir;
	           Path path = Paths.get(saveDir);
	           Files.createDirectories(path);
	        } catch (IOException e) {
	            e.printStackTrace();
	        }

	        image.setProduct_idx(productId);
	        image.setImage_path(uploadDir+"/"+subDir);

	        MultipartFile mFile1 = image.getImage1();
	        MultipartFile mFile2 = image.getImage2();
	        MultipartFile mFile3 = image.getImage3();
	        MultipartFile mFile4 = image.getImage4();

	        String uuid = UUID.randomUUID().toString();

	        image.setImage1_name("");
	        image.setImage2_name("");
	        image.setImage3_name("");
	        image.setImage4_name("");
	        
	        

	        String imageName1 = uuid.substring(0, 8) + "_" + mFile1.getOriginalFilename();
			String imageName2 = uuid.substring(0, 8) + "_" + mFile2.getOriginalFilename();
			String imageName3 = uuid.substring(0, 8) + "_" + mFile3.getOriginalFilename();
			String imageName4 = uuid.substring(0, 8) + "_" + mFile4.getOriginalFilename();

			if(!mFile1.getOriginalFilename().equals("")) image.setImage1_name(imageName1);
			if(!mFile2.getOriginalFilename().equals("")) image.setImage2_name(imageName2);
			if(!mFile3.getOriginalFilename().equals("")) image.setImage3_name(imageName3);
			if(!mFile4.getOriginalFilename().equals("")) image.setImage4_name(imageName4);


			int insertCount = isService.modifyProductImage(image);
			if (insertCount > 0) {
			    try {
				if (!mFile1.getOriginalFilename().equals("")) mFile1.transferTo(new File(saveDir, imageName1));
				if (!mFile2.getOriginalFilename().equals("")) mFile2.transferTo(new File(saveDir, imageName2));
				if (!mFile3.getOriginalFilename().equals("")) mFile3.transferTo(new File(saveDir, imageName3));
				if (!mFile4.getOriginalFilename().equals("")) mFile4.transferTo(new File(saveDir, imageName4));
			    } catch (IllegalStateException e) {
				e.printStackTrace();
			    } catch (IOException e) {
				e.printStackTrace();
			    }
			    service.modifyCream(map);
			}
			

	   return "admin/admin_cream";
   }
   
   //크림 삭제 admin에 있던데


   //구매자가 운송장 등록하는 폼 던지기
	@GetMapping("trackingRegisterForm2")
	public String trackingRegisterForm2(
			@RequestParam String cream_idx, @RequestParam String request_idx
			, Model model) {
		
		
		Map<String,Object> cream = service.getCream(cream_idx);
		model.addAttribute("cream",cream);
		model.addAttribute("request_idx",request_idx);
		
		
		return "cream/tracking_register";
	}
	
	//운송장 등록 로직
	@PostMapping("trackingRegister2")
	public String trackingRegister(
			@RequestParam Map<String, Object> map
			, Model model) {
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		PrincipalDetails mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();
		
		int seller_idx = mPrincipalDetails.getMember().getMem_idx();
		
		//구매자는 고정값으로 넣음
		int buyer_idx = 1234;
		
		String cream_idx = (String)map.get("cream_idx");
		String request_idx = String.valueOf(map.get("request_idx"));
		
//		System.out.println("★★★★★★★★"+map.toString());
				
		map.put("seller_idx", seller_idx); // 판매자 정보
		map.put("buyer_idx", buyer_idx); 
		map.put("cream_idx", cream_idx);
		map.put("request_idx", request_idx);
				
		//courier_info 테이블의 tracking_num 이 null일때 운송장 등록 1차 else cir 테이블 update
		int trackingNumCount = service.getTrackingNum(request_idx);
		

		System.out.println("♥♥♥♥"+trackingNumCount);
		
		if(trackingNumCount == 0) {
			
			System.out.println(request_idx);
			if(service.registTracking(map) > 0) {
				model.addAttribute("msg","운송장번호 등록성공");
				return "inc/close";
			} else {
				model.addAttribute("msg","등록실패");
				return "inc/fail_back";
			}
		}else {
			if(service.updateTrackingNum(map) > 0) {
				model.addAttribute("msg","운송장번호 등록성공");
				return "inc/close";
			} else {
				model.addAttribute("msg","등록실패");
				return "inc/fail_back";
			}
			
		}
		
		
	}
	//상세조회 버튼
	@GetMapping("shippingDetail")
	public String shippingDetail(@RequestParam Integer request_idx, @RequestParam String cream_idx, Model model) {
		Map<String, Object> map = service.getCreamOrder(request_idx);
		model.addAttribute("map",map);
		return"cream/shipping_detail";
	}
	

	//리뷰작성
	@GetMapping("CreRegistReviewForm")
	public String registReviewForm(@RequestParam String product_idx, 
			@RequestParam(value="mem_idx", required=false) Integer mem_idx, 
			@RequestParam(value="buyer_idx", required=false) Integer buyer_idx, 
			HttpSession session, Model model){
		
		try {			
			Authentication auth = SecurityContextHolder.getContext().getAuthentication();
			PrincipalDetails mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();
		}
		catch(Exception e) {
			// 로그인 안되어있으면 로그인 화면으로 되돌려 보내기
			model.addAttribute("msg","권한이 없습니다 ! 로그인 해주세요");
			model.addAttribute("targetURL","login"); // 로그인 페이지 넘어갈 때 리다이렉트 할수있는거 있어야 될듯?
			return "inc/fail_forward";
		}
		
		
		
		// product_idx 는 무조건 받아와야함
		if(product_idx == null) {
			model.addAttribute("msg", "상품 정보가 없습니다. 해당 판매글에서 다시 시도해주세요 !");
			return "inc/fail_back";
		}
		
		
		Map<String,Object> cream = service.getCream(product_idx);
		model.addAttribute("cream",cream);
		
	
		
		model.addAttribute("buyer_idx",buyer_idx);
		

		return "cream/review_write_form";
	}
	
	//-----------------------리뷰 작성----------------------------------
	@PostMapping("CreRegistReviewPro")
	public String registJReviewPro(@RequestParam String product_idx, @RequestParam(value="mem_idx", required=false) String mem_idx, @RequestParam(value="buyier_idx", required=false) String buyier_idx, 
			JungGoNohVO jungGoNoh, HttpSession session, Model model, HttpServletRequest request) {
		
		try {			
			Authentication auth = SecurityContextHolder.getContext().getAuthentication();
			PrincipalDetails mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();
		}
		catch(Exception e) {
			// 로그인 안되어있으면 로그인 화면으로 되돌려 보내기
			model.addAttribute("msg","권한이 없습니다 ! 로그인 해주세요");
			model.addAttribute("targetURL","login"); // 로그인 페이지 넘어갈 때 리다이렉트 할수있는거 있어야 될듯?
			return "inc/fail_forward";
		}
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		PrincipalDetails mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();
		int writer_idx = mPrincipalDetails.getMember().getMem_idx();
		
		
		
		jungGoNoh.setBuyier_idx(writer_idx);
		jungGoNoh.setProduct_idx(product_idx);
		jungGoNoh.setMem_idx(Integer.parseInt(mem_idx));	
		System.out.println("^^^^^^^^^^^^^^^^^^^^^^^^^^"+jungGoNoh);
		
		int review_star = jungGoNoh.getReview_star();
		
		if(review_star == 0) {
			model.addAttribute("msg", "별점을 입력해주세요");
			return "inc/fail_back";
		} 			
		
		//입력 전 중복 조회
		String ifReview = jungGoNohService.getReview(jungGoNoh);
		model.addAttribute("ifReview",ifReview);
		//System.out.println("&&&&&&&&&&jungGoNoh?"+jungGoNoh);
		//System.out.println("&&&&&&&&&&ifReport?"+ifReport+"끝");
		if(ifReview == null) { //조회 내역이 없을 때
		
				//입력 작업 시작	
			int insertReview = jungGoNohService.registReview(jungGoNoh);
			
				if(insertReview < 0) {
						model.addAttribute("msg", "신청 실패");
						return "inc/fail_back";
						} 	
					} 
				else { //조회 내역이 있을때
						model.addAttribute("msg", "이미 해당 건에 대해 리뷰작성 기록이 있습니다. 고객센터를 통해 1:1 문의를 넣어주세요.");
						System.out.println("^^^^^^^^^이미 해당 건에 대해 리뷰작성 기록이 있습니다. 고객센터를 통해 1:1 문의를 넣어주세요.");
				}

		model.addAttribute("msg", "리뷰가 작성 되었습니다.");
		return "inc/close";
//		return "redirect:/store/" + jungGoNoh.getBuyier_idx();
	}


//-------------------------- 리뷰 수정 폼 이동-------------------

	@GetMapping("CreModifyReviewForm")
	//public String modifyReviewForm(@RequestParam String product_idx, @RequestParam(value="mem_idx", required=false) String mem_idx, @RequestParam(value="buyier_idx", required=false) String buyier_idx, HttpSession session, Model model, JungGoNohVO jungGoNoh){
	public String modifyReviewForm(@RequestParam String product_idx, 
			@RequestParam(value="mem_idx", required=false) Integer mem_idx, 
			@RequestParam(value="buyer_idx", required=false) Integer buyer_idx, 
			HttpSession session, Model model, JungGoNohVO jungGoNoh){
		
		try {			
			Authentication auth = SecurityContextHolder.getContext().getAuthentication();
			PrincipalDetails mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();
		}
		catch(Exception e) {
			// 로그인 안되어있으면 로그인 화면으로 되돌려 보내기
			model.addAttribute("msg","권한이 없습니다 ! 로그인 해주세요");
			model.addAttribute("targetURL","login"); // 로그인 페이지 넘어갈 때 리다이렉트 할수있는거 있어야 될듯?
			return "inc/fail_forward";
		}
		
		
		// product_idx 는 무조건 받아와야함
		if(product_idx == null) {
			model.addAttribute("msg", "상품 정보가 없습니다. 해당 판매글에서 다시 시도해주세요 !");
			return "inc/fail_back";
		}
		
		Map<String,Object> auction = service.getCream(product_idx);
		model.addAttribute("auction",auction);
		
		jungGoNoh.setMem_idx(1234);
		jungGoNoh.setBuyier_idx(buyer_idx);
		jungGoNoh.setProduct_idx(product_idx);			
		
		JungGoNohVO jungGoNohReview = jungGoNohService.getReview2(jungGoNoh);
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		PrincipalDetails mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();
		String buyier_nickname = mPrincipalDetails.getMember().getMem_nickname();
		jungGoNohReview.setBuyier_nickname(buyier_nickname);
		
		System.out.println("XXXXXXXXXXXXXXXX"+jungGoNohReview);
		
		model.addAttribute("jungGoNohReview", jungGoNohReview);
		
		return "cream/review_modify_form";
	}
	
	
	
	
//-------------------------리뷰 수정-----------------------------
	
	@PostMapping("CreModifyReviewPro")
	public String modifyReviewPro(
			@RequestParam String product_idx, @RequestParam(value="mem_idx", required=false) String mem_idx, @RequestParam(value="buyier_idx", required=false) String buyier_idx, 
			JungGoNohVO jungGoNoh, HttpSession session, Model model, HttpServletRequest request) {
		try {			
			Authentication auth = SecurityContextHolder.getContext().getAuthentication();
			PrincipalDetails mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();
		}
		catch(Exception e) {
			// 로그인 안되어있으면 로그인 화면으로 되돌려 보내기
			model.addAttribute("msg","권한이 없습니다 ! 로그인 해주세요");
			model.addAttribute("targetURL","login"); // 로그인 페이지 넘어갈 때 리다이렉트 할수있는거 있어야 될듯?
			return "inc/fail_forward";
		}
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		PrincipalDetails mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();
		int writer_idx = mPrincipalDetails.getMember().getMem_idx();

		
		jungGoNoh.setBuyier_idx(writer_idx);
		jungGoNoh.setProduct_idx(product_idx);
		jungGoNoh.setMem_idx(Integer.parseInt(mem_idx));	
		System.out.println("^^^^^^^^^^^^^^^^^^^^^^^^^^"+jungGoNoh);
		
		
		int review_star = jungGoNoh.getReview_star();
		
		if(review_star == 0) {
			model.addAttribute("msg", "별점을 입력해주세요");
			return "inc/fail_back";
		} 			
		
        LocalDate now = LocalDate.now();
        // 포맷 정의
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy/MM/dd");
        
        // 포맷 적용
        String formatedNow = now.format(formatter);
        System.out.println("formatedNow!!!!!!!!!!!!!!!!!!"+formatedNow);
		java.sql.Timestamp review_date = jungGoNoh.getReview_date();
		String reviewDateFormat = new SimpleDateFormat("yyyy/MM/dd").format(review_date);
		System.out.println("reviewDateFormat!!!!!!!!!!!!!!!!!!"+reviewDateFormat);
        SimpleDateFormat format = new SimpleDateFormat("yyyy/MM/dd");
        
        try {
			Date a_parseDate = format.parse(formatedNow);
			Date b_parseDate = format.parse(reviewDateFormat);
			
			System.out.println("a_parseDate!!!!!!!!!!!!!!!!!!" + a_parseDate);
			System.out.println("b_parseDate!!!!!!!!!!!!!!!!!!" + b_parseDate);
			System.out.println("a_parseDate.getTime()!!!!!!!!!!!!!!!!!!" + a_parseDate.getTime());
			System.out.println("b_parseDate.getTime()!!!!!!!!!!!!!!!!!!" + b_parseDate.getTime());
			
			long resultTime = b_parseDate.getTime() - a_parseDate.getTime();
			
			System.out.println("resultTime !!!!!!!!!!!!!!!!!!: "+resultTime);
			
			System.out.println("초 : "+resultTime/1000);
			System.out.println("분 : "+resultTime/(60*1000));
			System.out.println("시 : "+resultTime/(60*60*1000));
			System.out.println("일 : "+resultTime/(24*60*60*1000));
			
			long resultTimeDay = resultTime/(24*60*60*1000);
			
			if(resultTimeDay < 3 )
			{
				int ModifySuccess = jungGoNohService.modifyReview(jungGoNoh);
				
				if(ModifySuccess < 0) {
						model.addAttribute("msg", "신청 실패");
						return "inc/fail_back";
				} 	
			}
			else
			{
				model.addAttribute("msg", "3일 이상 리뷰 X");
				return "inc/fail_back";
			}
			
			
			
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "redirect:/store/" + jungGoNoh.getBuyier_idx();
	}
	
	//환불폼컨트롤러
	@GetMapping("creamRefund")
	public String creamReFund(
			@RequestParam Integer request_idx, @RequestParam String cream_idx, Model model) {
		
		Map<String, Object> map = service.getCreamOrder(request_idx);
		model.addAttribute("map",map);
		
		return "cream/refund";
	}
	
		
	//환불작업
	@PostMapping("creamRefundPro")
	public String creamRefundPro(@RequestParam Integer request_idx, @RequestParam String cream_idx, @RequestParam Integer mem_idx , Model model) {
 
		int mem_buyer_idx = mem_idx;
		
		payService.productCancelPayment(mem_buyer_idx, cream_idx);
		
		
		return "";
	}
}