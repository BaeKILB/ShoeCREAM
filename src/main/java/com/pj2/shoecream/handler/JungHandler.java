package com.pj2.shoecream.handler;

import org.springframework.stereotype.Component;

import com.pj2.shoecream.vo.JungProductVO;

@Component
public class JungHandler {
	public String makeProductHtml(JungProductVO jProduct) {
		String htmlStr = "";
		
		htmlStr = 
				"<div class='col mt-2'>"
			     + "<div class='itemWrap' onclick='location.href=\"./productDetail?product_idx=" + jProduct.getProduct_idx() + "\"'>"
			     + "  <div class='imgWrap'>"
			     + "    <img class='junggoImg' src='src/junggo.jpg' />"
			     + "  </div>"
			     + "  <div class='itemSimpleInfoWrap'>"
			     + "    <ul class='itemSimpleInfo'>"
			     + "      <li>"
			     + "        <p class='itemTitle'>" + jProduct.getProduct_title() +"</p>"
			     + "      </li>"
			     + "      <li>"
			     + "        <p class='itemPrice'>" 
			     + 			Integer.toString(jProduct.getProduct_price()).replaceAll("\\B(?=(\\d{3})+(?!\\d))", ",") + "원</p>"
			     + "      </li>"
			     + "      <li>"
			     + "        <p class='itemPayment'>" + jProduct.getProduct_payment() + "</p>"
			     + "      </li>"
			     + "      <li>"
			     + 			jProduct.getProduct_date()
			     + "      </li>"
			     + "    </ul>"
			     + "    <div class='itemSimpleInfoBtn'>"
			     + "      <input class='btn btn-primary' type='button' value='찜하기' onclick='event.stopPropagation(); location.href=\"#\";' />"
			     + "    </div>"
			     + "  </div>"
			     + "</div>"
			     + "</div>";
		
		
		return htmlStr;
	}
}
