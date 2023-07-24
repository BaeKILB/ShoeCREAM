<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- 자바스크립트 파일 -->
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/auction/auctionDetail.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>

<!-- css파일  -->
<link href="${pageContext.request.contextPath }/resources/css/admin/common.css" rel="stylesheet" type="text/css">

</head>
<body>
<h1>경매 </h1>
<!-- 	좌측 상품 사진 -->
	<img src="#-el">
	<h5>카테고리 우측 첫번째줄 -el</h5>
	<h3>제품 이름-el</h3><img alt="하트 아이콘(찜)" src="#" >
	<h2>현재가격 : 50,000원-el</h2><h2>시작가격 : 5,000원-el</h2>
	<h1>즉시구매가 : 100,000원-el</h1>
	
	<hr>
	
	<h4>입찰수 n회 (총 판매수량 : n개)</h4> <a href="#">경매기록</a>
	<h4>남은시간;</h4>
	<input type="button" value="입찰-팝업" onclick="tenderPopup();">	
	<input type="button" value="즉시구매-팝업" onclick="buyingPopup();">	
	
	<hr>
	<h1>연관상품</h1>
	<hr>
	<h3>상품정보</h3>
	<p>상품정보 단락 </p>
	
	<h3>판매자정보</h3>
	<h3>판매자 후기</h3>
</body>
</html>