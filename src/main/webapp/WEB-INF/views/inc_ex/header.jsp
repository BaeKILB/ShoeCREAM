<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<c:set var="principal" value="${null}" />
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal" var="principal" />
</sec:authorize>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/inc/header.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/common/common.css">
</head>
<script>
function show_name(e) {
	var code = e.code;
	let search = $("#product_search").val();
	console.log('검색');
	if (code == 'Enter') {
		location.href = 'productSearch?product_search=' + search;
	}
}
</script>
<body>
	<div id="header">
		<header>
			<div class="header_util">
				<input type="hidden" id="principalId" value="${principal.member.mem_idx }">
				<ul>
					<c:choose>
						<c:when test="${empty principal}">
							<li>
								<a href="login">로그인</a>
							</li>
							<li>
								<a href="signup">회원가입</a>
							</li>
							<li>
								<a href="UserNotice">공지사항</a>
							</li>
						</c:when>
						<c:otherwise>
							<li class="user_name">
								<a href="${pageContext.request.contextPath }/mypage/update">
									<i class="fa fa-cog" aria-hidden="true"></i>
									${principal.member.mem_id }님
								</a>
								<c:if test="${principal.member.mem_id == 'admin'}">
                                    <a href="${pageContext.request.contextPath}/AdminMain">관리자페이지</a>
                                </c:if>
							</li>
							<li>
								<a href="${pageContext.request.contextPath }/social/${principal.member.mem_idx}">내 소셜</a>
							</li>
							<li>
								<a href="${pageContext.request.contextPath }/social/story">스토리</a>
							</li>
							<li>
								<a href="${pageContext.request.contextPath }/logout" onclick="return confirmLogout()">로그아웃</a>
							</li>
							<li>
								<a href="UserNotice">고객센터</a>						
							</li>
						</c:otherwise>
					</c:choose>
				</ul>
			</div>
			<div class="header_main">
				<h1>
					<a href="${pageContext.request.contextPath }/">
						<img src="${pageContext.request.contextPath }/resources/img/main_ex/shoecream_logo.png" alt="로고">
					</a>
				</h1>
				<div class="header_search">
					<c:choose>
						<c:when test="${not empty product_search }">
							<div>
								<span>
									<i class="fa fa-search" aria-hidden="true"></i>
								</span>
								<input type="text" value="${product_search }" id="product_search" name="product_search" placeholder="어떤 상품을 찾으시나요?" onkeypress="show_name(event)">
							</div>
						</c:when>
						<c:otherwise>
							<div>
								<span>
									<i class="fa fa-search" aria-hidden="true"></i>
								</span>
								<input type="text" id="product_search" name="product_search" placeholder="어떤 상품을 찾으시나요?" onkeypress="show_name(event)">
							</div>
						</c:otherwise>
					</c:choose>
				</div>
				<div class="header_inn">
					<ul>
						<li>
							<a href="${pageContext.request.contextPath }/mypage/update" style="color: black;">마이페이지</a>
						</li>
						<li>
							<a href="${pageContext.request.contextPath }/store/${principal.member.mem_idx}" style="color: black;">내 상점</a>
						</li>
						<li>
							<a href="${pageContext.request.contextPath }/social/popular" style="color: black;">소셜</a>					
						</li>
					</ul>
				</div>
			</div>
			<div class="header_menu">
				<div class="nav_item">
					<div class="category_btn" onclick="location.href='${pageContext.request.contextPath}/JunggoSearch'">
						<i class="fa fa-bars" aria-hidden="true"></i>
						<span>카테고리</span>
					</div>
					<nav>
						<ul>
							<li>
								<a href="${pageContext.request.contextPath}/JunggoSearch" style="color: black;">중고거래</a> 
							</li>
							<li>
								<a href="${pageContext.request.contextPath }/Auction" style="color: black;">경매하기</a>
							</li>
							<li>
								<a href="${pageContext.request.contextPath }/RegisterForm" style="color: black;">상품등록</a>
							</li>
							<li>
								<a href="${pageContext.request.contextPath}/Cream" style="color: black;">커스텀</a>
							</li>
							<li>
								<a href="${pageContext.request.contextPath }/chatRooms?chat_area=0" style="color: black;">중고채팅</a>
							</li>
						</ul>
					</nav>
				</div>
			</div>
		</header>
	</div>
	<!-- // header 영역 -->
</body>
</html>