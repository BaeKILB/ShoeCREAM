<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath }/resources/css/member/common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/resources/css/member/mem_page/common.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/member/mem_page/question.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>
   <header>
		<jsp:include page="../../inc_ex/header.jsp" />
    </header>
	<div class="inq_container">
        <jsp:include page="../../inc_ex/mem_sidebar.jsp"></jsp:include>
	
	<c:set var="pageNum" value="1" />
	<c:if test="${not empty param.pageNum }">
		<c:set var="pageNum" value="${param.pageNum }" />	
	</c:if>
	
	<section id="admin_cont">
<!-- 		<h1 class="admin_tit">1:1 문의 조회</h1> -->
		<hr class="tit_line">
		<div class="question_cont">
			<div class="mem_list_wrap">
				<div class="search_wrap">
					<form action="${pageContext.request.contextPath }/mypage/questionList" method="get" class="searchForm">
						<select name="searchType" id="searchType">
							<option value="" <c:if test="${param.searchType eq '' }">selected</c:if>>전체검색</option>			
							<option value="거래신고" <c:if test="${param.searchType eq '거래신고' }">selected</c:if>>거래신고</option>			
							<option value="크림문의" <c:if test="${param.searchType eq '크림문의' }">selected</c:if>>크림문의</option>			
							<option value="회원/계정" <c:if test="${param.searchType eq '회원/계정' }">selected</c:if>>회원/계정</option>			
							<option value="계좌/포인트" <c:if test="${param.searchType eq '계좌/포인트' }">selected</c:if>>계좌/포인트</option>			
							<option value="판매광고" <c:if test="${param.searchType eq '판매광고' }">selected</c:if>>판매광고</option>			
							<option value="오류/신고/제안" <c:if test="${param.searchType eq '오류/신고/제안' }">selected</c:if>>오류/신고/제안</option>			
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
								<th scope="col">문의유형</th>
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
												<a href="${pageContext.request.contextPath }/mypage/questionDetail?qst_idx=${qstItem.qst_idx }&qst_board_re_ref=${qstItem.qst_board_re_ref }&pageNum=${pageNum }">
													<span>${qstItem.qst_subject }</span>
												</a>
											</td>
											<td><fmt:formatDate value="${qstItem.qst_date }" pattern="yy-MM-dd"/></td>
											<td>${qstItem.qst_type }</td>
											<td>
												<c:if test="${qstItem.ans_status eq 'N'}">
													<a href="" class="ins_ans moreBtn" readonly="readonly">
														답변중
													</a> 
												</c:if>
												<c:if test="${qstItem.ans_status eq 'Y'}">
													<a href="" class="mod_ans moreBtn" readonly="readonly">
														답변완료
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
				<div class="d-flex justify-content-end" style="margin-right: 50px;">
				    <a href="${pageContext.request.contextPath }/mypage/questionWrite" class="mod_ans moreBtn" style="background: #171818;">
				        문의작성
				    </a>
				</div>
				<ul id="pageList">
					<c:if test="${pageNum > 1 }">
						<li class='pgi'>
							<a href="InquiryList?pageNum=1" class='allprev'><i class='fa fa-angle-double-left pgi' aria-hidden='true'></i></a>
						</li>
					</c:if>
					<c:if test="${pageNum > 1 }">
						<li class='pgi'>
						<a href="InquiryList?pageNum=${pageNum - 1 }" class='prev'><i class='fa fa-angle-left pgi' aria-hidden='true'></i></a>
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
									<a href="InquiryList?pageNum=${i }" class='pageNum'>${i }</a>
								</li>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					<c:if test="${pageNum < pageInfo.maxPage }">
						<li class='pgi'>
							<a href="InquiryList?pageNum=${pageNum + 1 }" class='next'><i class='fa fa-angle-right pgi' aria-hidden='true'></i></a>
						</li>
					</c:if>
					<c:if test="${pageNum < pageInfo.maxPage }">
						<li class='pgi'>
							<a href="InquiryList?pageNum=${pageInfo.maxPage }" class='allnext'><i class='fa fa-angle-double-right pgi' aria-hidden='true'></i></a>
						</li>
					</c:if>
				</ul>
			</div>
		</div>
	</section>
	</div>
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