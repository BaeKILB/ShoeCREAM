<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SHOECREAM</title>
<%-- <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/common/common.css"> --%>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/main_ex/main_new.css">
<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.0.js"></script>
<%-- <script src="${pageContext.request.contextPath }/resources/js/main_ex/main.js"></script> --%>
</head>
<script type="text/javascript">
	let localURL = "${pageContext.request.contextPath}";
	let keyWord = "${product_search}";
</script>
<script src="${pageContext.request.contextPath }/resources/js/common/product_search.js"></script>
</head>
<body>
	<!-- 헤더 시작 -->
	<header>
		<jsp:include page="../inc_ex/header.jsp" />
	</header>
		<section id="main_cont">
		<div class="main_slide">
<!-- 			<div> -->
<!-- 				<div class="swiper-container"> -->
<!-- 				    <div class="swiper-wrapper"> -->
<!-- 				        <div class="swiper-slide">Slide 1</div> -->
<!-- 				        <div class="swiper-slide">Slide 2</div> -->
<!-- 				        <div class="swiper-slide">Slide 3</div> -->
<!-- 				    </div> -->
<!-- 				    <div class="swiper-pagination"></div> -->

<!-- 			        <div class="swiper-prev"></div> -->
<!-- 			        <div class="swiper-next"></div> -->
				    
<!-- 				</div> -->
<!-- 			</div> -->
			<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
		    <script>
		        const swiper = new Swiper('.swiper-container', {
		                loop: true,
		                pagination: {
		                    el: '.swiper-pagination'
		                },
		                navigation: {
		                    nextEl: '.swiper-next',
		                    prevEl: '.swiper-prev'
		                }
		            })
		    </script>
		</div>
		<div class="joonggo_list pr_list">
			<h3 class="list_tit">중고 거래 상품</h3>
			<div class="joonggo_cont pr_cont">
				<ul id="joongList">
					
				</ul>
			</div>
			<div class="more_btn">
				<a href="JunggoSearch">더보기</a>
			</div>
		</div>
		
		<div class="auction_list pr_list">
			<h3 class="list_tit">경매 거래 상품</h3>
			<div class="auction_cont pr_cont">
				<ul id="auctionList">

				</ul>
			</div>
			<div class="more_btn">
				<a href="Auction">더보기</a>
			</div>
		</div>
		
		<div class="cream_list pr_list">
			<h3 class="list_tit">크림 커스텀 상품</h3>
			<div class="cream_cont pr_cont">
				<ul id="creamList">
				
				</ul>
			</div>
			<div class="more_btn">
				<a href="Cream">더보기</a>
			</div>
		</div>
	</section>
	<footer>
		<jsp:include page="../inc_ex/footer.jsp" />
	</footer>
	<script src="${pageContext.request.contextPath }/resources/js/main_ex/market/login_modal.js"></script>
</body>
</html>