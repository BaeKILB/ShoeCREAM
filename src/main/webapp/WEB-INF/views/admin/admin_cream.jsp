<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>크림상품관리</title>
<link href="${pageContext.request.contextPath }/resources/css/admin/common.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/admin/adminBoard.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/admin/adminCream.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
</head>
<script type="text/javascript">

</script>
<body>
	<aside>
		<jsp:include page="inc/sidebar.jsp" ></jsp:include>
	</aside>
	<section id="admin_cont">
		<h1 class="admin_tit">크림 상품 관리</h1>
		<hr class="tit_line">
		<div class="board_cont">	
			<div class="board_list_wrap">
				<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }"> 
				<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
				<div class="search_wrap">
					<form action="creamProduct" method="get" class="searchForm">
						<select name="searchType" id="searchType">
							 <option value="brand" <c:if test="${param.searchType eq 'ci_brand'}">selected</c:if>>브랜드</option>
			                <option value="title" <c:if test="${param.searchType eq 'ci_name'}">selected</c:if>>상품제목</option>
			                <option value="code" <c:if test="${param.searchType eq 'ci_code'}">selected</c:if>>상품코드</option>
						</select>
						<input type="text" name="searchKeyword" value="${param.searchKeyword }" id="searchKeyword">
						<input type="submit" value="검색" class="searchSubmit" style="cursor: pointer;">
					</form>
				</div>
				<div class="table_container">
					<table class="board_list_table table">
						<thead>
							<tr>
								<th class="code"><span class="ci_code">상품 코드</span></th>
								<th class="ci_name"><span class="ci_name">상품제목</span></th>
								<th class="brand">브랜드</th>
								<th class="model">모델번호</th>
								<th class="image">상품이미지</th>
								<th class="color">상품색상</th>
								<th class="startdate">발매일</th>
								<th class="startprice">발매가</th>
								<th class="delete">삭제하기</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="creammap" items="${creammap}">
								<tr>
									<td class="code"><span class="product_code"> <span class="sv_member">${creammap.ci_code}</span></span></td>
									<td class="ci_name"> ${creammap.ci_name}</td>
									<td class="brand">${creammap.ci_brand}</td>
									<td class="model">${creammap.ci_model_num}</td>
									<td><img src="${pageContext.request.contextPath}${creammap.image_path }/${creammap.image1}" class="imagesize"/></td>
									<td class="color">${creammap.ci_color}</td>
									<td class="startdate"><fmt:formatDate value="${creammap.ci_rel_date}" pattern="YYYY-MM-dd" /></td>
									<td class="startprice">${creammap.ci_origin_price}</td>
									<td class="productdel" ><button style='cursor: pointer;'class="moreBtn" onclick="deleteProcream('${creammap.ci_code}')">삭제하기</button></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</section>
	<script type="text/javascript">
		$(document).ready(function() {
			$('.cont_li_wrap.creamList').show();
			$('.cont_item_list.creamPro').addClass('active');
		});
	    $(document).on('click', '.toggle_wrap', function() {
	    	if($('#admin_cont').css('margin-left') === '0px') {
	    		$('#admin_cont').show().animate({
					marginLeft : '15.625rem'
				}, 200);
	    	} else {
	    		$('#admin_cont').show().animate({
					marginLeft : '0px'
				}, 200);
	    	}
	    });
	</script>
</body>
</html>