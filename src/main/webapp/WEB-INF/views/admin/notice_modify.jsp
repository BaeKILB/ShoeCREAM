<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath }/resources/css/admin/common.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/admin/adminMain.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>
</head>
<body>
	<aside>
		<jsp:include page="inc/sidebar.jsp" ></jsp:include>
	</aside>
	<section id="admin_cont">
		<section id="sec_con" class="inr">
			<h1 class="con_title">공지사항</h1>
			<form action="noticeModifyPro" method="post">
				<input type="hidden" name="bo_idx" value="${noticeDetail.bo_idx}">
				<input type="hidden" name="pageNum" value="${cri.pageNum }">
				<section id="board_wrap">
					<section id="board_list" class="notice">
						<div class="wrapper">
							<div class="list_wrap">
								<ul class="list">
									<li>
										<div class="title">
											<input type="text" class="inputBox" name="bo_title" value="${noticeDetail.bo_title }">
										</div>
									</li>
								</ul>
								<div class="write_cont">
									<p>
										<textarea rows="" cols="" class="inputBox" name="bo_content">${noticeDetail.bo_content }</textarea>
									</p>
								</div>
								<div class="mod_box">
									<input type="submit" class="submit_btn" value="등록">
								</div>
							</div>
						</div>
					</section>
				</section>
			</form>
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