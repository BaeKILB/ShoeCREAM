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
	<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>
	<script	src="${pageContext.request.contextPath }/resources/js/etc/bootstrap.bundle.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.10.0/js/bootstrap-datepicker.min.js" integrity="sha512-LsnSViqQyaXpD4mBBdRYeP6sRwJiJveh2ZIbW41EBrNmKxgr/LFZIiWT6yr+nycvhvauz8c2nYMhrP80YhG7Cw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.10.0/locales/bootstrap-datepicker.ko.min.js" integrity="sha512-L4qpL1ZotXZLLe8Oo0ZyHrj/SweV7CieswUODAAPN/tnqN3PA1P+4qPu5vIryNor6HQ5o22NujIcAZIfyVXwbQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<script	src="${pageContext.request.contextPath }/resources/js/common/product_register.js"></script>
<%--주소 관련 코드--%>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	
	<link href="${pageContext.request.contextPath }/resources/css/junggo/common.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath }/resources/css/junggo/product_register.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath }/resources/css/etc/bootstrap.min.css" rel="stylesheet">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.10.0/css/bootstrap-datepicker.min.css" integrity="sha512-34s5cpvaNG3BknEWSuOncX28vz97bRI59UnVtEEpFX536A7BtZSJHsDyFoCl8S7Dt2TPzcrCEoHBGeM4SUBDBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<%-- 	<link href="${pageContext.request.contextPath}/resources/css/inc/top.css" rel="styleSheet"> --%>
<%-- 	<link href="${pageContext.request.contextPath}/resources/css/inc/footer.css" rel="styleSheet"> --%>
	
	<script type="text/javascript">
		$(function() {
			$(".methodSpan").on("click",function() {
				let page = $(this).children('input').val();
				location.href = "RegisterForm?page="+page+"_register.jsp";
			});
			
			$("#datetimepicker6").datepicker();
			
			$("#datetimepicker7").datepicker({
				useCurrent: false //Important! See issue #1075
			});
			
			$("#datetimepicker6").on("dp.change", function (e) {
				$("#datetimepicker7").data("DateTimePicker").minDate(e.date);
			});
			
			$("#datetimepicker7").on("dp.change", function (e) {
				$("#datetimepicker6").data("DateTimePicker").maxDate(e.date);
			});
		});
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
			<span class="methodSpan"><input type="hidden" value="junggo">중고</span>
			<span class="methodSpan"><input type="hidden" value="auction">경매</span>
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




