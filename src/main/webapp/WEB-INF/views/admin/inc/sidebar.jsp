<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath }/resources/css/admin/adminSidebar.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>

	<div class="sidebar_wrap">
		<div class="sidebar_cont">
			<div class="logo_box">
				<a href="" class="logo_img">
					<img alt="logo" src="resources/img/admin/admin-logo.png" class="logo">
				</a>
			</div>
			<ul class="cont_list">
				<li class="cont_item_wrap">
					<a class="cont_item_a nSub" href="#">
						<i class="fa fa-home" aria-hidden="true"></i>
						메인페이지
					</a>
				</li>
				<li class="cont_item">
					<ul class="cont_item_ul">
						<li class="cont_item_wrap">
							<a class="cont_item_a sub" href="#">
								<i class="fa fa-user" aria-hidden="true"></i>
								회원 관리
							</a>
							<ul class="cont_li_wrap">
								<li class="cont_item_b">
									<a class="cont_item_list" href="#">Profile</a>
								</li>
								<li class="cont_item_b">
									<a class="cont_item_list" href="#">settings</a>
								</li>
							</ul>
						</li>
						<li class="cont_item_wrap">
							<a class="cont_item_a sub" href="#">
								<i class="fa fa-bullhorn" aria-hidden="true"></i>
								신고 관리
							</a>
							<ul class="cont_li_wrap">
								<li class="cont_item_b">
									<a class="cont_item_list" href="#">Sign In</a>
								</li>
								<li class="cont_item_b">
									<a class="cont_item_list" href="#">Sign Up</a>
								</li>
							</ul>
						</li>
						<li class="cont_item_wrap">
							<a class="cont_item_a sub" href="#">
								 <i class="fa fa-cubes" aria-hidden="true"></i>
								크림
							</a>
							<ul class="cont_li_wrap">
								<li class="cont_item_b">
									<a class="cont_item_list" href="#">Sign In</a>
								</li>
								<li class="cont_item_b">
									<a class="cont_item_list" href="#">Sign Up</a>
								</li>
							</ul>
						</li>
					</ul>
				</li>
				<li class="cont_item_wrap">
							<a class="cont_item_a sub" href="#">
								 <i class="fa fa-comments" aria-hidden="true"></i>
								1:1문의게시판
							</a>
							<ul class="cont_li_wrap">
								<li class="cont_item_b">
									<a class="cont_item_list" href="#">Sign In</a>
								</li>
								<li class="cont_item_b">
									<a class="cont_item_list" href="#">Sign Up</a>
								</li>
							</ul>
						</li>
						<li class="cont_item_wrap">
							<a class="cont_item_a sub" href="#">
								<i class="fa fa-th-list" aria-hidden="true"></i>
								공지사항
							</a>
							<ul class="cont_li_wrap">
								<li class="cont_item_b">
									<a class="cont_item_list" href="#">Sign In</a>
								</li>
								<li class="cont_item_b">
									<a class="cont_item_list" href="#">Sign Up</a>
								</li>
							</ul>
						</li>
						<li class="cont_item_wrap">
							<a class="cont_item_a sub" href="#">
								 <i class="fa fa-krw" aria-hidden="true"></i>
								결제(페이)
							</a>
							<ul class="cont_li_wrap">
								<li class="cont_item_b">
									<a class="cont_item_list" href="#">Sign In</a>
								</li>
								<li class="cont_item_b">
									<a class="cont_item_list" href="#">Sign Up</a>
								</li>
							</ul>
						</li>
						<li class="cont_item_wrap">
							<a class="cont_item_a sub" href="#">
								<i class="fa fa-clipboard" aria-hidden="true"></i>
								게시글관리
							</a>
							<ul class="cont_li_wrap">
								<li class="cont_item_b">
									<a class="cont_item_list" href="#">Sign In</a>
								</li>
								<li class="cont_item_b">
									<a class="cont_item_list" href="#">Sign Up</a>
								</li>
							</ul>
						</li>
					</ul>
				</div>
			</div>
	<script>
		$('.cont_item_a').click(function () {
		    $(this).siblings('.cont_li_wrap').slideToggle();
		    $(this).toggleClass('rotate');
		});
		$('.cont_item_list').click(function() {
			$(this).addClass('active');
			$('.cont_item_list').not(this).removeClass('active');
			$('.cont_item_a.nSub').not(this).removeClass('active');
		});
		$('.cont_item_a.nSub').click(function() {
			$(this).addClass('active');
			$('.cont_item_list').not(this).removeClass('active');
			$('.cont_item_a.nSub').not(this).removeClass('active');
		});
	</script>
	<div class="header_wrap">
		<nav class="header">
			<a class="toggle_wrap" href="#">
				<i class="fa fa-bars" aria-hidden="true"></i>
			</a>
		</nav>
	</div>
	<script>

		$('.toggle_wrap').click(function() {
			var headerWrap = $('.header_wrap');
			var sidebarWrap = $('.sidebar_wrap');
			if (headerWrap.css('margin-left') === '0px') {
				sidebarWrap.css('margin-left', '0');
				headerWrap.show().animate({
					marginLeft : '15.625rem'
				}, 200);
			} else {
				sidebarWrap.css('margin-left', '-100%');
				headerWrap.show().animate({
					marginLeft : '0'
				}, 200);
			}
		});
	</script>
</body>
</html>
