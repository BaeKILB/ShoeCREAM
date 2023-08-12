package com.pj2.shoecream.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
import com.pj2.shoecream.vo.CreamVO;
import com.pj2.shoecream.vo.Criteria;
import com.pj2.shoecream.vo.ProductImageVO;

@Controller
public class CreamController {//크림 컨트롤러 입니다.
	
	  @Autowired
	   private ImageService isService;
	  
	  @Autowired
	  private CreamService service;
	  
	  @Autowired
	  private AuctionService aucService;
	
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
	
		Map<String, Object> cream = service.getCream(cream_idx);
		cream.put("isLogin", sId);
		model.addAttribute("cream", cream);


		 //찜
		Map<String, Object> dibs = service.getCreamDibs(map);
//		
//		
		model.addAttribute("dibs", dibs);
//		
		 //찜카운트
		int dibsCount = service.getDibsCount(map);
		model.addAttribute("dibsCount", dibsCount);
		

		
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
   
   //크림 수정 폼 - 페이지 안넘어가짐 이유를 모르겠음
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
   
   @PostMapping("CreamModifyPro")
   public String CreamModifyPro(Model model, ProductImageVO image
	          , HttpSession session) {
	   
	   
	   return "admin/admin_cream";
   }

   //구매자가 운송장 등록하는 폼 던지기
	@GetMapping("trackingRegisterForm2")
	public String trackingRegisterForm2(
			@RequestParam String cream_idx
			, Model model) {
		Map<String,Object> cream = service.getCream(cream_idx);
		model.addAttribute("cream",cream);
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
		
		map.put("seller_idx", seller_idx); // 판매자 정보
		map.put("buyer_idx", buyer_idx); 
		map.put("cream_idx", cream_idx);
		
		if(service.registTracking(map) > 0) {
			model.addAttribute("msg","운송장번호 등록성공");
			return "inc/close";
		} else {
			model.addAttribute("msg","등록실패");
			return "inc/fail_back";
		}
		
	}
		
	
}
