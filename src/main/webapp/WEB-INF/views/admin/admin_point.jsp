<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath }/resources/css/admin/common.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/admin/adminMain.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/admin/adminBoard.css" rel="stylesheet" type="text/css">

</head>
<body>
	<aside>
		<jsp:include page="inc/sidebar.jsp" ></jsp:include>
	</aside>
		<section id="admin_cont">
		<h1 class="admin_tit"> 포인트 입출금 내역</h1>
			<hr class="tit_line">
			<div class="board_cont">	
				<div class="board_list_wrap">
					<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }"> 
					<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
					<div class="search_wrap">
				</div>
				 <div class="card-header">
<%--                       <h4 class="card-title">현재 잔액 : ${admininfo.mem_balance }원</h4> --%>
                  </div>
				<div class="table_container">
					<table class="board_list_table table">
						<thead>
							<tr>
								<th class="mem_id">회원번호</th>
								<th class="amount">금액</th>
<!-- 								<th class="charge_point_amount">충전/출금 후 잔액</th> -->
								<th class="date">입금일</th>
								<th class="point_usage">포인트 사용처</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="adminPointAccount" items="${pointList}">
								<tr>
										<td class="mem_id">${adminPointAccount.mem_idx}</td>
										<td class="amount"> ${adminPointAccount.charge_point} 원 ${adminPointAccount.point_status }</td>
<%-- 										<td class="mem_id">${adminPointAccount.balance_amt} 원</td> --%>
										<td class="date"><fmt:formatDate value="${adminPointAccount.point_date}" pattern="YYYY-MM-dd" /></td>
										<td class="point_usage">${adminPointAccount.point_usage}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
					<ul id="pageList">
						<c:if test="${pageMaker.cri.pageNum > 1 }">
							<li class='pgi'>
								<a href="adminPointAccount?pageNum=${pageMaker.cri.pageNum - 1 }" class='allprev'><i class='fa fa-angle-double-left pgi' aria-hidden='true'></i></a>
							</li>
						</c:if>
						<c:if test="${pageMaker.cri.pageNum > 1 }">
							<li class='pgi'>
							<a href="adminPointAccount?pageNum=${pageMaker.cri.pageNum - 1 }" class='prev'><i class='fa fa-angle-left pgi' aria-hidden='true'></i></a>
							</li>
						</c:if>
						<c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage }">
							<c:choose>
								<c:when test="${pageMaker.cri.pageNum == num }">
									<li>
										<a href="adminPointAccount?pageNum=${num }" class='pageNum current'>${num }</a>
									</li>
								</c:when>
								<c:otherwise>
									<li>
										<a href="adminPointAccount?pageNum=${num }" class='pageNum'>${num }</a>
									</li>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						<c:if test="${pageMaker.endPage < pageMaker.realEnd || pageMaker.endPage > 1 && pageMaker.cri.pageNum < pageMaker.realEnd}">
							<li class='pgi'>
								<a href="adminPointAccount?pageNum=${pageMaker.cri.pageNum + 1 }" class='next'><i class='fa fa-angle-right pgi' aria-hidden='true'></i></a>
							</li>
						</c:if>
						<c:if test="${pageMaker.endPage < pageMaker.realEnd || pageMaker.endPage > 1 && pageMaker.cri.pageNum < pageMaker.realEnd}">
							<li class='pgi'>
								<a href="adminPointAccount?pageNum=${pageMaker.cri.pageNum + 1 }" class='allnext'><i class='fa fa-angle-double-right pgi' aria-hidden='true'></i></a>
							</li>
						</c:if>
					</ul>
				</div>
			</div>
		</section>
		<script type="text/javascript">
		$(document).ready(function() {
			$('.cont_li_wrap.dwList').show();
			$('.cont_item_list.pointList').addClass('active');
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