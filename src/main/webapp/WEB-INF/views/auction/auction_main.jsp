<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/auction/auction_main.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/etc/bootstrap.bundle.min.js"></script>
<%-- <script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/inc/header.js"></script> --%>
<%-- <link href="${pageContext.request.contextPath }/resources/css/inc/nav.css" rel="stylesheet" > --%>
<link href="${pageContext.request.contextPath }/resources/css/etc/bootstrap.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/resources/css/auction/auction_main.css"	rel="stylesheet">
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
	<main class="container"> <!-- main -->
	    <div class="row">
	        <div class="col-xl-2">
				<aside class="sideCategoryWrap"> <!-- 카테고리 -->
					<ul>
		                <!-- 대분류 -->
		                <c:forEach var="lc" items="${lc_category }">
				            <li class="ct_lc_item" >
				                <div class="ct_lc_item_btn">
			                    	<input type="hidden" class="lc_code" value="${lc.lc_code }">
				                    <span>${lc.lc_name }</span>
				                    <button class="ct_up_down_btn"></button>
				                </div>
				                <!-- 중분류 -->
							    <div id="${lc.lc_code }_mc_list" class="d-none">
							        <ul>
		                                 <c:forEach var="mc" items="${mc_category }">
		                                    <c:if test="${lc.lc_code eq mc.parent_code }">
									            <li class="ct_mc_item">
									                <div class="ct_mc_item_btn">
			                    						<input type="hidden" class="mc_code" value="${mc.mc_code }">
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
	        </div>
            <div class="col-xl-10">
                <div class="container">
	                <div class="row justify-content-between">
			            <div class="col-md-7 col-12"> <!--  카테고리 -->
                            <div class="row no-gutters">
								<nav style="--bs-breadcrumb-divider: url(&#34;data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='8' height='8'%3E%3Cpath d='M2.5 0L1 1.5 3.5 4 1 6.5 2.5 8l4-4-4-4z' fill='currentColor'/%3E%3C/svg%3E&#34;);" aria-label="breadcrumb">
									<ol class="breadcrumb" id="categoryPath">
										<li class="breadcrumb-item"><a href="Auction">Home</a></li>
										<li class="breadcrumb-item d-none"><a href="#" id="lcHref"></a></li>
										<li class="breadcrumb-item d-none"><a href="#" id="mcHref"></a></li>
									</ol>
								</nav>
                            </div>
			            </div>
			            <div class="col-lg-2 col-md-3 col"> <!-- 정렬 방식 -->
			                <select class="form-select orderMethod" id="orderMethod">
                                <option value="" selected>정렬방식</option>
                                <option value="newest">최신순</option>
                                <option value="deadline">마감임박순</option>
                                <option value="steamed">찜순</option>
                                <option value="popular">인기순</option>
							</select>
			            </div>
					</div>
					<div id="itemList" class="row"></div>
                </div>
    	    </div>
	    </div>
	</main>
	<footer> <!-- footer -->
		<jsp:include page="../inc/footer.jsp" />
	</footer>
</body>
</html>