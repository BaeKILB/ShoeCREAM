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
import com.pj2.shoecream.service.JungGoNohService;
import com.pj2.shoecream.service.PayService;
import com.pj2.shoecream.vo.AuctionVO;
import com.pj2.shoecream.vo.JungGoNohVO;
import com.pj2.shoecream.vo.MemberVO;
import com.pj2.shoecream.vo.PayInfoVO;
import com.pj2.shoecream.vo.PointInoutVO;
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
   @Autowired 
   private PayService payService;
   @Autowired
   private JungGoNohService jungGoNohService;
   
   private static final Logger logger = LoggerFactory.getLogger(AuctionController.class);
   
   @GetMapping("Auction")
   public String auctionMain(
		   @RequestParam(required = false) Map<String, Object> map
		   , Model model) {
	   
	   	int sId = 0;
		
	   	try {
				Authentication auth = SecurityContextHolder.getContext().getAuthentication();
				PrincipalDetails mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();
				sId = mPrincipalDetails.getMember().getMem_idx();
			} catch (Exception e) {
				e.printStackTrace();
			}
	   	model.addAttribute("sId", sId);
	   
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
		int listLimit = 12;
		if (map.containsKey("main")) {
			listLimit = 4;
		}
		int startRow = (pageNum - 1) * listLimit;
       
		map.put("startRow", startRow);
		map.put("listLimit", listLimit);
      
		List<Map<String, Object>> auctionList = service.getAuctionList(map);

		map.remove("startRow");
		map.remove("listLimit");

		int listCount = service.getAuctionList(map).size();
		int pageListLimit = 12;
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

//		auction.setMem_idx(sId); // 회원번호 추가
//		String productId = String.valueOf(auction.getMem_idx()) + String.valueOf(new Date().getTime()); // 상품번호
//		auction.setAuction_idx(productId); // 상품번호 추가
//		image.setProduct_idx(productId);

        String productId = image.getProduct_idx();
        
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
		    
		    //이미지 업로드가 성공하면 
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

	   	int sId = 0;
		
	   	try {
			Authentication auth = SecurityContextHolder.getContext().getAuthentication();
			PrincipalDetails mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();
			sId = mPrincipalDetails.getMember().getMem_idx();
		} catch (Exception e) {
			e.printStackTrace();
		}
	   	model.addAttribute("sId", sId);
    	
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
		
		// bid_table에서도 자료 불러온다 bid_price
		Map<String, Object> bid = bidService.getBid(auction_idx);
		model.addAttribute("bid", bid);

		return "auction/buying_popup";
    }
    
    // 입찰
    @ResponseBody
    @RequestMapping(value= "biddingPro", method = RequestMethod.POST, produces = "application/text; charset=UTF-8")
    public String insertBid(
    		@RequestParam Map<String, Object> map
    		, Model model
    		, HttpSession session) {
    	
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		PrincipalDetails mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();
		
		Map<String, Object> resultData = new HashMap<String,Object>();
		
		// 구매자 회원번호
		int sId = mPrincipalDetails.getMember().getMem_idx();
    	map.put("mem_idx", sId);
    	int deposit = Integer.parseInt(String.valueOf(map.get("deposit")));
    	
    	// 상품번호
    	String auction_idx = String.valueOf(map.get("auction_idx"));
    	
    	// 상품정보
    	Map<String,Object> auction = service.getAuction(auction_idx);
    	
    	// 구매자 정보
    	MemberVO buyer = service.getMember(sId);
    	
//    	 판매자 정보
//    	MemberVO seller = service.getMember(Integer.parseInt(String.valueOf(auction.get("mem_idx"))));
    	
		// 상품 입찰내역 정보
		Map<String, Object> bidInfo = bidService.getBid(auction_idx);
		
		int oldDeposit = 0;
		int bid_mem_idx = 0;
		
		if(bidInfo != null) {
			oldDeposit = Integer.parseInt(String.valueOf(bidInfo.get("deposit")));
			bid_mem_idx = Integer.parseInt(String.valueOf(bidInfo.get("mem_idx")));
		}
		// 구매자가 즉시구매가 가능한 포인트를 가지고 있다면 결제 로직 진행
		int paymentResult = 0;
		if(buyer.getCharge_point() > 0) {
			PointInoutVO inVO = new PointInoutVO();
			inVO.setMem_idx(buyer.getMem_idx());
			inVO.setCharge_point(deposit);
			inVO.setPoint_usage("결제사용");
			paymentResult = payService.withdrawPoints(inVO); // 결제서비스.입출금메소드();
			// 결제 성공
			if(paymentResult > 0) {
				// 입찰내역이 있을경우 
				if(bidInfo != null) {
					// 기존 입찰내역 경매 상태변경(입찰 -> 환불)
					bidService.modifyBid(map);
					// 기존 입찰내역 보증금 반환
					PointInoutVO outVO = new PointInoutVO();
					outVO.setMem_idx(bid_mem_idx);
					outVO.setCharge_point(oldDeposit);
					outVO.setPoint_usage("결제취소출금");
					paymentResult = payService.depositPoints(outVO); // 결제서비스.입출금메소드();
				}
				// 입찰내역 삽입
				bidService.insertBid(map);
				
				resultData.put("msg", "입찰 성공");
				resultData.put("result", true);
				JSONObject jsonObject = new JSONObject(resultData);
				return jsonObject.toString();
				
			// 결제 실패
			} else {
				resultData.put("msg", "결제 실패");
				resultData.put("result", false);
				JSONObject jsonObject = new JSONObject(resultData);
				return jsonObject.toString();
			}
		// 잔액 부족
		} else {
			resultData.put("msg", "잔액이 부족합니다. 충전후 재시도 바랍니다.");
			resultData.put("result", false);
			JSONObject jsonObject = new JSONObject(resultData);
			return jsonObject.toString();
		}
    }
    
    @ResponseBody
    @RequestMapping(value= "buyingPro", method = RequestMethod.POST, produces = "application/text; charset=UTF-8")
    public String insertBuying(
    		@RequestParam Map<String, Object> map
    		, Model model
    		, HttpSession session) {
    	
		Map<String, Object> resultData = new HashMap<String,Object>();
    	
    	// 구매자 회원번호
    	Authentication auth = SecurityContextHolder.getContext().getAuthentication();
    	PrincipalDetails mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();
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
//    	MemberVO seller = service.getMember(Integer.parseInt(String.valueOf(auction.get("mem_idx"))));

		// 구매자가 즉시구매가 가능한 포인트를 가지고 있다면 결제 로직 진행
		int paymentResult = 0;
		if(buyer.getCharge_point() > auc_buy_instantly) {
			PayInfoVO payInfoVO = new PayInfoVO();
			payInfoVO.setMem_idx(buyer.getMem_idx());
			payInfoVO.setProduct_idx(auction_idx);
			payInfoVO.setProduct_selector(1);
			payInfoVO.setPay_method(2);
			payInfoVO.setPay_total(auc_buy_instantly);
			
			PointInoutVO inVO = new PointInoutVO();
			inVO.setMem_idx(buyer.getMem_idx());
			inVO.setCharge_point(auc_buy_instantly);
			inVO.setPoint_usage("결제사용");
			paymentResult = payService.productPayment(payInfoVO,inVO); // 결제서비스.입출금메소드();
			// 결제 성공
			if(paymentResult > 0) {
				// 상품 입찰내역 정보
				Map<String, Object> bidInfo = bidService.getBid(auction_idx);
				
				// 입찰내역이 있을경우 
				if(bidInfo != null) {
					// 기존 입찰내역 경매 상태변경(입찰 -> 환불)
					bidService.modifyBid(map);
					
					// 기존 입찰내역 보증금 반환
					int oldDeposit = Integer.parseInt(String.valueOf(bidInfo.get("deposit")));
					int bid_mem_idx = Integer.parseInt(String.valueOf(bidInfo.get("mem_idx")));
					
					PointInoutVO outVO = new PointInoutVO();
					outVO.setMem_idx(bid_mem_idx);
					outVO.setCharge_point(oldDeposit);
					outVO.setPoint_usage("결제취소출금");
					paymentResult = payService.depositPoints(outVO); // 결제서비스.입출금메소드();
				} 
					// 입찰내역 추가 및 경매상품 상태 변경
					bidService.insertBidBuyNow(map);
					service.modifyAuctionState(auction_idx);
					
					resultData.put("msg", "구매 성공");
					resultData.put("result", true);
					JSONObject jsonObject = new JSONObject(resultData);
					return jsonObject.toString();
			// 결제 실패
			} else {
				resultData.put("msg", "결제 실패");
				resultData.put("result", false);
				JSONObject jsonObject = new JSONObject(resultData);
				return jsonObject.toString();
				
			}
		// 잔액 부족
		} else {
			resultData.put("msg", "잔액이 부족합니다. 충전후 재시도 바랍니다.");
			resultData.put("result", false);
			JSONObject jsonObject = new JSONObject(resultData);
			return jsonObject.toString();
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
    
    @ResponseBody
    @RequestMapping(value= "bidHistory", method = RequestMethod.GET, produces = "application/text; charset=UTF-8")
    public String bidHistory(
    		@RequestParam String auction_idx
    		, Model model) {
    	
    	List<Map<String, Object>> bidList = bidService.getBidList(auction_idx);
    	JSONArray jsonArray = new JSONArray(bidList);
    	return jsonArray.toString();
    }

    
	//-----------------------리뷰 작성 폼 이동-------------------------
	@GetMapping("AucRegistReviewForm")
	public String registReviewForm(@RequestParam String auction_idx, @RequestParam(value="mem_idx", required=false) String mem_idx, @RequestParam(value="buyier_idx", required=false) String buyier_idx, HttpSession session, Model model, JungGoNohVO jungGoNoh){
		
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
		
		String product_idx = auction_idx;
		
		// product_idx 는 무조건 받아와야함
		if(product_idx == null) {
			model.addAttribute("msg", "상품 정보가 없습니다. 해당 판매글에서 다시 시도해주세요 !");
			return "inc/fail_back";
		}
		jungGoNoh.setMem_idx(Integer.parseInt(mem_idx));
		jungGoNoh.setBuyier_idx(Integer.parseInt(buyier_idx));
		jungGoNoh.setProduct_idx(product_idx);			
		
		JungGoNohVO jungGoNohReview = jungGoNohService.getProduct(product_idx);
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		PrincipalDetails mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();
		String buyier_nickname = mPrincipalDetails.getMember().getMem_nickname();
		jungGoNohReview.setBuyier_nickname(buyier_nickname);
		model.addAttribute("jungGoNohReview", jungGoNohReview);
		

		return "junggo/review_write_form";
	}
	
	//-----------------------리뷰 작성----------------------------------
	@PostMapping("AucRegistReviewPro")
	public String registJReviewPro(@RequestParam String auction_idx, @RequestParam(value="mem_idx", required=false) String mem_idx, @RequestParam(value="buyier_idx", required=false) String buyier_idx, 
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
		
		String product_idx = auction_idx;
		
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

		
		return "home";
	}


//-------------------------- 리뷰 수정 폼 이동-------------------

	@GetMapping("AucModifyReviewForm")
	//public String modifyReviewForm(@RequestParam String product_idx, @RequestParam(value="mem_idx", required=false) String mem_idx, @RequestParam(value="buyier_idx", required=false) String buyier_idx, HttpSession session, Model model, JungGoNohVO jungGoNoh){
	public String modifyReviewForm(@RequestParam String auction_idx, @RequestParam String mem_idx, @RequestParam String buyier_idx, HttpSession session, Model model, JungGoNohVO jungGoNoh){
		
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
		
		String product_idx = auction_idx;
		
		// product_idx 는 무조건 받아와야함
		if(product_idx == null) {
			model.addAttribute("msg", "상품 정보가 없습니다. 해당 판매글에서 다시 시도해주세요 !");
			return "inc/fail_back";
		}
		jungGoNoh.setMem_idx(Integer.parseInt(mem_idx));
		jungGoNoh.setBuyier_idx(Integer.parseInt(buyier_idx));
		jungGoNoh.setProduct_idx(product_idx);			
		
		JungGoNohVO jungGoNohReview = jungGoNohService.getReview2(jungGoNoh);
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		PrincipalDetails mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();
		String buyier_nickname = mPrincipalDetails.getMember().getMem_nickname();
		jungGoNohReview.setBuyier_nickname(buyier_nickname);
		
		System.out.println("XXXXXXXXXXXXXXXX"+jungGoNohReview);
		
		model.addAttribute("jungGoNohReview", jungGoNohReview);
		
		return "auction/review_modify_form";
	}
	
	
	
	
//-------------------------리뷰 수정-----------------------------
	
	@PostMapping("AucModifyReviewPro")
	public String modifyReviewPro(@RequestParam String auction_idx, @RequestParam(value="mem_idx", required=false) String mem_idx, @RequestParam(value="buyier_idx", required=false) String buyier_idx, 
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

		String product_idx = auction_idx;
		
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
		
		
		
				
		
		return "home";
	}
	
	//-------------------------리뷰 삭제-----------------------------
	@GetMapping("AucReviewDelete")
	public String reviewDelete(@RequestParam String auction_idx, @RequestParam(value="mem_idx", required=false) String mem_idx, @RequestParam(value="buyier_idx", required=false) String buyier_idx, HttpSession session, Model model, JungGoNohVO jungGoNoh) {
	
		
		int countReview = 0;
		countReview = jungGoNohService.deleteReview(jungGoNoh);
		
		
		if(countReview > 0) 
		{ // 성공
			
			// 글쓰기 작업 성공 시 글목록(BoardList)으로 리다이렉트
			return "redirect:/productDetail?auction_idx="+auction_idx; 
		} else { // 실패
			model.addAttribute("msg", "글 쓰기 실패!");
			return "inc/fail_back";
		}
	}
		
		
    
    
    
}