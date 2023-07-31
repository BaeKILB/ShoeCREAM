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
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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
import com.pj2.shoecream.service.BidService;
import com.pj2.shoecream.service.ImageService;
import com.pj2.shoecream.vo.AuctionVO;
import com.pj2.shoecream.vo.ProductImageVO;

@Controller
public class AuctionController {
   @Autowired
   private AuctionService service;
   @Autowired
   private ImageService isService;
   @Autowired
   private BidService bidService;
   
   private static final Logger logger = LoggerFactory.getLogger(AuctionController.class);
   
   @GetMapping("Auction")
   public String auctionMain() {
      return "auction/auction_main";
   }
   
   
    @GetMapping("AuctionDetail")
    public String AuctionDetail(
        HttpSession session
        , Model model
        , @RequestParam Map<String, Object> map) { //경매 제품상세
    	//로그인 해야 이용 가능한걸로.. 버튼마다 session 체크 귀찮으니까..;
		// 회원번호
    	Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        PrincipalDetails mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();
        int sId = mPrincipalDetails.getMember().getMem_idx();
    	
//    	int sId = 2;
        
    	map.put("mem_idx", sId);
	
    	String auction_idx = (String)map.get("auction_idx");
    	
    	// 조회수 카운트
		String readAuction = (String) session.getAttribute("readAuction");
		if (readAuction == null || !readAuction.equals(auction_idx)) {
			int updateCount = service.updateReadCount(auction_idx);
			if (updateCount > 0)
				session.setAttribute("readAuction", auction_idx);
		}
	
		Map<String, Object> auction = service.getAuction(auction_idx);
		model.addAttribute("auction", auction);

		// 상품idx만 파라미터에 붙이면 되지 않을까?
		// 카테고리 붙인 이유가 뭐지? 카테고리만 눌렀을때 나오게 할려구여 아마도
		// <a
		// href="auction_detail?auction_idx=${product.auction_idx}&param=${product.auction_Scategory}">

		// 입찰내역
		Map<String, Object> bid = bidService.getBid(auction_idx);
		model.addAttribute("bid", bid);
		
		// 입찰 횟수
		int bidCount = bidService.getBidCount(auction_idx);
		model.addAttribute("bidCount", bidCount);

		// 찜
		Map<String, Object> dibs = service.getAuctionDibs(map);
		model.addAttribute("dibs", dibs);
		
		// 찜카운트
		int dibsCount = service.getDibsCount(map);
		model.addAttribute("dibsCount", dibsCount);
		
		// 판매자정보
//		int mem_idx = Integer.parseInt((String)map.get("mem_idx")); 
		
		// 판매자 정보가 안가져와진다.. 20230730 21:49
		/* java.lang.ClassCastException: class java.lang.Integer cannot be cast to class java.lang.String (java.lang.Integer and java.lang.String are in module java.base of loader 'bootstrap')
			at com.pj2.shoecream.controller.AuctionController.AuctionDetail(AuctionController.java:108) */
		
//		Map<String, Object> sellerInfo = service.getSellerInfo(mem_idx);
//		model.addAttribute("sellerInfo",sellerInfo);
		
        return "auction/auction_detail";
    }

    @GetMapping("AuctionRecord")
    public String AuctionRecord() { //경매 기록
        return "auction/auction_record";
    }
    
    @PostMapping("AuctionRegister")
    public String auctionRegister(
          AuctionVO auction
          , ProductImageVO image
          , HttpSession session) {

    	// sId 받아오기
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        PrincipalDetails mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();
        int sId = mPrincipalDetails.getMember().getMem_idx();
    	
//    	int sId = 1; // 판매자 회원번호

		auction.setMem_idx(sId); // 회원번호 추가
		String productId = String.valueOf(auction.getMem_idx()) + String.valueOf(new Date().getTime()); // 상품번호
		auction.setAuction_idx(productId); // 상품번호 추가
		image.setProduct_idx(productId);

		String uploadDir = "/resources/upload/auction";
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
		String imageName4 = uuid.substring(0, 8) + "_" + mFile3.getOriginalFilename();
	      
		if(!mFile1.getOriginalFilename().equals("")) image.setImage1_name(imageName1);
		if(!mFile2.getOriginalFilename().equals("")) image.setImage2_name(imageName2);
		if(!mFile3.getOriginalFilename().equals("")) image.setImage3_name(imageName3);
		if(!mFile4.getOriginalFilename().equals("")) image.setImage4_name(imageName4);
	        
		System.out.println(auction.toString());
	      
		int insertCount = isService.registProductImage(image);
	       
		if (insertCount > 0) {
		    try {
			if (!mFile1.getOriginalFilename().equals("")) mFile1.transferTo(new File(saveDir, imageName1));
			if (!mFile2.getOriginalFilename().equals("")) mFile2.transferTo(new File(saveDir, imageName2));
			if (!mFile3.getOriginalFilename().equals("")) mFile3.transferTo(new File(saveDir, imageName3));
			if (!mFile3.getOriginalFilename().equals("")) mFile4.transferTo(new File(saveDir, imageName4));
		    } catch (IllegalStateException e) {
			e.printStackTrace();
		    } catch (IOException e) {
			e.printStackTrace();
		    }
		    service.registAuctionItem(auction);
		}
		return "redirect:/Auction";
    }
    
    @ResponseBody
    @RequestMapping(value= "getAucList", method = RequestMethod.GET, produces = "application/text; charset=UTF-8")
    public String getAucList(
          @RequestParam Map<String, Object> map) {
       
		int pageNum = Integer.parseInt(String.valueOf(map.get("pageNum")));
		int listLimit = 20;
		int startRow = (pageNum - 1) * listLimit;
       
		map.put("startRow", startRow);
		map.put("listLimit", listLimit);
      
		List<Map<String, Object>> auctionList = service.getAuctionList(map);

		map.remove("startRow");
		map.remove("listLimit");

		int listCount = service.getAuctionList(map).size();
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

		auctionList.add(pageInfo);

		JSONArray jsonArray = new JSONArray(auctionList);
		return jsonArray.toString();
	}
    
    
    //입찰하기
    @GetMapping("biddingPopup")
	public String biddingPopup(
			@RequestParam String auction_idx
			, Model model
			, HttpSession session) {

		// db에서 자료 불러온다
		Map<String, Object> auction = service.getAuction(auction_idx);
		model.addAttribute("auction", auction);

		// bid_table에서도 자료 불러온다 bid_price
		Map<String, Object> bid = bidService.getBid(auction_idx);
		model.addAttribute("bid", bid);
		return "auction/bidding_popup";
	}
    
    
    //즉시구매
    @GetMapping("buyingPopup")
    public String buyingPopup(HttpSession session
         , Model model
         , @RequestParam String auction_idx) {
       
      Map<String, Object> auction = service.getAuction(auction_idx);
      model.addAttribute("auction",auction);
      
      
       return "auction/buying_popup";
    }
    
    
    @PostMapping("biddingPro")
    public String insertBid(
    		@RequestParam Map<String, Object> map
    		, Model model
    		, HttpSession session) {
    	
    	
    	//본인이 입찰 못하게 막기
    	
    	//auc_bid_unit 단위로만 입찰 가능하게 
    	
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		PrincipalDetails mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();
		int sId = mPrincipalDetails.getMember().getMem_idx();

		map.put("mem_idx", sId);

		int insertCount = bidService.insertBid(map);
		if (insertCount > 0) {
			return "inc/close";
		} else {
			return "fail_back";
		}
    }
    
    @ResponseBody
    @RequestMapping(value= "dibsEvent", method = RequestMethod.POST, produces = "application/text; charset=UTF-8")
    public String dibsEvent(
    		@RequestParam Map<String,Object> map
    		, Model model) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        PrincipalDetails mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();
        int sId = mPrincipalDetails.getMember().getMem_idx();
        
    	map.put("mem_idx", sId);
    	
    	Map<String, Object> dibs = service.getAuctionDibs(map);
    	
    	if (dibs == null) {
    		service.registDibs(map);
    		dibs = service.getAuctionDibs(map);
    		dibs.put("result", true);
    	} else {
    		service.deleteDibs(map);
    		dibs = service.getAuctionDibs(map);
    		dibs = new HashMap<String, Object>();
    		dibs.put("result", false);
    	}
    
    	int count = service.getDibsCount(map);
    	dibs.put("dibsCount", count);
    	
    	JSONObject jsonObject = new JSONObject(dibs);
		return jsonObject.toString();
    }

    
    
    
}