<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- <!DOCTYPE html> -->
<!-- <html> -->
<!-- <head> -->
<!-- <meta charset="UTF-8"> -->
<!-- <title>Insert title here</title> -->
<!-- </head> -->
<!-- <body> -->
      <div class="itemWrap" onclick="location.href='./'">
        <div class="imgWrap">
          <img class="junggoImg" src="src/junggo.jpg" />
        </div>
        <div class="itemSimpleInfoWrap">
          <ul class="itemSimpleInfo">
            <li>
              <p class="itemTitle">상품이름</p>
            </li>
            <li>
              <p class="itemPrice">99,999원</p>
            </li>
            <li>
              <p class="itemCategory">카테고리 명</p>
            </li>
            <li>
              <p class="itemPayment">안전페이</p>
            </li>
          </ul>
          <div class="itemSimpleInfoBtn">
            <input class="btn btn-primary" type="button" value="찜하기" onclick="event.stopPropagation(); location.href='#';" />
          </div>
        </div>
      </div>
<!-- </body> -->
<!-- </html> -->