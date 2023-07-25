<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 부트스트랩 -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-gH2yIJqKdNHPEq0n4Mqa/HGKIhSkIHeL5AyhkYV8i59U5AR6csBvApHHNl/vI1Bx"
	crossorigin="anonymous">

<!-- 공통 CSS -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/css/market/common.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/css/font/font.css">

<!-- 햄버거 메뉴 호버시 -->
<script
	src="${pageContext.request.contextPath }/resources/js/market/jquery-3.6.0.min.js"></script>
<script
	src="${pageContext.request.contextPath }/resources/js/market/menu_hover.js?ver=1"></script>
<!-- 파비콘 -->
<link rel="icon"
	href="${pageContext.request.contextPath }/resources/images/market/favicon.ico">
</head>
<body>
	<script type="text/javascript">
		function confirmLogout() {
			let result = confirm("로그아웃 하시겠습니까?");
			return result;
		}
	</script>

	<!-- header 영역 -->
	<header>
		<div id="top_header_bot_border">
			<div id="top_header">
				<div class="container text-center">
					<div id="top_header_menu" class="row justify-content-between">
						<div class="col-4 top_header_icon">
							<a href="#"> <%--      <img src="${pageContext.request.contextPath }/resources/images/market/download.svg" alt="앱 다운로드"> 앱다운로드 --%>
							</a> <a href="#"> <%--                                         <img src="${pageContext.request.contextPath }/resources/images/market/bookmark.svg" alt="즐겨찾기"> 즐겨찾기 --%>
							</a>
						</div>
						<div class="col-6">
							<div class="row justify-content-end top_header_login">
								<c:choose>
									<c:when test="${empty sessionScope.sId }">
										<div class="col-2">
											<a href="loginForm.me">로그인</a>
										</div>
										<div class="col-2" style="text-align: left;">
											<a href="CustomerCenter.ad">고객센터</a>
										</div>
									</c:when>
									<c:otherwise>
										<div class="col-2">
											<a href="myPage.me">${sessionScope.sId }님</a>
										</div>
										<div class="col-2">
											<a href="logout.me" onclick="return confirmLogout()">로그아웃</a>
										</div>
										<div class="col-2" style="text-align: left;">
											<a href="CustomerCenter.ad">고객센터</a>
										</div>
										<c:if test="${sessionScope.sId eq 'admin' }">
											<div class="col-3" style="text-align: left;">
												<a href="adminMain.ad">관리자페이지</a>
											</div>
										</c:if>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</header>
	<div id="bot_header_border">
		<div id="bot_header">
			<div class="container text-center">
				<div class="row justify-content-start">
                        <div class="col-3 header_logo">
                            <h1 class="hidden">로고</h1>
                            <a href="./">
                                <img src="${pageContext.request.contextPath }/resources/images/CleverLogo2.png" alt="클레버 로고" width="130px;" height="40px;">
                            </a>
                        </div>
                        <div class="col-6 top_searh_area">
                        	<c:choose>
                        		<c:when test="${not empty product_search }">
		                            <div id="top_searh">
		                                <input type="text" value="${product_search }" id="product_search" name="product_search" placeholder="상품명 입력"  onkeypress="show_name(event)">
		                                <img src="${pageContext.request.contextPath }/resources/images/market/search.png" alt="검색">
		                            </div>
	                            </c:when>
	                            <c:otherwise>
	                            	<div id="top_searh">
		                                <input type="text" id="product_search" name="product_search" placeholder="상품명 입력"  onkeypress="show_name(event)">
		                                <img src="${pageContext.request.contextPath }/resources/images/market/search.png" alt="검색">
		                            </div>
	                            </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="col-1 b_h_left_menu">
                            <a href="product_upload?member_id=${sessionScope.sId }"> 
                                <img src="${pageContext.request.contextPath }/resources/images/market/sell.png" alt="판매하기">
                                판매하기
                            </a>
                        </div>
                        <div class="col-1 b_h_left_menu store">
                            <a href="myPage.me">
                                <img src="${pageContext.request.contextPath }/resources/images/market/my_store.png" alt="마이페이지">
                                마이페이지
                            </a>
                        </div>
                        <div class="col-1 b_h_left_menu">
                            <a href="myChatting">
                                <img src="${pageContext.request.contextPath }/resources/images/market/talk.png" alt="1:1문의">
                                채팅
                            </a>
                        </div>
                    </div>
			</div>
			<div class="container text-center hamburger_area">
				<div class="row">
					<div class="col-md-1 hamburger">
						<img id="menu"
							src="${pageContext.request.contextPath }/resources/images/market/hamburger.png"
							alt="메뉴">
					</div>
					<div class="col-md-4 sell_center">
						<p>
							<a href="product_list" style="color: black;">중고거래　</a>
							<a href="auction" style="color: black;">경매하기　</a>
							<a href="goodsStore.ad" style="color: black;">스토어　</a>
						</p>
					</div>
					<!-- 메뉴 호버 -->
					<div id="test_area">
						<ul id="test_cates" style="height: 250px;">
							<h2>
								<a href="myPage.me" style="color: black;">마이페이지</a><span>
									></span>
							</h2>
							<li id="clothes"><a href="#">거래내역</a></li>
							<li id="acc"><a href="#">경매내역</a></li>
							<li id="acc"><a href="#">관심목록</a></li>
							<li id="acc"><a href="#">가계부</a></li>
							<li id="acc"><a href="#">스토어 구매내역</a></li>
							<li id="acc"><a href="#">포인트 | 페이</a></li>
						</ul>
						<ul id="test_clos">
							<h3>거래내역</h3>
							<li><a href="shBuyList.my">판매내역</a></li>
							<li><a href="#">구매내역</a></li>
						</ul>
						<ul id="test_accs">
							<h3>경매내역</h3>
							<li><a href="#">판매내역</a></li>
							<li><a href="#">구매내역</a></li>
						</ul>
					</div>
					<!-- // 메뉴 호버 -->
				</div>
			</div>

			<div id="side_bar">
				<div id="heart">
					<p>찜한 상품</p>
					<p>
						<img
							src="${pageContext.request.contextPath }/resources/images/market/heart.png"
							alt="찜 하트"> 0
					</p>
				</div>
				<div id="goods">
					<p>여기뭐하기로했더라</p>
					<p id="dotted"></p>
					<p>
						<img
							src="${pageContext.request.contextPath }/resources/images/market/eyes.png"
							alt="눈표시">
					<p>
						최근 본 상품<br>이<br>없습니다.
					</p>
					</p>
				</div>
				<!--                     <div id="QR_code"> -->
				<!--                         <p>앱 다운로드</p> -->
				<!--                         <p> -->
				<%--                             <img src="${pageContext.request.contextPath }/resources/images/market/QR_code.png" alt="QR 코드"> --%>
				<!--                         </p> -->
				<!--                     </div> -->
				<div id="top_btn">
					<button>
						<a href="#top_header">TOP</a>
					</button>
				</div>
			</div>
		</div>
	</div>
	<!-- // header 영역 -->
</body>
</html>