<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>  
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%--최신본 인증!--%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>상품 등록</title>
	<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>
	<script	src="${pageContext.request.contextPath }/resources/js/etc/bootstrap.bundle.min.js"></script>
	<script	src="${pageContext.request.contextPath }/resources/js/etc/jquery.datetimepicker.full.min.js"></script>
	<script	src="${pageContext.request.contextPath }/resources/js/common/product_register.js"></script>
<%--주소 관련 코드--%>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	
	<link href="${pageContext.request.contextPath }/resources/css/common/product_register.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath }/resources/css/etc/bootstrap.min.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath }/resources/css/etc/jquery.datetimepicker.min.css" rel="stylesheet">
<%-- 	<link href="${pageContext.request.contextPath}/resources/css/inc/top.css" rel="styleSheet"> --%>
<%-- 	<link href="${pageContext.request.contextPath}/resources/css/inc/footer.css" rel="styleSheet"> --%>
</head>
<body id="main_cont">
	
	<nav>
		<jsp:include page="../inc_ex/header.jsp" />
	</nav>
	<%--입력하지 않은 자료 보낼 때--%>
<%-- 		<input type="hidden" name="car_model" value="${map.car_info.car_model}"/> --%>
	<main class="registerWrap" >
		<article class="registerForm">
			<div class="registerTitle">
				<h3>상품 등록</h3>
			</div>
			<div id="MethodBox">
				<span class="methodSpan">
					<input type="radio" class="btn-check" name="methodSpan" id="option1" value="junggo" >
					<label class="btn btn-outline-dark" for="option1">중고</label>
				</span>
				<span class="methodSpan">
					<input type="radio" class="btn-check" name="methodSpan" id="option2" value="auction" >
					<label class="btn btn-outline-dark" for="option2">경매</label>
				</span>
			</div>
			<section id="sec_con" class="register_view inr">
				<c:if test="${!empty param.page }">
					<jsp:include page="${param.page }_register.jsp" />
				</c:if>
			</section>
		</article>
	</main>
	<footer>
		<jsp:include page="../inc_ex/footer.jsp" />
	</footer>
</body>
</html>




