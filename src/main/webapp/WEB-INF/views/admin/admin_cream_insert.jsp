<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath }/resources/css/admin/common.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/admin/adminBoard.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/admin/adminCream.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
</head>
<body>
	<aside>
		<jsp:include page="inc/sidebar.jsp" ></jsp:include>
	</aside>
	<section id="admin_cont">
		<h1 class="admin_tit">크림 상품 등록</h1>
		<hr class="tit_line">
		<div class="board_cont">	
			<div class="board_list_wrap">
				
				등록폼자리
				
				
				
			</div>
		</div>
	</section>
	<script type="text/javascript">
		$(document).ready(function() {
			$('.cont_li_wrap.creamList').show();
			$('.cont_item_list.creamIns').addClass('active');
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