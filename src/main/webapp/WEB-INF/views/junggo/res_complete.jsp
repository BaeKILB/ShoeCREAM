<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>예약 완료</title>
	<link href="${pageContext.request.contextPath }/resources/css/junggo/common.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath }/resources/css/junggo/trade_complete.css" rel="styleSheet">
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
			<img alt="" src = "${pageContext.request.contextPath }/resources/img/junggo/yes.png" width ="70px"/>
	  		<h1>예약이 완료 되었습니다.</h1>
	  		<p>예약 내용을 확인해주세요.</p>
		</div>
		
			
		<div class="res_info_wrapper">
		
			<div class="res_info com_wrap">
				<h3>예약 정보</h3>
				<ul>
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
					<li>
						<em>거래 방식</em>
						<span>슈크림페이</span>
					</li> 
					<li>
						<em>총 결제 금액</em>
						<span>25,000원</span>
					</li> 
				</ul>
			</div>
		  
<!-- 		  	<hr class="com_line"> -->
		
<!-- 			<div class="payment_info com_wrap"> -->
<!-- 				<h3>결제 정보</h3> -->
<!-- 				<ul> -->
<!-- 					<li> -->
<!-- 						<em>결제 수단</em> -->
<!-- 						<span> -->
<!-- 							슈크림페이 포인트 -->
<!-- 						</span> -->
<!-- 					</li> -->
<!-- 					<li> -->
<!-- 						<em>결제 금액</em> -->
<!-- 						<span>25,000원</span> -->
<!-- 					</li> -->
<!-- 					<li> -->
<!-- 						<em>결제 확인 일시</em> -->
<!-- 						<span>2023.07.18 11:13</span> -->
<!-- 					</li> -->
					
<!-- 				</ul> -->
<!-- 			</div> -->
			<div class="finish_btn" align="center">
				<a href="${pageContext.request.contextPath }"><button>메인으로</button></a>
				<a href="${pageContext.request.contextPath }/MemberRes"><button>마이리스트 거래 내역 조회</button></a>
				<a href="${pageContext.request.contextPath }/MemberRes"><button>해당 1:1대화창으로 이동</button></a>
			</div>
			
		</div>
	</section>
	
	<footer>
<%-- 	<jsp:include page="../../inc/footer.jsp"></jsp:include>  --%>
	</footer>


</body>
</html>