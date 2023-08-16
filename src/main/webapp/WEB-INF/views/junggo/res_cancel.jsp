<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>예약 취소</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/common/common.css">
	<link href="${pageContext.request.contextPath }/resources/css/junggo/res_cancel.css" rel="styleSheet">
<%-- 	<link href="${pageContext.request.contextPath }/resources/css/inc/top.css" rel="styleSheet"> --%>
<%-- 	<link href="${pageContext.request.contextPath }/resources/css/inc/footer.css" rel="styleSheet"> --%>

	<script src="${pageContext.request.contextPath }/resources/js/inc/jquery-3.7.0.js"></script>
</head>
<body>
	<header>
<%-- 		 <jsp:include page="../../inc/top1.jsp"></jsp:include> --%>
	</header>
<div id="main_cont">	
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
						<em>거래 항목</em>
						<c:choose>
								<c:when test="${jungGoNoh.product_selector == 0}">
									<span>중고거래</span>
								</c:when>
								<c:otherwise>
									<c:choose>
										<c:when test="${jungGoNoh.product_selector == 1}">
											<span>경매</span>
										</c:when>
										<c:otherwise>
												<span>크림</span>		
										</c:otherwise>
									</c:choose>
								</c:otherwise>
							</c:choose>
					</li> 
					<li>
						<em>판매자</em>
						<span>${jungGoNoh.mem_nickname}</span>
					</li>
					<li>
						<em>구매자</em>
						<span>${jungGoNoh.buyier_nickname}</span>
					</li>
					<li>
						<em>거래글 제목</em>
						<span>
							${jungGoNoh.product_title}
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
</div>
	<footer>
<%-- 	<jsp:include page="../../inc/footer.jsp"></jsp:include>  --%>
	</footer>


</body>
</html>