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
						DashBoard
					</a>
				</li>
				<li class="cont_item">
					<p class="cont_item_tit">회원</p>
					<ul class="cont_item_ul">
						<li class="cont_item_wrap">
							<a class="cont_item_a sub" href="#">
								<i class="fa fa-user" aria-hidden="true"></i>
								회원 관리
							</a>
							<ul class="cont_li_wrap">
								<li class="cont_item_b">
									<a class="cont_item_list" href="#">회원 목록 조회</a>
								</li>
							</ul>
						</li>
					</ul>
				</li>
				<li class="cont_item">
					<p class="cont_item_tit">게시글 관리</p>
					<ul class="cont_item_ul">
						<li class="cont_item_wrap">
							<a class="cont_item_a sub" href="#">
								<i class="fa fa-gavel" aria-hidden="true"></i>
								경매 관리
							</a>
							<ul class="cont_li_wrap">
								<li class="cont_item_b">
									<a class="cont_item_list" href="#">경매 상품 관리</a>
								</li>
								<li class="cont_item_b">
									<a class="cont_item_list" href="#">경매 상품 승인</a>
								</li>
							</ul>
						</li>
						<li class="cont_item_wrap">
							<a class="cont_item_a sub" href="#">
								<i class="fa fa-cubes" aria-hidden="true"></i>
								중고 관리
							</a>
							<ul class="cont_li_wrap">
								<li class="cont_item_b">
									<a class="cont_item_list" href="#">중고 상품 관리</a>
								</li>
							</ul>
						</li>
					</ul>
				</li>
				<li class="cont_item">
					<p class="cont_item_tit">페이 관리</p>
					<ul class="cont_item_ul">
						<li class="cont_item_wrap">
							<a class="cont_item_a sub" href="#">
								  <i class="fa fa-krw" aria-hidden="true"></i>
								계좌 관리
							</a>
							<ul class="cont_li_wrap">
								<li class="cont_item_b">
									<a class="cont_item_list" href="#">계좌 조회</a>
								</li>
							</ul>
						</li>
						<li class="cont_item_wrap">
							<a class="cont_item_a sub" href="#">
								<i class="fa fa-credit-card-alt" aria-hidden="true"></i>
								입출금 내역
							</a>
							<ul class="cont_li_wrap">
								<li class="cont_item_b">
									<a class="cont_item_list" href="#">포인트 입출금 내역</a>
								</li>
								<li class="cont_item_b">
									<a class="cont_item_list" href="#">거래 입출금 내역</a>
								</li>
							</ul>
						</li>
					</ul>
				</li>
				<li class="cont_item">
					<p class="cont_item_tit">고객센터</p>
					<ul class="cont_item_ul">
						<li class="cont_item_wrap">
							<a class="cont_item_a sub" href="#">
								 <i class="fa fa-bullhorn" aria-hidden="true"></i>
								신고 관리
							</a>
							<ul class="cont_li_wrap">
								<li class="cont_item_b">
									<a class="cont_item_list" href="#">신고 목록 조회</a>
								</li>
							</ul>
						</li>
						<li class="cont_item_wrap">
							<a class="cont_item_a sub" href="#">
								  <i class="fa fa-comments" aria-hidden="true"></i>
								1:1 문의
							</a>
							<ul class="cont_li_wrap">
								<li class="cont_item_b">
									<a class="cont_item_list" href="#">1:1 문의 조회</a>
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
									<a class="cont_item_list" href="#">공지사항 목록</a>
								</li>
							</ul>
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
