package com.pj2.shoecream.handler;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Map;

import org.springframework.stereotype.Component;

import com.pj2.shoecream.vo.JungProductVO;

@Component
public class JungHandler {
	public String makeProductHtml(Map<String,Object> jProduct, String localURL) {
		
		// 날짜 기입 위한 객체
		LocalDateTime productDate = (LocalDateTime)jProduct.get("product_date");
		LocalDateTime nowDate = LocalDateTime.now();
		
		String htmlStr = "";
		String dibStr = "";
		
		String dibBtnStr = "";
		String href = "onclick='location.href=\"./productDetail?product_idx=" + jProduct.get("product_idx") + "\"'";
		
		String date = productDate.format(DateTimeFormatter.ofPattern("yy-MM-dd"));
		
		String title = (String)jProduct.get("product_title");
		

		// 만약 오늘 올린 글이라면 시간만 나오기
		if(productDate.getMonthValue() == nowDate.getMonthValue()
				&& productDate.getDayOfMonth() == nowDate.getDayOfMonth()
				&& productDate.getYear() == nowDate.getYear()) {
			date = productDate.format(DateTimeFormatter.ofPattern("HH:mm"));
		}
		
		// 제목이 11자 초과면 ... 처리
		if(title.length() > 11) {
			title = title.substring(0, 11) + "...";
		}
		
		if((int)jProduct.get("user_idx") != (int)jProduct.get("mem_idx")) {			
			if(jProduct.get("favorite_check").equals("Y")) {
				dibBtnStr = 
				"					<input type='submit' id='dibs_" + jProduct.get("product_idx") + "'  class='UnFavorite_btn' value='♥ " + jProduct.get("dibs_count") + "'>";
			}
			else {
				dibBtnStr = 
				"					<input type='submit' id='dibs_" + jProduct.get("product_idx") + "' class='favorite_btn' value='💔 " + jProduct.get("dibs_count") + "'/>		";
			}
		}
		else {
//			dibBtnStr =  "			<button type='button'  class='delete_btn' onclick='deleteConfirmPD()'>삭제하기</button>";
			dibBtnStr =  "";
		}
		
		
		dibStr = 
				"<form action=\"#\" method=\"get\" class='dibs_form' >"
				+ "	<input type='hidden' name='product_idx'  value='" + jProduct.get("product_idx") + "'/>"
				+ "	<input type='hidden' name='favorite_check' id='favorite_check_" + jProduct.get("product_idx")  + "' value='"  + jProduct.get("favorite_check") +  "'/>"
				+ "	<input type='hidden' name='mem_id' value='" + jProduct.get("mem_id") + "'/>"
				+ "	<input type='hidden' name='mem_idx' value='" + jProduct.get("mem_idx") + "'/>"
				+ "	<!-- buyier_idx 미접속시 -1으로 받아오게끔 하기-->"
				+ " <input type='hidden' name='buyier_idx' value='"  + jProduct.get("user_idx") +  "'/>"
				+ "	<!-- buyier_idx 미접속시 -1으로 받아오게끔 하기-->						"
				+ dibBtnStr
				+"</form>"
				;
		
		htmlStr = 
				"<div class='col-lg-3 col-md-4 col-6 mt-2'>"
		
//			     + "  <div class='imgWrap' " + href + " >"
//			     + "    <img class='card-img-top' src='" + localURL + jProduct.get("image_path") + "/" + jProduct.get("image1") + "' />"
//			     + "  </div>"
//			     + "  <div class='itemSimpleInfoWrap'>"
			     + "  <div class='pro_img'>"
				
				 + "    <img  src='" + localURL + jProduct.get("image_path") + "/" + jProduct.get("image1") + "' alt='productImage'/>"
				 + "  </div>"
			     + "  	<div class='pro_txt'>"			     
			     + "        <h4 class='itemTitle'>" + title +"</h4>"

//			     + "	<ul class='list-group list-group-flush itemSimpleInfo'>"
//			     + "      <li>"
//			     + "        <p class='itemTitle'>" + jProduct.get("product_title") +"</p>"
//			     + "      </li>"
//			     + "      <li class='list-group-item' " + href + ">"
			     + "        <p class='itemPrice'>" 
			     + 			Integer.toString((Integer)jProduct.get("product_price")).replaceAll("\\B(?=(\\d{3})+(?!\\d))", ",") + "원</p>"
//			     + "      </li>"
//			     + "      <li class='list-group-item' " + href + ">"
			     + "        <span class='itemPayment'>" + jProduct.get("product_payment") + "</span>"
//			     + "      </li>"
			     + "      <span " + href + ">"
			     + 			date
			     + "      </span>"
//			     + "      <li class='list-group-item'>"
//			     + 			dibStr
//			     + "      </li>"
//			     + "    </ul>"
//			     + "    <div class='itemSimpleInfoBtn'>"
//			     + "      <input class='btn btn-primary' type='button' value='찜하기' onclick='event.stopPropagation(); location.href=\"#\";' />"
//				 + "    </div>"
//			     + "  </div>"
			     + "    </div>"
			     + "</div>";
		

		
		return htmlStr;
	}
}
