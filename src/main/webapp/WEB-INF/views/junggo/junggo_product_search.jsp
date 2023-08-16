<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
	
<c:set var="principal" value="${null}" />

<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal" var="principal" />
</sec:authorize>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SHOECREAM</title>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/common/common.css">
	<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.0.js"></script>\
	<link href="${pageContext.request.contextPath }/resources/css/etc/bootstrap.min.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath }/resources/css/junggo/junggo_product_search.css"	rel="stylesheet">
	<link href="${pageContext.request.contextPath }/resources/css/inc/side_category.css"	rel="stylesheet">
	<script	src="${pageContext.request.contextPath }/resources/js/etc/bootstrap.bundle.min.js"></script>
	
</head>
<body>
	<!-- 헤더 시작 -->
	<nav>
		<jsp:include page="../inc_ex/header.jsp" />
	</nav>

	<section id="main_cont">
		<main class="container jung_product_main" >	
	<%-- 		<c:if test="${!empty keyWord }"> --%>
	<%-- 			<section class="row"> --%>
	<!-- 				<div class="offset-md-3 col-md-9 col-sm-12 "> -->
	<!-- 					<p class="alert alert-primary"> -->
	<%-- 						${keyWord } 에 대한 검색결과입니다 --%>
	<!-- 					</p> -->
	<!-- 				</div> -->
	<%-- 			</section> --%>
	<%-- 		</c:if> --%>
			<article class="row">
				<section class="col-lg-2 category_wrap">
					<div class="ct_list_top">
						<h3 onclick="reLoadInitItems();">카테고리</h3>
						<button class="ct_up_down_btn d-block d-lg-none" onclick="hiddenCategory(this)"></button>
					</div>
					<aside class="sideCategoryWrap "> <!-- 카테고리 -->
						<div class="accordion accordion-flush" id="sideCategoryWrap">
							<c:forEach var="lc" items="${lc_list }">
								<div class="accordion-item">
								    <h2 class="accordion-header ct_lc_item_btn" id="${lc.lc_code }_header">
										<input type="hidden" class="lc_code" value="${lc.lc_code }">
										<button class="accordion-button collapsed " type="button" data-bs-toggle="collapse" data-bs-target="#${lc.lc_code }_mc_list" aria-expanded="false" aria-controls="${lc.lc_code }_mc_list">
											<span>${lc.lc_name }</span>
										</button>
								    </h2>
								    
								    <div id="${lc.lc_code }_mc_list" class="accordion-collapse collapse" aria-labelledby="${lc.lc_code }_header" data-bs-parent="#sideCategoryWrap">
										<c:forEach var="mc" items="${mc_list }">
											<c:if test="${lc.lc_code eq mc.parent_code }">
												<div class="accordion-body ct_mc_item_btn">
													<input type="hidden" class="mc_code" value="${mc.mc_code }">
													<span>${mc.mc_name }</span>
												</div>
											</c:if>
										</c:forEach>
								    </div>
						  		</div>
							</c:forEach>
						</div>
					</aside>
				</section>
				<section class="itemListWrap  col-lg-10  container" >
					<!-- 정렬 방식 -->
					<article class="row justify_cont">
						<div class="offset-10 col-2">
					        <select id="orderMethod" name="orderMethod">
					            <option value="" selected="selected" >정렬방식</option>
					            <option value="newest">최신순</option>
					            <option value="steamed">찜순</option>
					            <option value="view">조회순</option>
					        </select>
						</div>
					</article>
					<div id="itemList" class="row">
	
					</div>
				</section>
			</article>
	
	<!-- 		<article class="row"> -->
	<!-- 			<div class="offset-5 col-2">		 -->
	<!-- 				<a href="javascript:dataObj = loadItemAjax(dataObj)" id="btnLoadItem">더보기</a> -->
	<!-- 			</div> -->
	<!-- 		</article> -->
		</main>
	</section>
	
	
	<!-- 풋터 시작 -->
	<footer>
		<jsp:include page="../inc_ex/footer.jsp" />
	</footer>
	<script type="text/javascript">
		let localURL = "${pageContext.request.contextPath}";
	</script>
	<script	src="${pageContext.request.contextPath }/resources/js/junggo/junggo_product_search.js"></script>
	<script	src="${pageContext.request.contextPath }/resources/js/inc/side_category.js"></script>
</body>
</html>