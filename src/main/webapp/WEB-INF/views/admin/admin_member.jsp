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
<link href="${pageContext.request.contextPath }/resources/css/admin/adminMember.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>
<!-- 토스트 그리드 -->
</head>
<script type="text/javascript">
	let pageNum = 1; // 기본 페이지 번호 미리 저장
	let maxPage = 1; // 최대 페이지 번호 미리 저장
	
	$(function() {
		let searchType = $("#searchType").val();
		let searchKeyword = $("#searchKeyword").val();
		loadList(searchType, searchKeyword);
		
		function loadList(searchType, searchKeyword) {
			let url;
			url = "AdminMemberList?pageNum=" + pageNum + "&searchType=" + searchType + "&searchKeyword=" + searchKeyword;
			
			$.ajax({
				type: "GET",
				url: url,
				dataType: "json",
				success: function(data) {
					maxPage = data.maxPage;
					
					for(let member of data.MemberList) {
						$('tbody').append(
								"<tr>"
								+ "<td>"+ member.mem_idx +"</td>"
								+ "<td>"+ member.mem_id +"</td>"
								+ "<td>"+ member.mem_name +"</td>"
								+ "<td>"+ member.mem_nickname +"</td>"
								+ "<td>"+ member.mem_mtel +"</td>"
								+ "<td>"+ getFormatDate(member.mem_birthday) +"</td>"
								+ "<td>"+ member.mem_rank +"</td>"
								+ "<td><button style='cursor: pointer;' class='moreBtn'>상세정보</button></td>"
								+ "</tr>"
						);
					}
				},
				error: function(MemberList) {
					alert('글 목록 요청 실패');
				}
			});
		}
		
		function getFormatDate(date) {
			let targetDate = /^(\d{4})-(\d{2})-(\d{2}).*/;
			let formatDate = "$1-$2-$3";
			return date.replace(targetDate, formatDate);
		}
		
	});
</script>
<body>
	<aside>
		<jsp:include page="inc/sidebar.jsp" ></jsp:include>
	</aside>
	<c:set var="pageNum" value="1" />
	
	<c:if test="${not empty param.pageNum }">
		<c:set var="pageNum" value="${param.pageNum }" />	
	</c:if>
	
	<section id="admin_cont">
		<h1 class="admin_tit">회원 목록 조회</h1>
		<hr class="tit_line">
		<div class="member_cont">
			<div class="mem_list_wrap">
				<div class="search_wrap">
					<form action="AdminMember" method="get" class="searchForm">
						<select name="searchType" id="searchType">
							<option value="mem_id" <c:if test="${param.searchType eq 'mem_id' }">selected</c:if>>아이디</option>			
							<option value="mem_name" <c:if test="${param.searchType eq 'mem_name' }">selected</c:if>>이름</option>			
							<option value="mem_nickname" <c:if test="${param.searchType eq 'mem_nickname' }">selected</c:if>>닉네임</option>			
							<option value="mem_rank" <c:if test="${param.searchType eq 'mem_rank' }">selected</c:if>>등급</option>			
						</select>
						<input type="text" name="searchKeyword" value="${param.searchKeyword }" id="searchKeyword">
						<input type="submit" value="검색" class="searchSubmit">
					</form>
				</div>
				<div class="table_container">
					<table class="mem_list_table table">
						<thead>
							<tr>
								<th scope="col">회원번호</th>
								<th scope="col">아이디</th>
								<th scope="col">이름</th>
								<th scope="col">닉네임</th>
								<th scope="col">연락처</th>
								<th scope="col">생년월일</th>
								<th scope="col">등급</th>
								<th scope="col">상세정보</th>
							</tr>
						</thead>
						<tbody>
<!-- 							<tr> -->
<!-- 								<td>1</td> -->
<!-- 								<td>hong</td> -->
<!-- 								<td>홍길동</td> -->
<!-- 								<td>길똥이</td> -->
<!-- 								<td>010-1234-5678</td> -->
<!-- 								<td>2000-05-05</td> -->
<!-- 								<td>SILVER</td> -->
<!-- 								<td> -->
<!-- 									<button style="cursor: pointer;" class="moreBtn">상세정보</button> -->
<!-- 								</td> -->
<!-- 							</tr> -->
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</section>
	<script>
		$(document).ready(function() {
			$('.cont_li_wrap.memList').show();
			$('.cont_item_list.memList').addClass('active');
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