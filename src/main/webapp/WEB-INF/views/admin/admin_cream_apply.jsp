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
		<h1 class="admin_tit">크림 상품 관리</h1>
		<hr class="tit_line">
		<div class="board_cont">	
			<div class="board_list_wrap">
				<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }"> 
				<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
				<div class="search_wrap">
					<form action="creamApply" method="get" class="searchForm">
						<select name="searchType" id="searchType">
							<option value="cream_idx" <c:if test="${param.searchType eq 'cream_idx'}">selected</c:if>>디자인 번호</option>
						</select>
						<input type="text" name="searchKeyword" value="${param.searchKeyword }" id="searchKeyword">
						<input type="submit" value="검색" class="searchSubmit" style="cursor: pointer;">
					</form>
				</div>
				<div class="table_container">
					<table class="board_list_table table">
						<thead>
							<tr>
								<th>신청회원번호</th>
								<th>디자인코드</th>
								<th>디자인명</th>
								<th>사이즈</th>
								<th>결제가격</th>
								<th>신청일</th>
								<th>배송조회</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>1</td>
								<td>홍길동</td>
								<td>P001</td>
								<td>에어포스 커스텀</td>
								<td>NIKE</td>
								<td>AIRFORCE 1</td>
								<td>1</td>
								<td>배송중</td>
								<td>
										<input type="hidden" name="t_key"  id="t_key">
										<input type="hidden" name="t_code" id="t_code">
										<input type="hidden" name="t_invoice" id="t_invoice">
										<input id="tracker" type="button" value="배송조회" class="ins_ans moreBtn">
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</section>
	<script type="text/javascript">
		$(document).ready(function() {
			$('.cont_li_wrap.creamList').show();
			$('.cont_item_list.creamApp').addClass('active');
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
	<script>
	 	$('#tracker').click(function() {
			let apikey = "vmXicQZCzQaQetF3y0M0xg";
			
			$.ajax({
				type:"GET",
				url: "http://info.sweettracker.co.kr/api/v1/companylist?t_key=" + apikey,
				dataType: "JSON",
				success: function(data) {
					console.log(data);
					$("#t_key").val(apikey);
					$("#t_code").val('04');
					$("#t_invoice").val('831000843336');
					
					let t_key = $("#t_key").val();
					let t_code = $("#t_code").val();
					let t_invoice = $("#t_invoice").val();
					window.open("http://info.sweettracker.co.kr/tracking/4?t_key="+t_key+"&t_code="+t_code+"&t_invoice="+t_invoice ,"popForm", "toolbar=no, width=540, height=800 left=700 top=100, directories=no, status=no, resizable=no");
				}, error: function() {
					
				}
			});
		})
	</script>
</body>
</html>