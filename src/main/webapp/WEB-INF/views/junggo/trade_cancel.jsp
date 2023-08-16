<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>거래 취소</title>
	
<%-- 	<link href="${pageContext.request.contextPath }/resources/css/inc/top.css" rel="styleSheet"> --%>
<%-- 	<link href="${pageContext.request.contextPath }/resources/css/inc/footer.css" rel="styleSheet"> --%>

	<script src="${pageContext.request.contextPath }/resources/js/inc/jquery-3.7.0.js"></script>
</head>
<body>
	<header>
		<jsp:include page="../inc_ex/header.jsp" />
		<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/common/common.css">
		<link href="${pageContext.request.contextPath }/resources/css/junggo/trade_complete.css" rel="styleSheet">
	</header>
<div id="main_cont">	
	<section id="sec_con" class="inr com_cont">
		<div class="res_com_txt" align="center">
			<img alt="" src = "${pageContext.request.contextPath }/resources/img/junggo/no.png" width ="70px"/>
	  		<h1>거래가 취소 되었습니다.</h1>
	  		<p>결제하신 금액은 결제 당시 사용하신 계좌로 재입금됩니다. 거래 내용을 확인해주세요.</p>
		</div>
		
			
		<div class="res_info_wrapper">
		
			<div class="res_info com_wrap">
				<h3>거래 정보</h3>
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
						<span>${jungGoNoh.product_title}</span>
					</li>
					<li>
						<em>거래 방식</em>
						<span>${jungGoNoh.product_payment}</span>
					</li>
					<li>
						<em>결제 취소 일시</em>
						<span>${jungGoNoh.trans_date}</span>
					</li> 
					<li>
						<em>결제 취소 사유</em>
						<span>${jungGoNoh.cancel_trade_reason}</span>
					</li> 
				</ul>
			</div>
		  
		  	<hr class="com_line">
		
			<div class="payment_info com_wrap">
				<h3>결제 정보</h3>
				<ul>
					<li>
						<em>결제 수단</em>
							<c:choose>
								<c:when test="${jungGoNoh2.pay_method == 1}">
									<span>신용카드</span>
								</c:when>
								<c:otherwise>
									<c:choose>
										<c:when test="${jungGoNoh2.pay_method == 2}">
											<span>간편결제</span>
										</c:when>
										<c:otherwise>
											<c:choose>
												<c:when test="${jungGoNoh2.pay_method == 3}">
													<span>계좌이체</span>
												</c:when>
												<c:otherwise>
													<span>페이이용X</span>		
												</c:otherwise>
											</c:choose>
										</c:otherwise>
									</c:choose>
								</c:otherwise>
							</c:choose>
					</li> 
					<li>
						<em>결제 금액</em>
						<span><fmt:formatNumber value="${jungGoNoh2.pay_total}" pattern="#,###"/>원</span>
					</li>
					<li>
						<em>결제 확인 일시</em>
						<span>${jungGoNoh2.trans_date}</span>
					</li>
				</ul>
			</div>
			<div class="finish_btn" align="center">
				<a href="${pageContext.request.contextPath }"><button>메인으로</button></a>
				<a href="${pageContext.request.contextPath }/store/${jungGoNoh.buyier_idx}"><button>나의 상점으로</button></a>
			</div>
		</div>
	</section>
</div>
	<footer>
		<jsp:include page="../inc_ex/footer.jsp" />
	</footer>


</body>
</html>