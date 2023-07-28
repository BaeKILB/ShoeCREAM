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
	<section id="admin_cont">
		<h1 class="admin_tit">1:1 문의 조회</h1>
		<hr class="tit_line">
		<div class="question_cont">
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
							<tr>
								<td>${qstItem.qst_idx }</td>
								<td>${qstItem.mem_name }</td>
								<td>
									<c:if test="${qstItem.qst_board_re_lev > 0 }">
										<c:forEach var="qstList" begin="0" end="${qstItem.qst_board_re_lev }">
											&nbsp;
										</c:forEach>
									</c:if>
									<a href="QstBoardDetail?qst_idx=${qstItem.qst_idx }">
										<span>${qstItem.qst_subject }</span>
										<c:if test="${qstItem.qst_board_re_lev > 0 }">
											 에 대한 답변 
										</c:if>
									</a>
								</td>
								<td><fmt:formatDate value="${qstItem.qst_date }" pattern="yy-MM-dd"/> </td>
								<td>
									<c:if test="${qstItem.qst_board_re_lev == 0 }">
										<button>
											답변하기
										</button> 
									</c:if>
									<c:if test="${qstItem.qst_board_re_lev > 1 }">
										답변 완료
									</c:if>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<ul id="pageList">
				
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