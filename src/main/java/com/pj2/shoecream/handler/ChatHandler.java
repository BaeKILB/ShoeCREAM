package com.pj2.shoecream.handler;

import java.util.Map;

import org.springframework.stereotype.Component;

@Component
public class ChatHandler {
		
	// ============ 채팅 상단 바에 ajax 로 반환할 html
	

	
	// 0. 기본 틀
	public String chatMsgBarBody(Map<String,Object> map ,boolean isBuyer
			, String product_btn, String user_btn) {
		
		// 구매자 판매자에 따라 다르게 표기
		String userStr = "";
		
		// 만약 지금 메시지 상대방이 구매자, 판매자 일때 유저 레이아웃 배치
		if(!isBuyer) {			
			userStr = 
					"	<section>"
					+ "<a "
					+ " href='social/"
					+ map.get("mem_buyer_idx")
					+ "'>"
					+ "		<img src='" + map.get("localURL") + "/resources/upload/profile/" + map.get("mem_buyer_img") + "' "
							+ " alt='' "
							+ " href='social/"
							+ map.get("mem_buyer_idx")
							+ "'>"
					+ "</a>"
					+ "	</section>"
					+ "	<section>"
					+ "		<p class='nickname'>" + map.get("mem_buyer_nickname") + "</p>"
					+ "		<p class='follow'>" + map.get("follow") + " 팔로우</p>"
					+ "	</section>"
					+ "	<section>"
					+	user_btn
					+ "	</section>";
		}
		else {
			userStr = 
					"	<section>"
							+"<a "
							+ " href='social/"
							+ map.get("mem_seller_idx")
							+ "'>"
							+ "		<img src='" + map.get("localURL") + "/resources/upload/profile/" + map.get("mem_seller_img") + "' "
							+ " alt='' "
							+ " href='social/"
							+ map.get("mem_seller_idx")
							+ "'>"
							+ "</a>"
							+ "	</section>"
							+ "	<section>"
							+ "		<p class='nickname'>" + map.get("mem_seller_nickname") + "</p>"
							+ "		<p class='follow'>" + map.get("follow") + " 팔로우</p>"
							+ "	</section>"
							+ "	<section>"
							+	user_btn
							+ "	</section>";
			
		}
		
		String htmlStr = 
				"<div class='product_info_wrap'>"
						+ "	<section>"
						+ "<a"
						+ " href='productDetail?product_idx="
						+ map.get("product_idx")
						+ "'>"
						+ "		<img src='"
						+	map.get("localURL")
						+ 		map.get("image_path")  
						+ 		"/"
						+		map.get("image1")  
						+ " ' alt=''>"
						+ "</a>"
						+ "	</section>"
						+ "	<section>"
						+ "		<p class='productTitle'>" + map.get("product_title") + "</p>"
						+ "		<p class='productPrice'>" + map.get("product_price") + "원</p>"
						+ "	</section>"
						+ "	<section>"
						+ "		<p><span>" + map.get("product_sell_status") + "</span></p>"
						+ "		<p><span>" + map.get("product_status") + "</span></p>"
						+ "	</section>"
						+ "	<section class='productBtn'>"
						+ 		product_btn				    		
						+ "	</section>"
						+ "</div>"
						+ "<div class='chat_member_wrap'>"
						+ 	userStr
						+ "</div>"
					+ "</div>";
		
		return htmlStr;
	}
	
	
	// 1. 대기중 상황 ================================
	public String buyerWaitingHtml(Map<String,Object> map) {
		String product_btn = 
				"<input type='button' class='btn btn-primary' value='예약진행하기' onclick='startRes()'/>";
		
		String user_btn = 
				"		<input type='button' class='btn btn-dark' value='신고하기' onclick='registReport(" + map.get("registReport") + ")'/>		"	    		
				+ "		<input type='button' class='btn btn-primary' value='나가기' onclick='chatRoomOut(0)'/>		"	    		
				;
	
		return chatMsgBarBody(map,true,product_btn,user_btn);
	}
	public String sellerWaitingHtml(Map<String,Object> map) {
		String product_btn = 
				"";
		
		String user_btn = 
				"		<input type='button' class='btn btn-dark' value='신고하기' onclick='registReport(" + map.get("registReport") + ")'/>		"	    		
				+ "		<input type='button' class='btn btn-primary' value='나가기' onclick='chatRoomOut(0)'/>		"	    		
				;
	
		return chatMsgBarBody(map,false,product_btn,user_btn);
	}
	
	//================ 대기중 끝
	
	// 2. 예약중 ==================================
	
	public String buyerResHtml(Map<String,Object> map) {
		
		String product_btn = "";
		if(map.get("product_payment").equals("안전페이")) {
			product_btn = "<input type='button' class='btn btn-primary' value='결제하기'"
					+ "onclick='location.href=\"JunggoPay?product_idx=" + map.get("product_idx") + "&chat_room_idx=" + map.get("chat_room_idx") + "\"' />";	
		}
		else if(map.get("product_payment").equals("안전페이,직거래")) {
			product_btn = "<input type='button' class='btn btn-primary' value='결제하기'"
					+ "onclick='location.href=\"JunggoPay?product_idx=" + map.get("product_idx") + "&chat_room_idx=" + map.get("chat_room_idx") + "\"' />"
					+ "<input type='button' class='btn btn-primary' value='거래완료' onclick='transComplete()'/>";	
		}
		else {
			product_btn = 
					"<input type='button' class='btn btn-primary' value='거래완료' onclick='transComplete()'/>";	
		}
		String user_btn = 
				"		<input type='button' class='btn btn-dark' value='신고하기' onclick='registReport(" + map.get("registReport") + ")'/>		"	    		
						+ "		<input type='button' class='btn btn-primary' value='예약취소'  onclick='chatRoomOut(1)'/>		"	    		
						;
		
		return chatMsgBarBody(map,true,product_btn,user_btn);
	}
	public String sellerResHtml(Map<String,Object> map) {
		String product_btn = 
				"<input type='button' class='btn btn-primary' value='인수 분쟁 신고'/>";	
		
		
		String user_btn = 
				"		<input type='button' class='btn btn-dark' value='신고하기' onclick='registReport(" + map.get("registReport") + ")'/>		"	    		
						+ "		<input type='button' class='btn btn-primary' value='예약취소' onclick='chatRoomOut(1)' />		"	    		
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
					"<input type='button' class='btn btn-dark' value='결제취소 요청' onclick='sandCancelPay();'/>"	
							+ "<input type='button' class='btn btn-primary' value='거래완료' onclick='transComplete()'/>";	
		}
		else {
			product_btn = 
					"<input type='button' class='btn btn-primary' value='거래완료' onclick='transComplete()'/>";	
		}
		String user_btn = 
				"		<input type='button' class='btn btn-dark' value='신고하기' onclick='registReport(" + map.get("registReport") + ")'/>		"	    		
						+ "		<input type='button' class='btn btn-primary' value='나가기' onclick='chatRoomOut(2)' />		"	    		
						;
		
		return chatMsgBarBody(map,true,product_btn,user_btn);
	}
	public String sellerWaitTakeHtml(Map<String,Object> map) {
		String product_btn = "";
		if(map.get("product_payment").equals("안전페이")
				|| map.get("product_payment").equals("안전페이,직거래")) {
			product_btn = 
					"<input type='button' class='btn btn-primary' value='결제취소 허용' onclick='allowCancelPay()'/> "
					+		"<input type='button' class='btn btn-primary' value='인수 분쟁 신고'/>"
							;
		}
		else {
			product_btn = 
					"<input type='button' class='btn btn-primary' value='인수 분쟁 신고' onclick='registReport(" + map.get("registReport") + ")' />";	
		}
		
		String user_btn = 
				"		<input type='button' class='btn btn-dark' value='신고하기' onclick='registReport(" + map.get("registReport") + ")'/>		"	    		
						+ "		<input type='button' class='btn btn-primary' value='나가기' onclick='chatRoomOut(2)'/>		"	    		
						;
		
		return chatMsgBarBody(map,true,product_btn,user_btn);
	}
	
	// ============ 결제 대기중 끝
	
	// 겨래 완료
	
	public String buyerCompleteHtml(Map<String,Object> map) {
		
		String product_btn = 
				"<input type='button' class='btn btn-primary' value='인수 분쟁 신고' onclick='registReport(" + map.get("registReport") + ")'/>";	
		
		String user_btn = 
				"		<input type='button' class='btn btn-dark' value='신고하기' onclick='registReport(" + map.get("registReport") + ")'/>		"	    		
						+ "		<input type='button' class='btn btn-primary' value='나가기' onclick='chatRoomOut(0)'/>		"	    		
						;
		
		return chatMsgBarBody(map,true,product_btn,user_btn);
	}
	public String sellerCompleteHtml(Map<String,Object> map) {
		String product_btn = 
				"<input type='button' class='btn btn-primary' value='인수 분쟁 신고' onclick='registReport(" + map.get("registReport") + ")'/>";	
		
		String user_btn = 
				"		<input type='button' class='btn btn-dark' value='신고하기' onclick='registReport(" + map.get("registReport") + ")'/>		"	    		
						+ "		<input type='button' class='btn btn-primary' value='나가기' onclick='chatRoomOut(0)'/>		"	    		
						;
		
		return chatMsgBarBody(map,true,product_btn,user_btn);
	}
	
	

	
}
