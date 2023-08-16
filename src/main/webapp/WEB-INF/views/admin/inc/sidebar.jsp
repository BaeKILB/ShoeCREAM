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
				<a href="AdminMain" class="logo_img">
					<img alt="logo" src="resources/img/admin/admin-logo.png" class="logo" >
				</a>
			</div>
			<ul class="cont_list">
				<li class="cont_item_wrap adminMain">
					<a class="cont_item_a nSub adminMain" href="AdminMain">
						<i class="fa fa-home" aria-hidden="true"></i>
						메인페이지
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
							<ul class="cont_li_wrap memList">
								<li class="cont_item_b">
									<a class="cont_item_list memList" href="AdminMember">회원 목록 조회</a>
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
							<ul class="cont_li_wrap aucList">
								<li class="cont_item_b">
									<a class="cont_item_list aucPro" href="auctionProduct">경매 상품 관리</a>
								</li>
							</ul>
						</li>
						<li class="cont_item_wrap">
							<a class="cont_item_a sub" href="#">
								<i class="fa fa-cubes" aria-hidden="true"></i>
								중고 관리
							</a>
							<ul class="cont_li_wrap joongList">
								<li class="cont_item_b">
									<a class="cont_item_list joongPro" href="adminProduct">중고 상품 관리</a>
								</li>
							</ul>
						</li>
						<li class="cont_item_wrap">
							<a class="cont_item_a sub" href="#">
								<i class="fa fa-star" aria-hidden="true"></i>
								커스텀 관리
							</a>
							<ul class="cont_li_wrap creamList">
								<li class="cont_item_b">
									<a class="cont_item_list creamIns" href="creamInsert">커스텀 상품 등록</a>
								</li>
								<li class="cont_item_b">
									<a class="cont_item_list creamPro" href="creamProduct">커스텀 상품 관리</a>
								</li>
								<li class="cont_item_b">
									<a class="cont_item_list creamApp" href="creamApply">커스텀 상품 신청 내역</a>
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
							<ul class="cont_li_wrap accList">
								<li class="cont_item_b">
									<a class="cont_item_list accList" href="AccountCheck">계좌 조회</a>
								</li>
							</ul>
						</li>
						<li class="cont_item_wrap">
							<a class="cont_item_a sub" href="#">
								<i class="fa fa-credit-card-alt" aria-hidden="true"></i>
								입출금 내역
							</a>
							<ul class="cont_li_wrap dwList">
								<li class="cont_item_b">
									<a class="cont_item_list pointList" href="adminPointAccount">포인트 입출금 내역</a>
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
							<ul class="cont_li_wrap reportList">
								<li class="cont_item_b">
									<a class="cont_item_list jrepList" href=reportProcess>중고 신고 목록 조회</a>
								</li>
								<li class="cont_item_b">
									<a class="cont_item_list arepList" href="auctionReport">경매 신고 목록 조회</a>
								</li>
							</ul>
						</li>
						<li class="cont_item_wrap">
							<a class="cont_item_a sub" href="#">
								<i class="fa fa-comments" aria-hidden="true"></i>
								1:1 문의
							</a>
							<ul class="cont_li_wrap inqList">
								<li class="cont_item_b">
									<a class="cont_item_list inqList" href="InquiryList">1:1 문의 조회</a>
								</li>
							</ul>
						</li>
						<li class="cont_item_wrap">
							<a class="cont_item_a sub" href="#">
								<i class="fa fa-th-list" aria-hidden="true"></i>
								공지사항
							</a>
							<ul class="cont_li_wrap notList">
								<li class="cont_item_b">
									<a class="cont_item_list notList" href="NoticeList">공지사항 목록</a>
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
			$('.cont_li_wrap').not($(this).siblings('.cont_li_wrap')).slideUp();
		    $(this).siblings('.cont_li_wrap').slideToggle();
		    $(this).toggleClass('rotate');
		});
// 		$('.cont_item_list').click(function() {
// 			$(this).addClass('active');
// 			$('.cont_item_list').not(this).removeClass('active');
// 			$('.cont_item_a.nSub').not(this).removeClass('active');
// 		});
// 		$('.cont_item_a.nSub').click(function() {
// 			$(this).addClass('active');
// 			$('.cont_item_list').not(this).removeClass('active');
// 			$('.cont_item_a.nSub').not(this).removeClass('active');
// 		});
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
