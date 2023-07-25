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
			<form action="noticeWritePro" method="post">
				<section id="board_wrap">
					<section id="board_list" class="notice">
						<div class="wrapper">
							<div class="list_wrap">
								<ul class="list">
									<li>
										<div class="subject">
											<input type="text" placeholder="제목을 입력해주세요" class="inputBox" name="bo_title">
										</div>
									</li>
								</ul>
								<div class="write_cont">
									<p>
										<textarea style="white-space: pre-line;" class="inputBox" placeholder="내용을 입력해주세요" name="bo_content" required="required"></textarea>
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