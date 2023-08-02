<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>즉시구매 팝업</h1>

	<h3>입찰 상품</h3>
	<hr>
	<form action="buyingPro" method="post" >
		<input type="hidden" value="${auction.auction_idx }" name="auction_idx">
		<h4>상품명 : ${auction.auction_title }</h4>
		<h4>즉시 구매가 :${auction.auc_buy_instantly } 원</h4>
		<h4>구매 수량 : 1 개</h4>
		<h4>합계 : ${auction.auc_buy_instantly } 원</h4>
		<input type="hidden" name="auc_buy_instantly" value="${auction.auc_buy_instantly }">
		<input type="submit" value="결제하기">
	</form>
</body>
</html>