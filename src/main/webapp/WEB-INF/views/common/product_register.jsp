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
	<title>해당 품목 상세보기</title>
	<link href="${pageContext.request.contextPath}/resources/css/junggo/common.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/resources/css/junggo/product_register.css" rel="stylesheet">
<%-- 	<link href="${pageContext.request.contextPath}/resources/css/inc/top.css" rel="styleSheet"> --%>
<%-- 	<link href="${pageContext.request.contextPath}/resources/css/inc/footer.css" rel="styleSheet"> --%>
	<link href="${pageContext.request.contextPath }/resources/css/etc/bootstrap.min.css" rel="stylesheet">
	<script	src="${pageContext.request.contextPath }/resources/js/etc/bootstrap.bundle.min.js"></script>
	<script	src="${pageContext.request.contextPath }/resources/js/common/product_register.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.0.js"></script>
<%--주소 관련 코드--%>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	
	<script type="text/javascript">
		function sellectBrand(selBrand){
     	   $(".brand").val(selBrand);
   		 }
	</script>
	<script type="text/javascript">
		$(function() {
			$("input[name=method]").on("change",function() {
				location.href = "RegisterForm?page="+$(this).val()+"_register.jsp";
			}) 
		})
	</script>
</head>
<body>
	<header>
	<%--top 탑 활성화시 css도 살려야함--%>
<%-- <jsp:include page="../../../inc/top1.jsp"></jsp:include> --%>
	</header>
	<%--입력하지 않은 자료 보낼 때--%>
<%-- 		<input type="hidden" name="car_model" value="${map.car_info.car_model}"/> --%>
	<main>
		<div id="MethodBox">
			<input type="radio" name="method" value="junggo">중고
			<input type="radio" name="method" value="auction">경매
		</div>
		<section id="sec_con" class="register_view inr">
			<jsp:include page="${param.page }" />
		</section>
	</main>
	<footer>
	<%--footer 풋터 활성화 시 css도 살려야함--%>
<%-- 		<jsp:include page="../../../inc/footer.jsp"></jsp:include> --%>
	</footer>
</body>
</html>




