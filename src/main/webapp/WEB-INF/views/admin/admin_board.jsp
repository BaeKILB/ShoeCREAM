<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath }/resources/css/admin/common.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/admin/adminBoard.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>
</head>
<script type="text/javascript">
</script>
<body>
	<aside>
		<jsp:include page="inc/sidebar.jsp"></jsp:include>
	</aside>
		<section id="admin_cont">
			<h1 class="admin_tit">공지사항</h1>
			<hr class="tit_line">
			<div class="board_cont">
				<div class="board_list_wrap">
					<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }"> 
					<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
					<div class="search_wrap">
						<form name="boardlist" id="boardlist" action="" method="get">
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
									<th class="list_num">번호</th>
									<th class="txt_prev">
										<h4>제목</h4>
									</th>
									<th class="writter"><span class="writter_name">글쓴이</span></th>
									<th class="date">날짜</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="NoticeList" items="${noticeListP}">
									<tr>
										<td class="list_num">${NoticeList.bo_idx}</td>
										<td class="txt_prev"><a href="noticeDetail?pageNum=${pageMaker.cri.pageNum}&bo_idx=${NoticeList.bo_idx}">
											<h4 class=title_co>${NoticeList.bo_title}</h4>
											</a>
										</td>
										<td class="writter"><span class="writter_name"> <span class="sv_member">관리자</span></span></td>
										<td class="date"><fmt:formatDate value="${NoticeList.bo_sysdate}" pattern="YYYY-MM-dd" /></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
					<div class="write_btn">
						<%--<c:if test="${sessionScope.sId eq 'admin@admin.com'}"> --%>
						<div class="mod_box">
							<a href="noticeWriteForm" class="moreBtn">글쓰기</a>
						</div>
						<%-- </c:if> --%>
					</div>
					<ul id="pageList">
						<c:if test="${pageMaker.cri.pageNum > 1 }">
							<li class='pgi'>
								<a href="NoticeList?pageNum=${pageMaker.cri.pageNum - 1 }" class='allprev'><i class='fa fa-angle-double-left pgi' aria-hidden='true'></i></a>
							</li>
						</c:if>
						<c:if test="${pageMaker.cri.pageNum > 1 }">
							<li class='pgi'>
							<a href="NoticeList?pageNum=${pageMaker.cri.pageNum - 1 }" class='prev'><i class='fa fa-angle-left pgi' aria-hidden='true'></i></a>
							</li>
						</c:if>
						<c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage }">
							<c:choose>
								<c:when test="${pageMaker.cri.pageNum == num }">
									<li>
										<a href="NoticeList?pageNum=${num }" class='pageNum current'>${num }</a>
									</li>
								</c:when>
								<c:otherwise>
									<li>
										<a href="NoticeList?pageNum=${num }" class='pageNum'>${num }</a>
									</li>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						<c:if test="${pageMaker.endPage < pageMaker.realEnd || pageMaker.endPage > 1 && pageMaker.cri.pageNum < pageMaker.realEnd}">
							<li class='pgi'>
								<a href="" class='next'><i class='fa fa-angle-right pgi' aria-hidden='true'></i></a>
							</li>
						</c:if>
						<c:if test="${pageMaker.endPage < pageMaker.realEnd || pageMaker.endPage > 1 && pageMaker.cri.pageNum < pageMaker.realEnd}">
							<li class='pgi'>
								<a href="?pageNum=${pageMaker.cri.pageNum + 1 }" class='allnext'><i class='fa fa-angle-double-right pgi' aria-hidden='true'></i></a>
							</li>
						</c:if>
					</ul>
				</div>
			</div>
		</section>
	<script>
		$(document).ready(function() {
			$('.cont_li_wrap.notList').show();
			$('.cont_item_list.notList').addClass('active');
		});
		$(document).on('click', '.toggle_wrap', function() {
			if ($('#admin_cont').css('margin-left') === '0px') {
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