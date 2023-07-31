<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>경매상품관리</title>
<link href="${pageContext.request.contextPath }/resources/css/admin/common.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/admin/adminMain.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/admin/adminBoard.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>
</head>
<script type="text/javascript">
</script>
<body>
	<aside>
		<jsp:include page="inc/sidebar.jsp" ></jsp:include>
	</aside>
		<section id="admin_cont">
		<h1 class="admin_tit">경매 상품 관리</h1>
			<hr class="tit_line">
			<div class="board_cont">	
				<div class="board_list_wrap">
					<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }"> 
					<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
					<div class="search_wrap">
					<form action="auctionProduct" method="get" class="searchForm">
						<select name="searchType" id="searchType">
							<option value="brand" <c:if test="${param.searchType eq 'auction_brand' }">selected</c:if>>브랜드</option>			
							<option value="auction_title" <c:if test="${param.searchType eq 'auction_info' }">selected</c:if>>상품제목</option>			
							<option value="code" <c:if test="${param.searchType eq 'auction_idx' }">selected</c:if>>상품코드</option>		
						</select>
						<input type="text" name="searchKeyword" value="${param.searchKeyword }" id="searchKeyword">
						<input type="submit" value="검색" class="searchSubmit" style="cursor: pointer;">
					</form>
				</div>
				<div class="table_container">
					<table class="board_list_table table">
						<thead>
							<tr>
								<th class="code"><span class="auction_idx">상품 코드</span></th>
								<th class="brand"><span class="product_brand">브랜드</span></th>
								<th class="price">경매시작가</th>
								<th class="price_dibs">경매입찰가</th>
								<th class="auction_title">상품제목</th>
								<th class="image">상품이미지</th>
								<th class="date">경매 등록일</th>
								<th class="delete">삭제하기</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="auctionmap" items="${auctionmap}">
								<tr>
<!-- 									<td class="txt_prev"><a href="#"> -->
<%-- 										<h4 class="title_co">${adminProduct.product_title}</h4> --%>
<!-- 										</a> -->
										<td class="code"><span class="product_code"> <span class="sv_member">${auctionmap.auction_idx}</span></span></td>
										<td class="brand"> ${auctionmap.auction_brand}</td>
										<td class="price">${auctionmap.auc_start_price}</td>
										
										<td class="price_dibs">${auctionmap.bid_price}</td>
										<td class="product_info">${auctionmap.auction_info}</td>
										<td><img src="${pageContext.request.contextPath}/resources/upload/${auctionmap.image1}" class="imagesize"/></td>
<%-- 										<td class="date"><fmt:formatDate value="${auctionmap.auc_regist_date}" pattern="YYYY-MM-dd" /></td> --%>
										<td class="date">${auctionmap.auc_regist_date}</td>
										<td class="productdel" ><button style='cursor: pointer;'class="moreBtn" >삭제하기</button></td>
								</tr>
							
							
							</c:forEach>
						</tbody>
					</table>
				</div>
				<div class="list_pager_wrap">
						<nav class="pg_wrap">
							<span class="pg"> 
							<c:if test="${pageMaker.cri.pageNum > 1 }">
									<a href="auctionProduct?pageNum=${pageMaker.cri.pageNum - 1 }" class="pg_page pg_prev">이전</a>
							</c:if> 
								<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="num">
									<c:choose>
										<c:when test="${pageMaker.cri.pageNum == num }">
											<strong class="pg_current">${num}</strong>
										</c:when>
										<c:otherwise>
											<a href="auctionProduct?pageNum=${num }" class="pg_page">${num }</a>
										</c:otherwise>
									</c:choose>
								</c:forEach> 
								<c:if test="${pageMaker.endPage < pageMaker.realEnd || pageMaker.endPage > 1 && pageMaker.cri.pageNum < pageMaker.realEnd}">
									<a href="auctionProduct?pageNum=${pageMaker.cri.pageNum + 1 }" class="pg_page pg_next">다음</a>
								</c:if>
							</span>
						</nav>
					</div>
				</div>
			</div>
		</section>
		<script>
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