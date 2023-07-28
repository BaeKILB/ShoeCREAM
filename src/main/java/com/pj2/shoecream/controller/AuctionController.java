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
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.pj2.shoecream.service.AuctionService;
import com.pj2.shoecream.service.ImageService;
import com.pj2.shoecream.vo.AuctionVO;
import com.pj2.shoecream.vo.ProductImageVO;

@Controller
public class AuctionController {
	@Autowired
	private AuctionService service;
	@Autowired
	private ImageService isService;
	
	private static final Logger logger = LoggerFactory.getLogger(AuctionController.class);
	
	@GetMapping("Auction")
	public String auctionMain(
			Model model) {
		return "auction/auction_main";
	}
    @GetMapping("AuctionDetail")
    public String AuctionDetail(HttpSession session, Model model, @RequestParam int product_idx) { //경매 제품상세
    	//로그인 해야 이용 가능한걸로.. 버튼마다 session 체크 귀찮으니까..;
		String sId = (String)session.getAttribute("sId");
		
		if(sId == null) {
			model.addAttribute("msg","로그인 후 이용해주세요!");
			model.addAttribute("target","auction_loginForm");
			return "success";
		}
		
    	
    	//상품idx만 파라미터에 붙이면 되지 않을까?
    	//카테고리 붙인 이유가 뭐지? 카테고리만 눌렀을때 나오게 할려구여 아마도
    	//<a href="auction_detail?auction_idx=${product.auction_idx}&param=${product.auction_Scategory}">
    	
    	//가장 기본적인 가져와야할 정보 불러오자
    	//product 테이블의 정보 받아오기 
//    	Map<String, String> product = service.product(product_idx);
    	
    	
    	//auction 테이블 정보 가져오기
//    	Map<String, String> auction = service.auction(product_idx);
    	
    	//이미지 테이블 정보 가져오기
//    	List<String> images = service.image(product_idx);
    	
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
    	session.setAttribute("sId", "1"); // 가상의 회원번호
    	auction.setMem_idx(Integer.parseInt((String)session.getAttribute("sId"))); // 회원번호 추가
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
    	
    	if (insertCount>0) {
    		try {
				if(!mFile1.getOriginalFilename().equals("")) mFile1.transferTo(new File(saveDir, imageName1));
				if(!mFile2.getOriginalFilename().equals("")) mFile2.transferTo(new File(saveDir, imageName2));
				if(!mFile3.getOriginalFilename().equals("")) mFile3.transferTo(new File(saveDir, imageName3));
				if(!mFile3.getOriginalFilename().equals("")) mFile4.transferTo(new File(saveDir, imageName4));
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
    		service.auctionRegist(auction);
    	}
    	return "redirect:/Auction";
    }
    
    @ResponseBody
    @RequestMapping(value= "getAucList", method = RequestMethod.GET, produces = "application/text; charset=UTF-8")
    public String getAucList(
    		@RequestParam Map<String, Object> map
    		) {
    	System.out.println("!@#$"+map.toString());
    	
		int pageNum = Integer.parseInt(String.valueOf(map.get("pageNum")));
		int listLimit = 20;
		int startRow = (pageNum -1) * listLimit;
    	
		map.put("startRow", startRow);
		map.put("listLimit", listLimit);
		
		List<Map<String, Object>> auctionList = service.auctionList(map);
		
		map.remove("startRow");
		map.remove("listLimit");
		
		int listCount = service.auctionList(map).size();
		int pageListLimit = 20;
		int maxPage = listCount / listLimit + (listCount % listLimit > 0 ? 1 : 0);
		int startPage = (pageNum - 1) / pageListLimit * pageListLimit + 1;
		int endPage = startPage + pageListLimit - 1;
		if(endPage > maxPage) {
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
    
}