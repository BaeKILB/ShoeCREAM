<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>중고상품관리</title>
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
		<h1 class="admin_tit">중고 상품 관리</h1>
			<hr class="tit_line">
			<div class="board_cont">	
				<div class="board_list_wrap">
					<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }"> 
					<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
					<div class="search_wrap">
					<form action="adminjoonggo" method="get" class="searchForm">
						<select name="searchType" id="searchType">
							<option value="mem_id" <c:if test="${param.searchType eq 'mem_id' }">selected</c:if>>아이디</option>			
							<option value="mem_name" <c:if test="${param.searchType eq 'mem_name' }">selected</c:if>>이름</option>			
							<option value="mem_nickname" <c:if test="${param.searchType eq 'mem_nickname' }">selected</c:if>>닉네임</option>			
							<option value="mem_rank" <c:if test="${param.searchType eq 'mem_rank' }">selected</c:if>>등급</option>			
						</select>
						<input type="text" name="searchKeyword" value="${param.searchKeyword }" id="searchKeyword">
						<input type="submit" value="검색" class="searchSubmit" style="cursor: pointer;">
					</form>
				</div>
				<div class="table_container">
					<table class="board_list_table table">
						<thead>
							<tr>
								<th class="txt_prev">
									<h4>상품명</h4>
								</th>
								<th class="code"><span class="product_code">상품 코드</span></th>
								<th class="price">상품가격</th>
								<th class="product_info">상품정보</th>
								<th class="image">상품이미지</th>
								<th class="date">등록일</th>
								<th class="delete">삭제하기</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="AdminJoonggo" items="${productjoong}">
								<tr>
									<td class="txt_prev"><a href="#">
										<h4 class="title_co">${AdminJoonggo.product_title}</h4>
										</a>
										<td class="code"><span class="product_code"> <span class="sv_member">${AdminJoonggo.product_idx}</span></span></td>
										<td class="price">${AdminJoonggo.product_price}
										<td class="product_info">${AdminJoonggo.product_info}
										<td><img src="${pageContext.request.contextPath}/resources/img/admin/${AdminJoonggo.image_path}/${AdminJoonggo.image1}" /></td>
										<td class="date"><fmt:formatDate value="${AdminJoonggo.product_date}" pattern="YYYY-MM-dd" /></td>
										<th class="reportdel"><button style='cursor: pointer;'class="moreBtn" onclick="deleteReport(${reportProcess.product_idx})">삭제하기</button> 
								</tr>
							
							
							</c:forEach>
						</tbody>
					</table>
				</div>
				<div class="list_pager_wrap">
						<nav class="pg_wrap">
							<span class="pg"> 
							<c:if test="${pageMaker.cri.pageNum > 1 }">
									<a href="NoticeList?pageNum=${pageMaker.cri.pageNum - 1 }" class="pg_page pg_prev">이전</a>
							</c:if> 
								<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="num">
									<c:choose>
										<c:when test="${pageMaker.cri.pageNum == num }">
											<strong class="pg_current">${num}</strong>
										</c:when>
										<c:otherwise>
											<a href="NoticeList?pageNum=${num }" class="pg_page">${num }</a>
										</c:otherwise>
									</c:choose>
								</c:forEach> 
								<c:if test="${pageMaker.endPage < pageMaker.realEnd || pageMaker.endPage > 1 && pageMaker.cri.pageNum < pageMaker.realEnd}">
									<a href="NoticeList?pageNum=${pageMaker.cri.pageNum + 1 }" class="pg_page pg_next">다음</a>
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