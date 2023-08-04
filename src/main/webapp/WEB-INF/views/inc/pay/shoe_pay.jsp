<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>shoePay</title>
<!-- 부트스트랩 -->
<link href="${pageContext.request.contextPath }/resources/css/etc/bootstrap.min.css" rel="stylesheet">
<script	src="${pageContext.request.contextPath }/resources/js/etc/bootstrap.bundle.min.js"></script>
<link href="${pageContext.request.contextPath }/resources/css/etc/common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/resources/css/inc/pay/pay_form.css" rel="stylesheet">
<%-- <link href="${pageContext.request.contextPath }/resources/css/inc/top.css" rel="styleSheet"> --%>
<%-- <link href="${pageContext.request.contextPath }/resources/css/inc/footer.css" rel="styleSheet"> --%>
<!-- jQuery -->
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<!-- 아임포트 -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.8.js"></script>

</head>
<body>
	
	<fieldset class="img_sec_wrap">
		<div class="txt_sec_p">
			<p>
				<span>계정 포인트 잔액</span>
				<span class="productName">${member.charge_point}</span>
			</p>
			<p class="pay_total_p">
				<span>상품 가격</span>
				<span><b id="productPrice">${map.product_price}</b>원</span>
			</p>
			<p>
				<span>결제 후 잔액</span>
				<span class="resTotalAmount">
					<c:choose>
						<c:when test="${member.charge_point < map.product_price }">
							잔액이 부족합니다 !!
						</c:when>
						<c:otherwise>
							${member.charge_point - map.product_price }
						</c:otherwise>
					</c:choose>
				</span>
			</p>
		</div>
		<div class="container">
			<div class="row">
				<input class="res_p"  type="button" value="취소" >
				<input class="res_p"  type="button" value="충전" >
				<c:if test="${member.charge_point >= map.product_price }">				
					<input class="res_p"  type="button" value="결제" >
				</c:if>
			</div>
		</div>
	</fieldset>
</body>
</html>