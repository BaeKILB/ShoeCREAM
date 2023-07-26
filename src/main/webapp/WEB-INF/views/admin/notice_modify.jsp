<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath }/resources/css/admin/common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/resources/css/admin/adminBoard.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/admin/notice_modify.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>
</head>
<body>
	<aside>
		<jsp:include page="inc/sidebar.jsp"></jsp:include>
	</aside>
		<section id="admin_cont">
			<h1 class="admin_tit">공지사항</h1>
			<hr class="tit_line">
			<div class="board_cont">
				<div class="board_list_wrap">
					<form action="noticeModifyPro" method="post">
						<input type="hidden" name="bo_idx" value="${noticeDetail.bo_idx}">
						<input type="hidden" name="pageNum" value="${cri.pageNum }">
						<section id="board_wrap">
							<section id="board_list" class="notice">
								<div class="wrapper">
									<div class="list_wrap">
										<div>
											<div class="dropdown_head">
												<input type="text" class="inputBox" name="bo_title" value="${noticeDetail.bo_title }">
											</div>
										</div>
										<div class="write_cont">
											<p>
												<textarea rows="" cols="" class="inputBox" name="bo_content">${noticeDetail.bo_content }</textarea>
											</p>
										</div>
										<div class="mod_box">
											<input type="submit" class="moreBtn" value="등록">
										</div>
									</div>
								</div>
							</section>
						</section>
					</form>
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