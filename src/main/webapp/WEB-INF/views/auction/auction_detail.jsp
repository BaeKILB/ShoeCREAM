<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- 자바스크립트 파일 -->
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/auction/auction_detail.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>

<!-- css파일  -->
<link href="${pageContext.request.contextPath }/resources/css/admin/common.css" rel="stylesheet" type="text/css">

<!-- 테스트용 css -->
<style type="text/css">
/* Slideshow container */
.slideshow-container {
  max-width: 1000px;
  position: relative;
  margin: auto;
}

/* Hide the images by default */
.mySlides {
  display: none;
}

/* Next & previous buttons */
.prev, .next {
  cursor: pointer;
  position: absolute;
  top: 50%;
  width: auto;
  margin-top: -22px;
  padding: 16px;
  color: white;
  font-weight: bold;
  font-size: 18px;
  transition: 0.6s ease;
  border-radius: 0 3px 3px 0;
  user-select: none;
}

/* Position the "next button" to the right */
.next {
  right: 0;
  border-radius: 3px 0 0 3px;
}

/* On hover, add a black background color with a little bit see-through */
.prev:hover, .next:hover {
  background-color: rgba(0,0,0,0.8);
}


/* The dots/bullets/indicators */
.dot {
  cursor: pointer;
  height: 15px;
  width: 15px;
  margin: 0 2px;
  background-color: #bbb;
  border-radius: 50%;
  display: inline-block;
  transition: background-color 0.6s ease;
}

.active, .dot:hover {
  background-color: #717171;
}

/* Fading animation */
.fade {
  animation-name: fade;
  animation-duration: 1.5s;
}

@keyframes fade {
  from {opacity: .4}
  to {opacity: 1}
}

</style>
</head>
<body>
<h1>경매 </h1>

<!-- 가지고 올 정보 
	from 공통테이블
	1. 카테고리 대 중 소 
	2. 제품명
	3. 상품코드
	
	
	from 옥션테이블
	1. 현재가격 경매테이블에서 max가격으로 bid_price (bid_list Table)
	2. 시작가격 auc_start_price
	5. 즉시구매가 auc_buy_instantly
	3. 입찰수 bid_date 로 count하나? n회 
	4. 경매 마감일 (남은시간)
	
	
-->

<!-- 	좌측 상품 사진 옆으로 넘기는 형태 -->
	<!-- Slideshow container -->
	<div class="slideshow-container">
	
	  <!-- Full-width images with number and caption text -->
	  <div class="mySlides fade">
	    <img src="${pageContext.request.contextPath }/resources/img/auction/img1.jpg" style="width:100%">
	  </div>
	
	  <div class="mySlides fade">
	    <img src="${pageContext.request.contextPath }/resources/img/auction/img2.jpg" style="width:100%">
	  </div>
	
	  <div class="mySlides fade">
	    <img src="${pageContext.request.contextPath }/resources/img/auction/img3.jpg" style="width:100%">
	  </div>
	  
	  <div class="mySlides fade">
	    <img src="${pageContext.request.contextPath }/resources/img/auction/img4.jpg" style="width:100%">
	  </div>
	
	  <!-- Next and previous buttons -->
	  <a class="prev" onclick="plusSlides(-1)">&#10094;</a>
	  <a class="next" onclick="plusSlides(1)">&#10095;</a>
	</div>
	<br>
	
	<!-- The dots/circles -->
	<div style="text-align:center">
	  <span class="dot" onclick="currentSlide(1)"></span>
	  <span class="dot" onclick="currentSlide(2)"></span>
	  <span class="dot" onclick="currentSlide(3)"></span>
	  <span class="dot" onclick="currentSlide(4)"></span>
	</div>
	
	<h5>카테고리 우측 첫번째줄 -el</h5>
	<h3>제품 이름-el</h3><img alt="하트 아이콘(찜)" src="#" >
	<h2>현재가격 : 50,000원-el - max로 가져오기</h2><h2>시작가격 : 5,000원-el</h2>
	<h1>즉시구매가 : 100,000원-el</h1>
	
	<hr>
	
	<h4>입찰수 n회 (총 판매수량 : n개) el</h4> <a href="#">경매기록</a>
	<h4>남은시간; db에서 어떻게 받아올지 봐야함</h4>
	
	<input type="button" value="입찰-팝업" onclick="tenderPopup();">	
	<input type="button" value="즉시구매-팝업" onclick="buyingPopup();">
		
	<c:if test="${not empty sessionScope.sId }">
		<input type="button" value="수정" onclick="location.href='BoardModifyForm?board_num=${board.board_num}&pageNum=${param.pageNum}'">
		<%-- 삭제 버튼 클릭 시 "삭제하시겠습니까?" 메세지 출력 후 확인 버튼 누르면 삭제 서블릿 요청 --%>
		<input type="button" value="삭제" onclick="confirmDelete()">
	</c:if>
	<hr>
	<h1>연관상품</h1>
	<hr>
	<h3>상품정보</h3>
	<p>상품정보 단락 </p>
	
	<h3>판매자정보</h3>
	<h3>판매자 후기</h3>
</body>
</html>