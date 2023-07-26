<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 신고 관리</title>
<link href="${pageContext.request.contextPath }/resources/css/admin/common.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/admin/adminBoard.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/admin/admin_report.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>
</head>
<script type="text/javascript">


	function deleteReport(product_idx) {
	  if (!confirm("해당 상품을 삭제 하시겠습니까?")) {
	    return false;
	  } else {
	    location.href="reportDelete?product_idx=" + product_idx;
	  }
	}

</script>
<body>
	<aside>
		<jsp:include page="inc/sidebar.jsp" ></jsp:include>
	</aside>
	<section id="admin_cont">
		<h1 class="admin_tit">신고관리</h1>
		<hr class="tit_line">
		<div class="board_cont">
			<div class="board_list_wrap">
				<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }"> 
				<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
				<div class="search_wrap">
						<form name="reportlist" id="reportlist" action="" method="get">
							<select name="searchType" id="searchType">
								<option value="title"
									<c:if test="${param.searchType eq 'title'}" >selected</c:if>>제목</option>
								<option value="content"
									<c:if test="${param.searchType eq 'content'}">selected</c:if>>내용</option>
								<option value="title_content"
									<c:if test="${param.searchType eq 'title_content'}">selected</c:if>>제목&내용</option>
							</select> 
								<input type="text" name="searchKeyword" value="${param.searchKeyword}" id="searchKeyword"> 
								<input type="submit" value="검색" class="searchSubmit">
						</form>
					</div>
					<div class="table_container">
						<table class="board_list_table table">
							<thead>
								<tr>
									
									<th class="text_prev">
										<h4>신고 내용</h4>
									</th>
									<th class="count"><span class="report_count">신고 횟수</span></th>
									<th class="product">상품 번호</th>
									<th class="report_div">신고 유형</th>
									<th class="detail">상세 사유</th>
									<th class="reportdel">처리하기</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="reportProcess" items="${report}">
									<tr>
										
										<td class="txt_prev"><a href="#">
											<h4 class="title_co">${reportProcess.report_content}</h4>
											</a>
											<td class="count"><span class="report_count"> <span class="sv_member">${reportProcess.report_count}</span></span></td>
											<td class= "product">${reportProcess.product_idx}
											<th class="report_div title_co" >${reportProcess.report_div}
											<th class="detail title_co">${reportProcess.report_detail}
											<th class="reportdel"><button style='cursor: pointer;'class="moreBtn" onclick="deleteReport(${reportProcess.product_idx})">처리하기</button> 
									</tr>
								</c:forEach>
						</tbody>	
					</table>
				</div>
				<div class="list_pager_wrap">
						<nav class="pg_wrap">
							<span class="pg"> 
							<c:if test="${pageMaker.cri.pageNum > 1 }">
									<a href="reportProcess?pageNum=${pageMaker.cri.pageNum - 1 }" class="pg_page pg_prev">이전</a>
							</c:if> 
								<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="num">
									<c:choose>
										<c:when test="${pageMaker.cri.pageNum == num }">
											<strong class="pg_current">${num}</strong>
										</c:when>
										<c:otherwise>
											<a href="reportProcess?pageNum=${num }" class="pg_page">${num }</a>
										</c:otherwise>
									</c:choose>
								</c:forEach> 
								<c:if test="${pageMaker.endPage < pageMaker.realEnd || pageMaker.endPage > 1 && pageMaker.cri.pageNum < pageMaker.realEnd}">
									<a href="reportProcess?pageNum=${pageMaker.cri.pageNum + 1 }" class="pg_page pg_next">다음</a>
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