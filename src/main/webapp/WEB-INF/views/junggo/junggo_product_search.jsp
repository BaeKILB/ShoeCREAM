<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.0.js"></script>
<link href="${pageContext.request.contextPath}/resources/css/junggo/common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/resources/css/junggo/junggo_product_search.css"	rel="stylesheet">
<link href="${pageContext.request.contextPath }/resources/css/etc/bootstrap.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/resources/css/junggo/inc/product_item_box.css"	rel="stylesheet">
<link href="${pageContext.request.contextPath }/resources/css/inc/side_category.css"	rel="stylesheet">
<script	src="${pageContext.request.contextPath }/resources/js/etc/bootstrap.bundle.min.js"></script>

</head>
<body>
	<h1>junggo search</h1>
	<main class="container" >	
		<article class="row">

				<aside class="sideCategoryWrap categoryTop ct_lc_list categoryList"> 
				카테고리
					<ul>
<!-- 		                대분류 -->
		                <c:forEach var="lc" items="${lc_list }">
				            <li class="ct_lc_item" >
				                <div class="ct_lc_item_btn">
			                    	<input type="hidden" value="${lc.lc_code }">
				                    <span class="">${lc.lc_name }</span>
				                    <button class="ct_up_down_btn" onclick=""></button>
				                </div>
<!-- 				                중분류 -->
							    <div id="${lc.lc_code }_mc_list" class="hidden">
							        <ul>
		                                 <c:forEach var="mc" items="${mc_list }">
		                                    <c:if test="${lc.lc_code eq mc.parent_code }">
									            <li class="ct_mc_item">
									                <div class="ct_mc_item_btn">
			                    						<input type="hidden" value="${mc.mc_code }">
									                    <span>${mc.mc_name }</span>
									                </div>
									            </li>
		                                    </c:if>
							           </c:forEach>
							        </ul>
							    </div>
<!-- 		                        중분류 -->
				            </li>
		                </c:forEach>
<!-- 			            대분류 -->
		            </ul>
				</aside>
				
<!-- 				<ul> -->
<%-- 					<c:forEach var="lc" items="${lc_list }" varStatus="i">	 --%>
<%-- 						<jsp:include page="../inc/side_category_lc.jsp"> --%>
<%-- 							<jsp:param value="lc" name="lc"/> --%>
<%-- 							<jsp:param value="mc_list[${ i.index-1}]" name="mc"/> --%>
<%-- 						</jsp:include> --%>
<%-- 					</c:forEach> --%>
<!-- 				</ul> -->

			<section class="itemListWrap offset-md-3 col-md-9 col-sm-12  container" style="border:1px solid black">
				<!-- 정렬 방식 -->
				<article class="row">
					<div class="offset-10 col-2">
				        <select id="orderMethod" name="orderMethod">
				            <option value="" selected="selected" >정렬방식</option>
				            <option value="newest">최신순</option>
				            <option value="steamed">찜순</option>
				            <option value="view">조회순</option>
				        </select>
					</div>
				</article>
				<div id="itemList" class="row row-cols-auto">

				</div>
			</section>
		</article>

<!-- 		<article class="row"> -->
<!-- 			<div class="offset-5 col-2">		 -->
<!-- 				<a href="javascript:dataObj = loadItemAjax(dataObj)" id="btnLoadItem">더보기</a> -->
<!-- 			</div> -->
<!-- 		</article> -->
	</main>
	

	<script	src="${pageContext.request.contextPath }/resources/js/junggo/junggo_product_search.js"></script>
	<script	src="${pageContext.request.contextPath }/resources/js/inc/side_category.js"></script>
</body>
</html>