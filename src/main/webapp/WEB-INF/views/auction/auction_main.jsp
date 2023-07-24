<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>
<link href="${pageContext.request.contextPath }/resources/css/auction/auction_main.css"	rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/auction/auction_main.js"></script>
</head>
<body>
	<header> <!-- header -->
		header area
	</header>
	<nav> <!-- nav -->
		nav area
	</nav>
	<main> <!-- main -->
		<div> <!--  카테고리 -->
			홈 > 대분류 > 중분류 > 소분류
		</div>
		<div> <!-- 정렬 방식 -->
			<select>
				<option value="" selected="selected" >정렬방식</option>
				<option value="" selected="selected" >추천순</option>
				<option value="" selected="selected" >최신순</option>
				<option value="" selected="selected" >낮은가격순</option>
				<option value="" selected="selected" >높은가격순</option>
			</select>
		</div>
		<section>
			<div id="itemList"> <!-- 상품 리스트 -->
				<aside> <!-- 카테고리 -->
<%-- 					<jsp:include page="" /> --%>
				</aside>
				<c:forEach varStatus="status" step="1" end="10" begin="0">
					<div class="auctionItem"> <!-- 상품1 -->
						<img alt="테스트이미지" src="${pageContext.request.contextPath }/resources/img/auction/img1.jpg"> 
						<div> <!-- 상품명 -->
							상품명${status.index }
						</div>
						<div> <!-- 상품가격 -->
							상품가격
						</div>
						<div>
							<span> <!-- 거래장소 -->
								거래장소
							</span>
							<span> <!-- 등록일 -->
								등록일
							</span>
						</div>
					</div>
				</c:forEach>
			</div>
		</section>
	</main>
	<footer> <!-- footer -->
		footer area
	</footer>
</body>
</html>