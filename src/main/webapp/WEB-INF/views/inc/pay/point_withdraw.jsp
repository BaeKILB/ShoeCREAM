<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>슈크림 포인트 출금</title>
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

		</div>
		<form action="withdrawPointPro" method="post">
			<input type="radio" class="btn-check" name="point_amount" id="option1" value="5000" >
			<label class="btn btn-outline-dark" for="option1">5,000원</label>
			
			<input type="radio" class="btn-check" name="point_amount" id="option2" value="10000" >
			<label class="btn btn-outline-dark" for="option2">10,000원</label>
			
			<input type="radio" class="btn-check" name="point_amount" id="option3" value="50000" >
			<label class="btn btn-outline-dark" for="option3">50,000원</label>
			
			<input type="radio" class="btn-check" name="point_amount" id="option4" value="100000" >
			<label class="btn btn-outline-dark" for="option4">100,000원</label>
		

		
		<%-- 2.5.1. 출금이체 API 요청을 위한 폼 생성(PDF p74) --%>
		<%-- 계좌 에서 돈 빼서 관리자 계좌로 보낸 뒤
				해당 금액만큼 포인트 추가 --%>
		
		<%-- hidden 타입으로 은행명, 핀테크이용번호 전달 --%>
			<input type="hidden" name="bank_name" value="${account.bank_name }">
			<input type="hidden" name="fintech_use_num" value="${account.fintech_use_num }">
			<c:choose>
				<c:when test="${member.charge_point > 5000}">
					<input class="res_p" type="submit" value="포인트 출금 및 계좌이체">
				</c:when>
				<c:otherwise>
					<input class="res_p" disabled="disabled" value="포인트가 5000 이상일때 출금 가능합니다.">
				</c:otherwise>
			</c:choose>
		</form>
		<c:choose>
			<c:when test="${empty isPopup }">
				<input class="res_p"  type="button" value="취소"  onclick="history.back();">
			</c:when>
			<c:otherwise>
				<input class="res_p"  type="button" value="취소"  onclick="window.close();">
			</c:otherwise>
		</c:choose>
	</fieldset>
	
	<script src="${pageContext.request.contextPath }/resources/js/inc/pay/shoe_pay.js">
	</script>
	
	
</body>
</html>