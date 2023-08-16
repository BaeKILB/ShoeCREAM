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
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/common/common.css">

</head>
<body>
	<nav>
		<jsp:include page="../inc_ex/header.jsp" />
	</nav>
	<section id="main_cont">
		<main class="container"> <!-- main -->
		    <div class="row">
		        <div class="col-xl-2 category_wrap">
					<aside class="sideCategoryWrap d-none d-md-block"> <!-- 카테고리 -->
						<div class="accordion accordion-flush" id="sideCategoryWrap">
							<c:forEach var="lc" items="${lc_category }">
								<div class="accordion-item">
								    <h2 class="accordion-header" id="${lc.lc_code }_header">
										<button class="accordion-button collapsed ct_lc_item_btn" type="button" data-bs-toggle="collapse" data-bs-target="#${lc.lc_code }_lcList" aria-expanded="false" aria-controls="${lc.lc_code }_lcList">
											<span>${lc.lc_name }</span>
										</button>
										<input type="hidden" class="lc_code" value="${lc.lc_code }">
								    </h2>
								    <div id="${lc.lc_code }_lcList" class="accordion-collapse collapse" aria-labelledby="${lc.lc_code }_header" data-bs-parent="#sideCategoryWrap">
										<c:forEach var="mc" items="${mc_category }">
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
				            <div class="col-lg-2 col-md-3 col justify_cont"> <!-- 정렬 방식 -->
				                <select class="form-select orderMethod" id="orderMethod">
	                                <option value="newest" selected>최신순</option>
	                                <option value="deadline">마감임박순</option>
	                                <option value="steamed">찜순</option>
	                                <option value="popular">인기순</option>
								</select>
				            </div>
						</div>
						<div id="itemList" class="row no-gutters"></div>
	                </div>
	    	    </div>
		    </div>
		</main>
	</section>
    <footer>
		<jsp:include page="../inc_ex/footer.jsp" />
	</footer>
</body>
</html>