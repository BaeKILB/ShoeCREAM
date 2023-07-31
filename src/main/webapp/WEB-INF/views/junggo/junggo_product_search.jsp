<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath}/resources/css/junggo/common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/resources/css/junggo/junggo_product_search.css"	rel="stylesheet">
<link href="${pageContext.request.contextPath }/resources/css/etc/bootstrap.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/resources/css/junggo/inc/product_item_box.css"	rel="stylesheet">
<link href="${pageContext.request.contextPath }/resources/css/inc/side_category.css"	rel="stylesheet">
<script	src="${pageContext.request.contextPath }/resources/js/etc/bootstrap.bundle.min.js"></script>
<script	src="${pageContext.request.contextPath }/resources/js/inc/side_category.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.0.js"></script>

</head>
<body>
	<h1>junggo search</h1>
	<main class="container" >	
		<article class="row">
			<section class="sideCategoryWrap" >
				<jsp:include page="../inc/side_category_lc.jsp"></jsp:include>
			</section>
			<section class="itemListWrap offset-md-3 col-md-9 col-sm-12  container" style="border:1px solid black">
				<div id="itemList" class="row row-cols-auto">

				</div>
			</section>
		</article>
		<article class="row">
			<div class="offset-5 col-2">		
				<a href="javascript:dataObj = loadItemAjax(dataObj)" id="btnLoadItem">더보기</a>
			</div>
		</article>
	</main>
	
	<script type="text/javascript">

		// 페이지 정보 넣기
		let dataObj = ${jsonObj}
	</script>
	<script	src="${pageContext.request.contextPath }/resources/js/junggo/junggo_product_search.js"></script>

</body>
</html>