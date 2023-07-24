<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/auction/auction_main.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/inc/header.js"></script>
<link href="${pageContext.request.contextPath }/resources/css/auction/auction_main.css"	rel="stylesheet">
<link href="${pageContext.request.contextPath }/resources/css/inc/nav.css" rel="stylesheet" >
<link href="${pageContext.request.contextPath }/resources/css/inc/footer.css" rel="stylesheet" >
</head>
<body>
	<header> <!-- header -->
		<jsp:include page="../inc/header.jsp" />
	</header>
	<nav> <!-- nav -->
		<jsp:include page="../inc/nav.jsp" />
	</nav>
	<main> <!-- main -->
		<section id="pannelBox">
			<div> <!--  카테고리 -->
				홈 > 대분류 > 중분류 > 소분류
			</div>
			<div> <!-- 정렬 방식 -->
				<select id="orderMethod" name="orderMethod">
					<option value="" selected="selected" >정렬방식</option>
					<option value="recommended">추천순</option>
					<option value="dateorder">최신순</option>
					<option value="lowPrice">낮은가격순</option>
					<option value="highPrice">높은가격순</option>
				</select>
			</div>
		</section>
		<section>
			<aside> <!-- 카테고리 -->
<%-- 				<jsp:include page="" /> --%>
			</aside>
			<div id="itemList"> <!-- 상품 리스트 -->
				<c:forEach varStatus="status" step="1" end="10" begin="0">
					<a href="auctionDetail?code=">
						<div class="auctionItem"> <!-- 상품1 -->
							<img alt="테스트이미지" src="${pageContext.request.contextPath }/resources/img/auction/img1.jpg"> 
							<div> <!-- 상품명 -->
								상품명${status.index }
							</div>
							<div> <!-- 상품가격 -->
								상품가격
							</div>
							<div> <!-- 등록일 -->
								등록일
							</div>
						</div>
					</a>
				</c:forEach>
			</div>
		</section>
	</main>
	<footer> <!-- footer -->
		<jsp:include page="../inc/footer.jsp" />
	</footer>
</body>
</html>