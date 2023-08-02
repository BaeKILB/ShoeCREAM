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
		<h1 class="admin_tit">1:1 문의 조회</h1>
		<hr class="tit_line">
		<div class="question_cont">
			<div class="mem_list_wrap">
				<div class="search_wrap">
					<form action="InquiryList" method="get" class="searchForm">
						<select name="searchType" id="searchType">
							<option value="" <c:if test="${param.searchType eq '' }">selected</c:if>>전체검색</option>			
							<option value="deal_report" <c:if test="${param.searchType eq 'deal_report' }">selected</c:if>>거래신고</option>			
							<option value="cream_inquiry" <c:if test="${param.searchType eq 'cream_inquiry' }">selected</c:if>>크림문의</option>			
							<option value="member_account" <c:if test="${param.searchType eq 'member_account' }">selected</c:if>>회원/계정</option>			
							<option value="account_point" <c:if test="${param.searchType eq 'account_manage' }">selected</c:if>>계좌/포인트</option>			
							<option value="sell_advers" <c:if test="${param.searchType eq 'sell_advers' }">selected</c:if>>판매광고</option>			
							<option value="error_report" <c:if test="${param.searchType eq 'error_report' }">selected</c:if>>오류/신고/제안</option>			
						</select>
						<input type="submit" value="검색" class="searchSubmit" style="cursor: pointer;">
					</form>
				</div>
				<div class="table_container">
					<table class="inq_list_table table">
						<thead>
							<tr>
								<th scope="col">글 번호</th>
								<th scope="col">이름</th>
								<th scope="col">제목</th>
								<th scope="col">작성일</th>
								<th scope="col">답변상태</th>
							</tr>
						</thead>
						<tbody class="tbody">
							<c:forEach var="qstItem" items="${qstList }">
								<c:choose>
									<c:when test="${qstItem.qst_board_re_seq eq 0}">
										<tr>
											<td>${qstItem.qst_idx }</td>
											<td>${qstItem.mem_name }</td>
											<td>
												<a href="QstBoardDetail?qst_idx=${qstItem.qst_idx }&qst_board_re_ref=${qstItem.qst_board_re_ref }&pageNum=${pageNum }">
													<span>${qstItem.qst_subject }</span>
												</a>
											</td>
											<td><fmt:formatDate value="${qstItem.qst_date }" pattern="yy-MM-dd"/></td>
											<td>
												<c:if test="${qstItem.ans_status eq 'N'}">
													<a href="QstWriteForm?qst_idx=${qstItem.qst_idx }&pageNum=${pageNum }">
														답변하기
													</a> 
												</c:if>
												<c:if test="${qstItem.ans_status eq 'Y'}">
													<a href="">
														답변수정
													</a> 
												</c:if>
											</td>
										</tr>
									</c:when>
								</c:choose>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
			<ul id="pageList">
				<c:if test="${pageNum > 1 }">
					<li class='pgi'>
						<a href="" class='allprev'><i class='fa fa-angle-double-left pgi' aria-hidden='true'></i></a>
					</li>
				</c:if>
				<c:if test="${pageNum > 1 }">
					<li class='pgi'>
					<a href="" class='prev'><i class='fa fa-angle-left pgi' aria-hidden='true'></i></a>
					</li>
				</c:if>
				<c:forEach var="i" begin="${pageInfo.startPage }" end="${pageInfo.endPage }">
				<%-- 각 페이지마다 하이퍼링크 설정(단, 현재 페이지는 하이퍼링크 제거) --%>
					<c:choose>
						<c:when test="${pageNum eq i }">
							<li>
								<a href="" class='pageNum current'>${i }</a>
							</li>
						</c:when>
						<c:otherwise>
							<li>
								<a href="" class='pageNum'>${i }</a>
							</li>
						</c:otherwise>
					</c:choose>
					<c:if test="${pageNum < pageInfo.maxPage }">
						<li class='pgi'>
							<a href="" class='next'><i class='fa fa-angle-right pgi' aria-hidden='true'></i></a>
						</li>
					</c:if>
					<c:if test="${pageNum < pageInfo.maxPage }">
						<li class='pgi'>
							<a href="" class='allnext'><i class='fa fa-angle-double-right pgi' aria-hidden='true'></i></a>
						</li>
					</c:if>
				</c:forEach>
			</ul>
		</div>
	</section>
	
	<script type="text/javascript">
		$(document).ready(function() {
			$('.cont_li_wrap.inqList').show();
			$('.cont_item_list.inqList').addClass('active');
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