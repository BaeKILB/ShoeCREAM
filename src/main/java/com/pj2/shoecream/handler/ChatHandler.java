package com.pj2.shoecream.handler;

import java.util.Map;

import org.springframework.stereotype.Component;

import com.pj2.shoecream.vo.ChatMsgVO;

@Component
public class ChatHandler {
	
	// ============ 채팅 상단 바에 ajax 로 반환할 html
	// 0. 기본 틀
	public String chatMsgBarBody(Map<String,Object> map ,boolean isBuyer, String product_btn, String user_btn) {
		
		// 구매자 판매자에 따라 다르게 표기
		String userStr = "";
		
		// 만약 지금 메시지 상대방이 구매자, 판매자 일때 유저 레이아웃 배치
		if(!isBuyer) {			
			userStr = 
					"	<section>"
					+ "		<img src='" + map.get("mem_buyer_img") + "' alt=''>"
					+ "	</section>"
					+ "	<section>"
					+ "		<p>" + map.get("mem_buyer_nickname") + "</p>"
					+ "		<p>" + map.get("mem_buyer_rank") + "</p>"
					+ "	</section>"
					+ "	<section>"
					+ "		<p></p>"
					+ "	</section>"
					+ "	<section>"
					+	user_btn
					+ "	</section>";
		}
		else {
			userStr = 
					"	<section>"
							+ "		<img src='" + map.get("mem_seller_img") + "' alt=''>"
							+ "	</section>"
							+ "	<section>"
							+ "		<p>" + map.get("mem_seller_nickname") + "</p>"
							+ "		<p>" + map.get("mem_seller_rank") + "</p>"
							+ "	</section>"
							+ "	<section>"
							+ "		<p></p>"
							+ "	</section>"
							+ "	<section>"
							+	user_btn
							+ "	</section>";
			
		}
		
		String htmlStr = 
				"<div class='product_info_wrap row'>"
						+ "	<section>"
						+ "		<img src='" 
						+ 		map.get("image_path")  
						+		map.get("image1")  
						+ " ' alt=''>"
						+ "	</section>"
						+ "	<section>"
						+ "		<p>" + map.get("product_title") + "</p>"
						+ "		<p>" + map.get("product_price") + "원</p>"
						+ "	</section>"
						+ "	<section>"
						+ "		<p>상품상태 : " + map.get("product_status") + "</p>"
						+ "	</section>"
						+ "	<section>"
						+ 		product_btn				    		
						+ "	</section>"
						+ "</div>"
						+ "<div class='chat_member_wrap row'>"
						+ 	userStr
						+ "</div>";
		
		return htmlStr;
	}
	
	
	
	// 1. 대기중 상황 ================================
	public String buyerWaitingHtml(Map<String,Object> map) {
		String product_btn = 
				"<input type='button' class='btn btn-primary' value='예약진행하기'/>";
		
		String user_btn = 
				"		<input type='button' class='btn btn-dark' value='신고하기'/>		"	    		
				+ "		<input type='button' class='btn btn-primary' value='나가기'/>		"	    		
				;
	
		return chatMsgBarBody(map,true,product_btn,user_btn);
	}
	public String sellerWaitingHtml(Map<String,Object> map) {
		String product_btn = 
				"";
		
		String user_btn = 
				"		<input type='button' class='btn btn-dark' value='신고하기'/>		"	    		
				+ "		<input type='button' class='btn btn-primary' value='나가기'/>		"	    		
				;
	
		return chatMsgBarBody(map,false,product_btn,user_btn);
	}
	
	//================ 대기중 끝
	
	// 2. 예약중 ==================================
	
	public String buyerResHtml(Map<String,Object> map) {
		
		String product_btn = "";
		if(map.get("product_payment").equals("안전페이")
				|| map.get("product_payment").equals("안전페이,직거래")) {
			product_btn = "<input type='button' class='btn btn-primary' value='결제하기'/>";	
		}
		else {
			product_btn = 
					"<input type='button' class='btn btn-primary' value='인수하기'/>";	
		}
		String user_btn = 
				"		<input type='button' class='btn btn-dark' value='신고하기'/>		"	    		
						+ "		<input type='button' class='btn btn-primary' value='예약취소'/>		"	    		
						;
		
		return chatMsgBarBody(map,true,product_btn,user_btn);
	}
	public String sellerResHtml(Map<String,Object> map) {
		String product_btn = 
				"<input type='button' class='btn btn-primary' value='인수 분쟁 신고'/>";	
		
		
		String user_btn = 
				"		<input type='button' class='btn btn-dark' value='신고하기'/>		"	    		
						+ "		<input type='button' class='btn btn-primary' value='예약취소'/>		"	    		
						;
		
		return chatMsgBarBody(map,true,product_btn,user_btn);
	}
	// =================== 예약중 끝
	
	// 결제 대기중
	// ** 페이 사용중일때 페이로 결제 후 넘어오는 화면
	
	public String buyerWaitTakeHtml(Map<String,Object> map) {
		
		String product_btn = "";
		if(map.get("product_payment").equals("안전페이")
				|| map.get("product_payment").equals("안전페이,직거래")) {
			product_btn = 
					"<input type='button' class='btn btn-dark' value='결제취소 요청'/>"	
							+ "<input type='button' class='btn btn-primary' value='인수하기'/>";	
		}
		else {
			product_btn = 
					"<input type='button' class='btn btn-primary' value='인수하기'/>";	
		}
		String user_btn = 
				"		<input type='button' class='btn btn-dark' value='신고하기'/>		"	    		
						+ "		<input type='button' class='btn btn-primary' value='나가기'/>		"	    		
						;
		
		return chatMsgBarBody(map,true,product_btn,user_btn);
	}
	public String sellerWaitTakeHtml(Map<String,Object> map) {
		String product_btn = "";
		if(map.get("product_payment").equals("안전페이")
				|| map.get("product_payment").equals("안전페이,직거래")) {
			product_btn = 
					"<input type='button' class='btn btn-primary' value='결제취소 허용'/>"
							+"<input type='button' class='btn btn-primary' value='인수 분쟁 신고'/>"
							;
		}
		else {
			product_btn = 
					"<input type='button' class='btn btn-primary' value='인수 분쟁 신고'/>";	
		}
		
		String user_btn = 
				"		<input type='button' class='btn btn-dark' value='신고하기'/>		"	    		
						+ "		<input type='button' class='btn btn-primary' value='나가기'/>		"	    		
						;
		
		return chatMsgBarBody(map,true,product_btn,user_btn);
	}
	
	// ============ 결제 대기중 끝
	
	// 겨래 완료
	
	public String buyerCompleteHtml(Map<String,Object> map) {
		
		String product_btn = 
				"<input type='button' class='btn btn-primary' value='인수 분쟁 신고'/>";	
		
		String user_btn = 
				"		<input type='button' class='btn btn-dark' value='신고하기'/>		"	    		
						+ "		<input type='button' class='btn btn-primary' value='나가기'/>		"	    		
						;
		
		return chatMsgBarBody(map,true,product_btn,user_btn);
	}
	public String sellerCompleteHtml(Map<String,Object> map) {
		String product_btn = 
				"<input type='button' class='btn btn-primary' value='인수 분쟁 신고'/>";	
		
		String user_btn = 
				"		<input type='button' class='btn btn-dark' value='신고하기'/>		"	    		
						+ "		<input type='button' class='btn btn-primary' value='나가기'/>		"	    		
						;
		
		return chatMsgBarBody(map,true,product_btn,user_btn);
	}
	
}
