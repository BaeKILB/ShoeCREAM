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
import com.pj2.shoecream.service.CategoryService;
import com.pj2.shoecream.service.ImageService;
import com.pj2.shoecream.vo.AuctionVO;
import com.pj2.shoecream.vo.MemberVO;
import com.pj2.shoecream.vo.ProductImageVO;


@Controller
public class AuctionController {
   @Autowired
   private AuctionService service;
   @Autowired
   private ImageService isService;
   @Autowired
   private BidService bidService;
   @Autowired
   private CategoryService categoryService;
   
   private static final Logger logger = LoggerFactory.getLogger(AuctionController.class);
   
   @GetMapping("Auction")
   public String auctionMain(
		   @RequestParam(required = false) Map<String, Object> map
		   , Model model) {
	   List<Map<String, Object>> lc_category = categoryService.getLcList();
	   model.addAttribute("lc_category",lc_category);
	   
	   List<Map<String, Object>> mc_category = categoryService.getMcList(0);
	   model.addAttribute("mc_category",mc_category);
	   if (map != null) model.addAttribute("code", map);
		   
	   return "auction/auction_main";
   }
   
    @GetMapping("AuctionDetail")
    public String AuctionDetail(
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
    	
    	String auction_idx = (String)map.get("auction_idx");
    	
    	// 조회수 카운트
		String readAuction = (String) session.getAttribute("readAuction");
		if (readAuction == null || !readAuction.equals(auction_idx)) {
			int updateCount = service.updateReadCount(auction_idx);
			if (updateCount > 0)
				session.setAttribute("readAuction", auction_idx);
		}
	
		Map<String, Object> auction = service.getAuction(auction_idx);
		auction.put("isLogin", sId);
		model.addAttribute("auction", auction);


		// 입찰내역
		Map<String, Object> bid = bidService.getBid(auction_idx);
		model.addAttribute("bid", bid);
		
		// 입찰내역 리스트
		List<Map<String, Object>> bidList = bidService.getBidList(auction_idx);
		model.addAttribute("bidList", bidList);
		
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
		int mem_idx = Integer.parseInt(String.valueOf(auction.get("mem_idx"))); 
		Map<String, Object> sellerInfo = service.getSellerInfo(mem_idx);
		model.addAttribute("sellerInfo",sellerInfo);
		
		// 판매자 판매물품
		List<Map<String, Object>> sellerItemList = service.getSellerItemList(mem_idx);
		model.addAttribute("sellerItemList",sellerItemList);
		
		// 연관 상품
		List<Map<String, Object>> relatedProducts = service.getRelatedAuctionList(auction);
		model.addAttribute("relatedProducts",relatedProducts);
		
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
		String imageName4 = uuid.substring(0, 8) + "_" + mFile4.getOriginalFilename();
	      
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
			if (!mFile4.getOriginalFilename().equals("")) mFile4.transferTo(new File(saveDir, imageName4));
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
    
    //글 수정 0801 이온 작업중  사진부분 빼고
	@GetMapping("AuctionModifyForm")
	public String modifyForm( HttpSession session
					        , Model model
					        , @RequestParam Map<String, Object> map ) {

		//글 수정은 경매 진행중인경우 연장만 가능하도록? 논의가 필요하무니다
		
		//글번호(auction_idx) 필요하고 
		String auction_idx = (String)map.get("auction_idx");
		
		//select로 불러와서 맵에 저장하고 뷰페이지에 뿌려준당
		//detail에 쓰던코드 가져오면 될것같음
		
		// auction_idx 에 해당하는 데이터 전달
		Map<String, Object> auction = service.getAuction(auction_idx);
		model.addAttribute("auction", auction);
		
		// 대분류 카테고리 리스트 전달
		List<Map<String, Object>> lc_category = categoryService.getLcList();
		model.addAttribute("lc_category",lc_category);
		
		//내가 등록했던 사진을 보여주는건 어떻게 해야할지 의문..
		// 사진은 auction 에 image_path , imaga1... 로 이미지를 가져 옵니다.

		return "common/auction_modify_form";
	}

	
	
	@PostMapping("AuctionModifyPro")
	public String AuctionModifyPro( 
								AuctionVO auction
					          , ProductImageVO image
					          , HttpSession session) {

    	// sId 받아오기
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        PrincipalDetails mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();
        int sId = mPrincipalDetails.getMember().getMem_idx();
 	   System.out.println("★★★★★★★ㅇㄻㄴ★★★★★★★★여기?");

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

		int insertCount = isService.modifyProductImage(image);

		if (insertCount > 0) {
			   System.out.println("★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★여기333?");
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
		   System.out.println("★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★여기?");
		    service.modifyAuctionItem(auction);
		}
		
		
		return "redirect:/Auction";


	}
    
    //글 삭제
	@PostMapping("AuctionDelete")
	public String auctionDelete() {
		
		
		return "";
	}
	
    
    
    //입찰 폼이동
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
    
    
    // 즉시구매 폼이동
    @GetMapping("buyingPopup")
    public String buyingPopup(@RequestParam String auction_idx
			, Model model
			, HttpSession session) {
       
		// db에서 자료 불러온다
		Map<String, Object> auction = service.getAuction(auction_idx);
		model.addAttribute("auction", auction);

		return "auction/buying_popup";
    }
    
    // 입찰
    @PostMapping("biddingPro")
    public String insertBid(
    		@RequestParam Map<String, Object> map
    		, Model model
    		, HttpSession session) {
    	
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		PrincipalDetails mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();
		
		// 구매자 회원번호
		int sId = mPrincipalDetails.getMember().getMem_idx();
    	map.put("mem_idx", sId);
    	
    	// 상품번호
    	String auction_idx = String.valueOf(map.get("auction_idx"));
    	
    	// 상품정보
    	Map<String,Object> auction = service.getAuction(auction_idx);
    	
    	// 구매자 정보
    	MemberVO buyer = service.getMember(sId);
    	
    	// 판매자 정보
    	MemberVO seller = service.getMember(Integer.parseInt(String.valueOf(auction.get("mem_idx"))));
    	
		// 상품 입찰내역 정보
		Map<String, Object> bidInfo = bidService.getBid(auction_idx);
		
		int deposit = 0;
		int bid_mem_idx = 0;
		int price = 0;
		
		if(bidInfo != null) {
			deposit = Integer.parseInt(String.valueOf(bidInfo.get("deposit")));
			bid_mem_idx = Integer.parseInt(String.valueOf(bidInfo.get("mem_idx")));
			price = Integer.parseInt(String.valueOf(bidInfo.get("bid_price")));
		} else {
			price = Integer.parseInt(String.valueOf(auction.get("auc_start_price")));
		}
		// 구매자가 즉시구매가 가능한 포인트를 가지고 있다면 결제 로직 진행
		boolean paymentResult = false;
		if(buyer.getMem_balance() > price) {
			paymentResult = true; // 결제서비스.입출금메소드();
			if(paymentResult) {
				// 입찰내역이 있을경우 유찰로 변경하고 돈 돌려줌
				if(bidInfo != null) {
					logger.info("!@#$ : 입찰내역이 있음");
					int updateCount = bidService.modifyBid(map);
					// 기존 입찰내역 변경 성공시 환불
					if(updateCount > 0) {
//						포인트결제서비스.출금메서드(bid_mem_idx,deposit);
						logger.info("!@#$ 환불금액");
						logger.info(String.valueOf(deposit));
						logger.info("!@#$ 환불대상");
						logger.info(String.valueOf(bid_mem_idx));
					} else {
						model.addAttribute("msg","기존 입찰내역 변경 실패");
					}
				}
				// 입찰내역 삽입
				int insertCount = bidService.insertBid(map);
				if(insertCount > 0) {
					model.addAttribute("msg","입찰 성공!");
					return "inc/close";
				}
			// 결제가 실패했을 경우
			} else {
				model.addAttribute("msg","결제 실패");
			}
		// 포인트 잔액이 부족할 경우
		} else {
			model.addAttribute("msg","잔액이 부족합니다.\n충전후 재시도 바랍니다.");
		}
		
		return "fail_back";
    }
    
    // 즉시 구매 (입출금 로직 필요)
    @PostMapping("buyingPro")
    public String insertBuying(
    		@RequestParam Map<String, Object> map
    		, Model model
    		, HttpSession session) {
    	
    	Authentication auth = SecurityContextHolder.getContext().getAuthentication();
    	PrincipalDetails mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();
    	// 구매자 회원번호
    	int sId = mPrincipalDetails.getMember().getMem_idx();
    	map.put("mem_idx", sId);
    	
    	// 상품번호
    	String auction_idx = String.valueOf(map.get("auction_idx"));
    	
    	// 상품정보
    	Map<String,Object> auction = service.getAuction(auction_idx);
    	int auc_buy_instantly = Integer.parseInt(String.valueOf(auction.get("auc_buy_instantly")));
    	map.put("auc_buy_instantly", auc_buy_instantly); // 즉시구매금액 전달
    	
    	// 구매자 정보
    	MemberVO buyer = service.getMember(sId);
    	
    	// 판매자 정보
    	MemberVO seller = service.getMember(Integer.parseInt(String.valueOf(auction.get("mem_idx"))));

		// 구매자가 즉시구매가 가능한 포인트를 가지고 있다면 결제 로직 진행
		boolean paymentResult = false;
		if(buyer.getMem_balance() > auc_buy_instantly ) {
			paymentResult = true; // 결제서비스.입출금메소드();
			if(paymentResult) {
				// 상품 입찰내역 정보
				logger.info("!@#$ 즉시구매 결제완료후");
				Map<String, Object> bidInfo = bidService.getBid(auction_idx);
				
				// 입찰내역이 있을경우 유찰로 변경하고 돈 돌려줌
				if(bidInfo != null) {
					logger.info("!@#$ 즉시구매 입찰내역이 있을경우");
					int updateCount = bidService.modifyBid(map);
					// 기존 입찰내역 변경 성공시 환불
					if(updateCount > 0) {
						int deposit = Integer.parseInt(String.valueOf(bidInfo.get("deposit")));
						int bid_mem_idx = Integer.parseInt(String.valueOf(bidInfo.get("mem_idx")));
//						포인트결제서비스.출금메서드(bid_mem_idx,deposit);
						logger.info("!@#$ 환불금액");
						logger.info(String.valueOf(deposit));
						logger.info("!@#$ 환불대상");
						logger.info(String.valueOf(bid_mem_idx));
					} else {
						model.addAttribute("msg","기존 입찰내역 변경 실패");
					}
				} 
				// 입찰내역 삽입
				int insertCount = bidService.insertBidBuyNow(map);
				if(insertCount > 0) {
					service.modifyAuctionState(auction_idx);
					model.addAttribute("msg","구매 성공!");
					return "inc/close";
				}
			// 결제가 실패했을 경우
			} else {
				model.addAttribute("msg","결제 실패");
			}
		// 포인트 잔액이 부족할 경우
		} else {
			model.addAttribute("msg","잔액이 부족합니다.\n충전후 재시도 바랍니다.");
		}
		
		return "fail_back";
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
    
    @ResponseBody
    @RequestMapping(value= "bidHistory", method = RequestMethod.GET, produces = "application/text; charset=UTF-8")
    public String bidHistory(
    		@RequestParam String auction_idx
    		, Model model) {
    	
    	List<Map<String, Object>> bidList = bidService.getBidList(auction_idx);
    	JSONArray jsonArray = new JSONArray(bidList);
    	return jsonArray.toString();
    }

    
    
    
}