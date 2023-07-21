<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>예약 취소</title>
	<link href="${pageContext.request.contextPath }/resources/css/junggo/common.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath }/resources/css/junggo/res_cancel.css" rel="styleSheet">
<%-- 	<link href="${pageContext.request.contextPath }/resources/css/inc/top.css" rel="styleSheet"> --%>
<%-- 	<link href="${pageContext.request.contextPath }/resources/css/inc/footer.css" rel="styleSheet"> --%>

	<script src="${pageContext.request.contextPath }/resources/js/inc/jquery-3.7.0.js"></script>
</head>
<body>
	<header>
<%-- 		 <jsp:include page="../../inc/top1.jsp"></jsp:include> --%>
	</header>
	<section id="sec_con" class="inr com_cont">
		<div class="res_com_txt" align="center">
			<img alt="" src = "${pageContext.request.contextPath }/resources/img/junggo/no.png" width ="70px"/>
	  		<h1>예약이 취소 되었습니다.</h1>
	  		<p>예약 내용을 확인해주세요.</p>
		</div>
		
			
		<div class="res_info_wrapper">
		
			<div class="res_info com_wrap">
				<h3>예약 정보</h3>
				<ul>
					<li>
						<em>거래 번호</em>
						<span>1090293019309120</span>
					</li>
					<li>
						<em>판매자</em>
						<span>꾸미꾸미꾸</span>
					</li>
					<li>
						<em>구매자</em>
						<span>옷산사람1</span>
					</li>
					<li>
						<em>거래글 제목</em>
						<span>
							블랙야크 남성 기모바지 (33)
						</span>
					</li> 
				</ul>
			</div>
		  
<!-- 		  	<hr class="com_line"> -->
		
<!-- 			<div class="payment_info com_wrap"> -->
			
<!-- 			</div> -->
			<div class="finish_btn" align="center">
				<a href="${pageContext.request.contextPath }"><button>메인으로</button></a>
				<a href="${pageContext.request.contextPath }/MemberRes"><button>마이리스트 거래 내역 조회</button></a>
			</div>
			
		</div>
	</section>
	
	<footer>
<%-- 	<jsp:include page="../../inc/footer.jsp"></jsp:include>  --%>
	</footer>


</body>
</html>