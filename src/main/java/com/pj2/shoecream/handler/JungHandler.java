package com.pj2.shoecream.handler;

import java.util.Map;

import org.springframework.stereotype.Component;

import com.pj2.shoecream.vo.JungProductVO;

@Component
public class JungHandler {
	public String makeProductHtml(Map<String,Object> jProduct, String localURL) {
		String htmlStr = "";
		
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
			     + "    </div>"
			     + "  </div>"
			     + "</div>"
			     + "</div>";
		
		
		return htmlStr;
	}
}
