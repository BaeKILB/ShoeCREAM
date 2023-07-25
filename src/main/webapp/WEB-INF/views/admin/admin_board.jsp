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
<!-- 							<ul class="list"> -->

								<table>
									<tr class="list_head">
										<th class="list_num">번호</th>
										<th class="txt_prev">
											<h4>제목</h4>
										</th>
										<th class="writter"><span class="writter_name">글쓴이</span></th>
										<th class="date">날짜</th>
									</tr>
									<c:forEach var="NoticeList" items="${noticeListP}">
										<tr class="list_cont">
											<td class="list_num">${NoticeList.bo_idx}</td>
											<td class="txt_prev"><a
												href="noticeDetail?pageNum=${pageMaker.cri.pageNum}&bo_idx=${NoticeList.bo_idx}">
													<h4>${NoticeList.bo_title}</h4>
											</a></td>
											<td class="writter"><span class="writter_name"><span
													class="sv_member">관리자</span></span></td>
											<td class="date"><fmt:formatDate
													value="${NoticeList.bo_sysdate}" pattern="YY-MM-dd" /></td>
										</tr>
									</c:forEach>
								</table>
								<div class="write_btn">
<%-- 									<c:if test="${sessionScope.sId eq 'admin@admin.com'}"> --%>
										<a href="noticeWriteForm">글쓰기</a>
<%-- 									</c:if> --%>
								</div>
								<div class="list_pager_wrap">
									<nav class="pg_wrap">
										<span class="pg">
											<c:if test="${pageMaker.cri.pageNum > 1 }">											
												<a href="NoticeList?pageNum=${pageMaker.cri.pageNum - 1 }" class="pg_page pg_prev" >이전</a>
											</c:if>
											<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="num">
													<c:choose>
														<c:when test="${pageMaker.cri.pageNum == num }">
															<strong class="pg_current">${num}</strong>
														</c:when>
														<c:otherwise>
															<a href="NoticeList?pageNum=${num }" class="pg_page">${num }</a>
														</c:otherwise>
													</c:choose>
											</c:forEach>
											<c:if test="${pageMaker.endPage < pageMaker.realEnd || pageMaker.endPage > 1 && pageMaker.cri.pageNum < pageMaker.realEnd}">											
												<a href="NoticeList?pageNum=${pageMaker.cri.pageNum + 1 }" class="pg_page pg_next" >다음</a>
											</c:if>
										</span>
									</nav>
								</div>
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