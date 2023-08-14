<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath }/resources/css/admin/common.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/admin/admin_question.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>
	<aside>
		<jsp:include page="inc/sidebar.jsp" ></jsp:include>
	</aside>
	
	<c:set var="pageNum" value="1" />
	<c:if test="${not empty param.pageNum }">
		<c:set var="pageNum" value="${param.pageNum }" />	
	</c:if>
	
	<section id="admin_cont">
		<h1 class="admin_tit">계좌 조회</h1>
		<hr class="tit_line">
		<div class="question_cont">
			<div class="mem_list_wrap">
				<div class="search_wrap">
					<form action="AccountCheck" method="get" class="searchForm">
						<select name="searchType" id="searchType">
							<option value="" <c:if test="${param.searchType eq '' }">selected</c:if>>전체검색</option>			
							<option value="회원번호" <c:if test="${param.searchType eq '회원번호' }">selected</c:if>>회원번호</option>			
							<option value="계좌번호" <c:if test="${param.searchType eq '계좌번호' }">selected</c:if>>계좌번호</option>			
						</select>
						<input type="text" name="searchKeyword" value="${param.searchKeyword }" id="searchKeyword">
						<input type="submit" value="검색" class="searchSubmit" style="cursor: pointer;">
					</form>
				</div>
				<div class="table_container">
					<table class="inq_list_table table">
						<thead>
							<tr>
								<th scope="col">계좌 고유 번호</th>
								<th scope="col">회원 번호</th>
								<th scope="col">회원 이름</th>
								<th scope="col">사용자 일련 번호</th>
								<th scope="col">은행 코드</th>
								<th scope="col">계좌 번호</th>
								<th scope="col">금융사용자번호</th>
							</tr>
						</thead>
						<tbody class="tbody">
							<c:forEach var="account" items="${memberAccount }">
								<tr>
									<td>${account.mem_account_idx }</td>
									<td>${account.mem_idx }</td>
									<td>${account.mem_name }</td>
									<td>${account.mem_seq_no }</td>
									<td>${account.bank_code_std }</td>
									<td>${account.account_num }</td>
									<td>${account.fintech_use_num }</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
				<ul id="pageList">
					<c:if test="${pageNum > 1 }">
						<li class='pgi'>
							<a href="AccountCheck?pageNum=1" class='allprev'><i class='fa fa-angle-double-left pgi' aria-hidden='true'></i></a>
						</li>
					</c:if>
					<c:if test="${pageNum > 1 }">
						<li class='pgi'>
						<a href="AccountCheck?pageNum=${pageNum - 1 }" class='prev'><i class='fa fa-angle-left pgi' aria-hidden='true'></i></a>
						</li>
					</c:if>
					<c:forEach var="i" begin="${pageInfo.startPage }" end="${pageInfo.endPage }">
						<c:choose>
							<c:when test="${pageNum eq i }">
								<li>
									<a href="#" class='pageNum current'>${i }</a>
								</li>
							</c:when>
							<c:otherwise>
								<li>
									<a href="AccountCheck?pageNum=${i }" class='pageNum'>${i }</a>
								</li>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					<c:if test="${pageNum < pageInfo.maxPage }">
						<li class='pgi'>
							<a href="AccountCheck?pageNum=${pageNum + 1 }" class='next'><i class='fa fa-angle-right pgi' aria-hidden='true'></i></a>
						</li>
					</c:if>
					<c:if test="${pageNum < pageInfo.maxPage }">
						<li class='pgi'>
							<a href="AccountCheck?pageNum=${pageInfo.maxPage }" class='allnext'><i class='fa fa-angle-double-right pgi' aria-hidden='true'></i></a>
						</li>
					</c:if>
				</ul>
			</div>
		</div>
	</section>
	
	<script type="text/javascript">
		$(document).ready(function() {
			$('.cont_li_wrap.accList').show();
			$('.cont_item_list.accList').addClass('active');
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