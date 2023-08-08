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
		
		if((int)jProduct.get("user_idx") != (int)jProduct.get("mem_idx")) {			
			if(jProduct.get("favorite_check").equals("Y")) {
				dibBtnStr = 
				"					<input type='button'  class='UnFavorite_btn' value='💔 " + jProduct.get("dibs_count") + "'>";
			}
			else {
				dibBtnStr = 
				"					<input type='button' class='favorite_btn' value='♥ " + jProduct.get("dibs_count") + "'/>		";
			}
		}
		else {
			dibBtnStr =  "			<button type='button'  class='delete_btn' onclick='deleteConfirmPD()'>삭제하기</button>";
		}
		
		
		dibStr = 
				"	<input type='hidden' name='product_idx' id='product_idx' value='" + jProduct.get("product_idx") + "'/>"
				+ "	<input type='hidden' name='favorite_check' id='favorite_check' value='"  + jProduct.get("favorite_check") +  "'/>"
				+ "	<input type='hidden' name='mem_id' id='mem_id' value='" + jProduct.get("mem_id") + "'/>"
				+ "	<input type='hidden' name='mem_idx' id='mem_idx' value='" + jProduct.get("mem_idx") + "'/>"
				+ "	<!-- buyier_idx 미접속시 -1으로 받아오게끔 하기-->"
				+ " <input type='hidden' name='buyier_idx' id='buyier_idx' value='"  + jProduct.get("user_idx") +  "'/>"
				+ "	<!-- buyier_idx 미접속시 -1으로 받아오게끔 하기-->						"
				+ dibBtnStr
				;
		
		htmlStr = 
				"<div class='col mt-2'>"
			     + "<div class='itemWrap' onclick='location.href=\"./productDetail?product_idx=" + jProduct.get("product_idx") + "\"'>"
			     + "  <div class='imgWrap'>"
			     + "    <img class='junggoImg' src='" + localURL + jProduct.get("image_path") + "/" + jProduct.get("image1") + "' />"
			     + "  </div>"
			     + "  <div class='itemSimpleInfoWrap'>"
			     + "    <ul class='itemSimpleInfo'>"
			     + "      <li>"
			     + "        <p class='itemTitle'>" + jProduct.get("product_title") +"</p>"
			     + "      </li>"
			     + "      <li>"
			     + "        <p class='itemPrice'>" 
			     + 			Integer.toString((Integer)jProduct.get("product_price")).replaceAll("\\B(?=(\\d{3})+(?!\\d))", ",") + "원</p>"
			     + "      </li>"
			     + "      <li>"
			     + "        <p class='itemPayment'>" + jProduct.get("product_payment") + "</p>"
			     + "      </li>"
			     + "      <li>"
//			     + 			jProduct.get("product_date")
			     + "      </li>"
			     + "    </ul>"
			     + "    <div class='itemSimpleInfoBtn'>"
//			     + "      <input class='btn btn-primary' type='button' value='찜하기' onclick='event.stopPropagation(); location.href=\"#\";' />"
			     + dibStr
				 + "    </div>"
			     + "  </div>"
			     + "</div>"
			     + "</div>";
		

		
		return htmlStr;
	}
}
