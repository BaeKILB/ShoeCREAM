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
<link href="${pageContext.request.contextPath }/resources/css/admin/adminReport.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

</head>
<script type="text/javascript">
function deleteReport(product_idx) {
    swal({
        title: "상품 삭제",
        text: "해당 상품을 삭제 하시겠습니까?",
        icon: "warning",
        buttons: ["취소", "확인"],
        dangerMode: true,
    }).then((willDelete) => {
        if (willDelete) {
            location.href = "reportDelete?product_idx=" + product_idx;
        } else {
            // 취소 버튼을 눌렀을 경우 동작을 추가할 수 있습니다. (예: 아무 동작 없음)
        }
    });
}

</script>
<body>
	<aside>
		<jsp:include page="inc/sidebar.jsp" ></jsp:include>
	</aside>
	<section id="admin_cont">
		<h1 class="admin_tit">중고 상품 신고관리</h1>
		<hr class="tit_line">
		<div class="board_cont">
			<div class="board_list_wrap">
				<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }"> 
				<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
				<div class="search_wrap">
						<form name="reportlist" id="reportlist" action="" method="get">
							<select name="searchType" id="searchType">
								<option value="title"
									<c:if test="${param.searchType eq 'title'}" >selected</c:if>>신고유형</option>
								<option value="content"
									<c:if test="${param.searchType eq 'content'}">selected</c:if>>상세사유</option>
								<option value="title_content"
									<c:if test="${param.searchType eq 'title_content'}">selected</c:if>>신고내용</option>
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
									<th class="product">상품 번호</th>
									<th class="report_div">신고 유형</th>
									<th class="detail">상세 사유</th>
									<th class="reportdel">처리하기</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="reportProcess" items="${reportProcessing}">
									<tr>
										<td class="txt_prev"><a href="#">
											<h4 class="title_co">${reportProcess.report_content}</h4>
											</a>
											<td class= "product">${reportProcess.product_idx}
											<th class="report_div title_co" >${reportProcess.report_div}
											<th class="detail title_co">${reportProcess.report_detail}
											<th class="reportdel"> <button style="cursor: pointer;" class="moreBtn" onclick="deleteReport('${reportProcess.product_idx}')">처리하기</button>
									</tr>
								</c:forEach>
						</tbody>	
					</table>
				</div>
				<ul id="pageList">
						<c:if test="${pageMaker.cri.pageNum > 1 }">
							<li class='pgi'>
								<a href="reportProcess?pageNum=${pageMaker.cri.pageNum - 1 }" class='allprev'><i class='fa fa-angle-double-left pgi' aria-hidden='true'></i></a>
							</li>
						</c:if>
						<c:if test="${pageMaker.cri.pageNum > 1 }">
							<li class='pgi'>
							<a href="reportProcess?pageNum=${pageMaker.cri.pageNum - 1 }" class='prev'><i class='fa fa-angle-left pgi' aria-hidden='true'></i></a>
							</li>
						</c:if>
						<c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage }">
							<c:choose>
								<c:when test="${pageMaker.cri.pageNum == num }">
									<li>
										<a href="reportProcess?pageNum=${num }" class='pageNum current'>${num }</a>
									</li>
								</c:when>
								<c:otherwise>
									<li>
										<a href="reportProcess?pageNum=${num }" class='pageNum'>${num }</a>
									</li>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						<c:if test="${pageMaker.endPage < pageMaker.realEnd || pageMaker.endPage > 1 && pageMaker.cri.pageNum < pageMaker.realEnd}">
							<li class='pgi'>
								<a href="reportProcess?pageNum=${pageMaker.cri.pageNum + 1 }" class='next'><i class='fa fa-angle-right pgi' aria-hidden='true'></i></a>
							</li>
						</c:if>
						<c:if test="${pageMaker.endPage < pageMaker.realEnd || pageMaker.endPage > 1 && pageMaker.cri.pageNum < pageMaker.realEnd}">
							<li class='pgi'>
								<a href="reportProcess?pageNum=${pageMaker.cri.pageNum + 1 }" class='allnext'><i class='fa fa-angle-double-right pgi' aria-hidden='true'></i></a>
							</li>
						</c:if>
					</ul>
				</div>
			</div>	
		</section>


	<script type="text/javascript">
		$(document).ready(function() {
			$('.cont_li_wrap.reportList').show();
			$('.cont_item_list.jrepList').addClass('active');
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