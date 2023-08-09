package com.pj2.shoecream.handler;

import java.util.Map;

import org.springframework.stereotype.Component;

import com.pj2.shoecream.vo.JungProductVO;

@Component
public class JungHandler {
	public String makeProductHtml(Map<String,Object> jProduct, String localURL) {
		String htmlStr = "";
		String dibStr = "";
		
		String dibBtnStr = "";
		String href = "onclick='location.href=\"./productDetail?product_idx=" + jProduct.get("product_idx") + "\"'";
		
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
				"<div class='col-lg-3 col-md-4 col-6'>"
			     + "<div class='card itemWrap' >"
			     + "  <div class='imgWrap' " + href + " >"
			     + "    <img class='junggoImg' src='" + localURL + jProduct.get("image_path") + "/" + jProduct.get("image1") + "' />"
			     + "  </div>"
			     + "  <div class='itemSimpleInfoWrap'>"
			     + "  	<div class='card-body'>"			     
			     + "        <p class='card-title itemTitle'>" + jProduct.get("product_title") +"</p>"
			     + "    </div>"
			     + "	<ul class='list-group list-group-flush itemSimpleInfo'>"
//			     + "      <li>"
//			     + "        <p class='itemTitle'>" + jProduct.get("product_title") +"</p>"
//			     + "      </li>"
			     + "      <li class='list-group-item' " + href + ">"
			     + "        <p class='itemPrice'>" 
			     + 			Integer.toString((Integer)jProduct.get("product_price")).replaceAll("\\B(?=(\\d{3})+(?!\\d))", ",") + "원</p>"
			     + "      </li>"
			     + "      <li class='list-group-item' " + href + ">"
			     + "        <p class='itemPayment'>" + jProduct.get("product_payment") + "</p>"
			     + "      </li>"
			     + "      <li class='list-group-item' " + href + ">"
			     + 			jProduct.get("product_date")
			     + "      </li>"
			     + "      <li class='list-group-item'>"
			     + 			dibStr
			     + "      </li>"
			     + "    </ul>"
//			     + "    <div class='itemSimpleInfoBtn'>"
//			     + "      <input class='btn btn-primary' type='button' value='찜하기' onclick='event.stopPropagation(); location.href=\"#\";' />"
//				 + "    </div>"
			     + "  </div>"
			     + "</div>"
			     + "</div>";
		

		
		return htmlStr;
	}
}
