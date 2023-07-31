<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/resources/js/cream/cream_main.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/resources/js/inc/header.js"></script>
<%-- <link href="${pageContext.request.contextPath }/resources/css/cream/cream_main.css"	rel="stylesheet"> --%>
<%-- <link href="${pageContext.request.contextPath }/resources/css/inc/nav.css" rel="stylesheet" > --%>
<link
	href="${pageContext.request.contextPath }/resources/css/inc/footer.css"
	rel="stylesheet">
</head>
<body>
	<header>
		<!-- header -->
		<%-- 		<jsp:include page="../inc/header.jsp" /> --%>
	</header>
	<nav>
		<div class="search">
			<input type="text" placeholder="브랜드명, 모델명, 모델번호 등" title="검색창">
		</div>
	</nav>
	<aside>
		카테고리
	</aside>
	<main>
		<section id="pannelBox">
			<div>
				<!-- 카테고리 -->
			</div>
			<div>
				<!-- 정렬 방식 -->
				<select id="orderMethod" name="orderMethod">
					<option value="" selected="selected">정렬방식</option>
					<option value="recommended">추천순</option>
					<option value="dateorder">최신순</option>
					<option value="lowPrice">낮은가격순</option>
					<option value="highPrice">높은가격순</option>
				</select>
			</div>
		</section>
		<section>
			<div id="itemList">
				<!-- 상품 리스트 -->
				<%-- 				<c:forEach var="auction" items="${auctionList }"> --%>
				<%-- 					<a href="auctionDetail?code=${auction.auction_idx }"> --%>
				<!-- 						<div class="auctionItem"> -->
				<%-- 							<img alt="테스트이미지" src="${pageContext.request.contextPath }${auction.image_path }/${auction.image1 }">  --%>
				<!-- 							<div> 상품명 -->
				<%-- 								${auction.auction_title } --%>
				<!-- 							</div> -->
				<!-- 							<div> 상품가격 -->
				<%-- 								${auction.auc_start_price } --%>
				<!-- 							</div> -->
				<!-- 							<div> 등록일 -->
				<%-- 								${auction.auc_regist_date } --%>
				<!-- 							</div> -->
				<!-- 						</div> -->
				<!-- 					</a> -->
				<%-- 				</c:forEach> --%>
			</div>
		</section>
	</main>
	<footer>
		<!-- footer -->
		<jsp:include page="../inc/footer.jsp" />
	</footer>
</body>
</html>