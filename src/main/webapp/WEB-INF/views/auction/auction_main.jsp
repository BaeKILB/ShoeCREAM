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
<%-- <script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/inc/header.js"></script> --%>
<script src="${pageContext.request.contextPath }/resources/js/inc/side_category.js"></script>
<link href="${pageContext.request.contextPath }/resources/css/auction/auction_main.css"	rel="stylesheet">
<%-- <link href="${pageContext.request.contextPath }/resources/css/inc/nav.css" rel="stylesheet" > --%>
<link href="${pageContext.request.contextPath }/resources/css/inc/side_category.css"    rel="stylesheet">
<link href="${pageContext.request.contextPath }/resources/css/inc/footer.css" rel="stylesheet" >
</head>
<body>
	<header> <!-- header -->
<%--         <jsp:include page="../inc_ex/header.jsp" /> --%>
	</header>
	<nav> <!-- nav -->
<%-- 		<jsp:include page="../inc/nav.jsp" /> --%>
	</nav>
	<main> <!-- main -->
		<aside class="sideCategoryWrap"> <!-- 카테고리 -->
			<ul>
                <!-- 대분류 -->
                <c:forEach var="lc" items="${lc_category }">
		            <li class="ct_lc_item" >
		                <div class="ct_lc_item_btn">
		                    <span>${lc.lc_name }</span>
		                    <button class="ct_up_down_btn"></button>
		                </div>
		                <!-- 중분류 -->
					    <div id="${lc.lc_code }_mc_list" class="hidden">
					        <ul>
                                 <c:forEach var="mc" items="${mc_category }">
                                    <c:if test="${lc.lc_code eq mc.parent_code }">
							            <li class="ct_mc_item">
							                <div class="ct_mc_item_btn">
							                    <span>${mc.mc_name }</span>
							                </div>
							            </li>
                                    </c:if>
					           </c:forEach>
					        </ul>
					    </div>
                        <!-- 중분류 -->
		            </li>
                </c:forEach>
	            <!-- 대분류 -->
            </ul>
		</aside>
        <section id="pannelBox">
            <div id="categoryPath"> <!--  카테고리 -->
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
		<section class="offset-md-3 col-md-9 col-sm-12 container" style="border: 1px solid black">
			<div id="itemList" class="row row-cols-auto"></div>
		</section>
	</main>
	<footer> <!-- footer -->
		<jsp:include page="../inc/footer.jsp" />
	</footer>
</body>
</html>