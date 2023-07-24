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
<link
	href="${pageContext.request.contextPath }/resources/css/admin/common.css"
	rel="stylesheet" type="text/css">
<link
	href="${pageContext.request.contextPath }/resources/css/admin/adminMain.css"
	rel="stylesheet" type="text/css">
<script type="text/javascript"
	src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>
</head>
<script
	src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>
<script type="text/javascript">
	
	let pageNum = 1; // 기본 페이지 번호 미리 저장
	let maxPage = 1; // 최대 페이지 번호 미리 저장
	
	$(function() {
	
		let searchType = $("#searchType").val();
		let searchKeyword = $("#searchKeyword").val();
// 		alert(searchType + ", " + searchKeyword);
		
		loadList(searchType, searchKeyword);
		
		
		$(window).on("scroll", function() { // 스크롤 동작 시 이벤트 처리

			let scrollTop = $(window).scrollTop(); // 스크롤바 현재 위치
			let windowHeight = $(window).height(); // 브라우저 창의 높이
			let documentHeight = $(document).height(); // 문서의 높이(창의 높이보다 크거나 같음)

			let x = 1;
			if(scrollTop + windowHeight + x >= documentHeight) {
			
				if(pageNum < maxPage) {
					pageNum++;
					loadList(searchType, searchKeyword);
				} else {
// 					alert("다음 페이지가 없습니다!");
				}
			}
			
		});
	});
	
	function loadList(searchType, searchKeyword) {
		let url;
	
		url = "BoardListJson?pageNum=" + pageNum + "&searchType=" + searchType + "&searchKeyword=" + searchKeyword;
		
		$.ajax({
			type: "GET",
			url: url,
			dataType: "json",
			success: function(data) {
// 			
				maxPage = data.maxPage; // 무한스크롤 다음 페이지 로딩 과정에서 페이지번호와 비교 시 활용
// 				console.log("maxPage = " + maxPage);
				
				for(board of data.boardList) {
					// board 객체의 board_re_lev 값이 0보다 크면
					// 제목열에 해당 값만큼 공백(&nbsp;) 추가 후 공백 뒤에 답글 아이콘 이미지(re.gif) 추가
					let space = "";
					if(board.board_re_lev > 0) {
						// 반복문을 사용하여 board_re_lev 값만큼 공백(&nbsp;) 추가
						for(let i = 0; i < board.board_re_lev; i++) {
// 							console.log("공백 추가");
							space += "&nbsp;&nbsp;";
						}
						
						// 반복문 종료 후 답글 아이콘 이미지 추가
						space += "<img src='${pageContext.request.contextPath }/resources/images/re.gif'>";
					}
					
					// 테이블에 표시할 JSON 객체 1개 출력문 생성(= 1개 게시물) => 반복
					let item = "<tr height='50'>"
								+ "<td>" + board.board_num + "</td>" 
								+ "<td id='subject'>"
									+ space
									+ "<a href='BoardDetail?board_num=" + board.board_num + "'>"
									+ board.board_subject 
									+ "</a>"
								+ "</td>" 
								+ "<td>" + board.board_name + "</td>" 
// 								+ "<td>" + board.board_date + "</td>" 
								+ "<td>" + getFormatDate(board.board_date) + "</td>" 
								+ "<td>" + board.board_readcount + "</td>" 
								+ "</tr>"
					$("table").append(item);
				}
				
			},
			error: function() {
				alert("글 목록 요청 실패!");
			}
		});
		
	}

		let targetDate = /(\d\d)(\d\d)-(\d\d)-(\d\d)\s(\d\d):(\d\d):(\d\d).(\d)/g;
		let formatDate = "$2-$3-$4 $5:$6";
		
		return date.replace(targetDate, formatDate); 
	}
</script>
<body>
	<aside>
		<jsp:include page="inc/sidebar.jsp"></jsp:include>
	</aside>


	<section id="admin_cont">
		<h1 class="con_title">공지사항</h1>
		<section id="board_wrap">
			<section id="board_list" class="notice">
				<form name="boardlist" id="boardlist" action="" method="get">
					<input type="hidden" name="pageNum"
						value="${pageMaker.cri.pageNum }"> <input type="hidden"
						name="amount" value="${pageMaker.cri.amount }">
					<div class="wrapper">
						<div class="list_wrap">
							<div class="search_wrap">
								<select name="searchType" id="searchType">
									<option value="title"
										<c:if test="${param.searchType eq 'title'}" >selected</c:if>>제목</option>
									<option value="content"
										<c:if test="${param.searchType eq 'content'}">selected</c:if>>내용</option>
									<option value="title_content"
										<c:if test="${param.searchType eq 'title_content'}">selected</c:if>>제목&내용</option>
								</select> <input type="text" name="searchKeyword"
									value="${param.searchKeyword}" id="searchKeyword"> <input
									type="submit" value="검색" class="searchSubmit">
							</div>
							<table id="adm_mem_list" class="adm_mem_list">
								<tr id="adm_mem_title">
									<td width="100px">글번호</td>
									<td width="100px">제목</td>
									<td width="100px">내용</td>
									<td width="100px">날짜</td>
									<td width="100px">조회수</td>
								</tr>
								<c:forEach var="noticeListP"  items="${noticeListP}">
									<tr>
										<td>${noticeListP.bo_idx}</td>
										<td>${noticeListP.bo_title}</td>
										<td>${noticeListP.bo_content}</td>
										<td>${noticeListP.bo_sysdate}</td>
										<td>${noticeListP.bo_readcount}</td>
									</tr>
								</c:forEach>
							</table>
							
							<!--  페이징 처리 -->
							<section id="pageList">

								<c:choose>
									<c:when test="${pageNum > 1 }">
										<input type="button" value="이전"
											onclick="location.href='BoardList?pageNum=${pageNum - 1}'">
									</c:when>
									<c:otherwise>
										<input type="button" value="이전" disabled="disabled">
									</c:otherwise>
								</c:choose>


								<c:forEach var="i" begin="${pageInfo.startPage }"
									end="${pageInfo.endPage }">

									<c:choose>
										<c:when test="${pageNum eq i }">
											<b>${i }</b>
										</c:when>
										<c:otherwise>
											<a href="BoardList?pageNum=${i }">${i }</a>
										</c:otherwise>
									</c:choose>
								</c:forEach>

								<c:choose>
									<c:when test="${pageNum < pageInfo.maxPage }">
										<input type="button" value="다음"
											onclick="location.href='BoardList?pageNum=${pageNum + 1}'">
									</c:when>
									<c:otherwise>
										<input type="button" value="다음" disabled="disabled">
									</c:otherwise>
								</c:choose>
							</section>
						</div>
						<div class="hanabutton">
							<button type="submit" class="btn btn-primary" onclick="">수정하기</button>
							<button type="button" class="btn btn-primary" onclick="">삭제하기</button>
						</div>
					</div>
				</form>
			</section>
		</section>
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