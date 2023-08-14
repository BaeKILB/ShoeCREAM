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
							${creamRequestList }
					<table class="board_list_table table">
						<thead>
							<tr>
								<th>신청번호</th>
								<th>신청회원번호</th>
								<th>디자인코드</th>
								<th>디자인명</th>
								<th>사이즈</th>
								<th>결제가격</th>
								<th>신청일</th>
								<th>입고상태</th> 
								<th>주문상태</th>
								<th>상세보기</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="requestList" items="${creamRequestList }">
								<tr>
									<td>${requestList.request_idx }</td>
									<td>${requestList.mem_idx }</td>
									<td>${requestList.cream_idx }</td>
									<td>${requestList.cream_title }</td>
									<td>${requestList.cream_size }</td>
									<td>${requestList.cream_price }</td>
									<td>${requestList.request_time }</td>
									<td>
										<c:choose>
											<c:when test="${requestList.inbound_tracking_num eq null }">입고전</c:when>
											<c:when test="${requestList.inbound_delivery_status eq '배송완료' }">입고완료</c:when>
											<c:otherwise>
												<input type="hidden" name="t_key"  id="t_key" value="vmXicQZCzQaQetF3y0M0xg">
												<input type="hidden" name="t_code" id="t_code" value="${requestList.inbound_tracking_code }">
<%-- 												<input type="hidden" name="t_code" id="t_code" value="<c:if test="${requestList.inbound_tracking_company eq '대한통운' }">'04'</c:if>"> --%>
												<input type="hidden" name="t_invoice" id="t_invoice" value="${requestList.inbound_tracking_num }">
												<input  type="button" value="입고중" class="ins_ans moreBtn tracker">
											</c:otherwise>
										</c:choose>
									</td>
<!-- 									<td> -->
<!-- 											<input type="hidden" name="t_key"  id="t_key" value="vmXicQZCzQaQetF3y0M0xg"> -->
<%-- 											<input type="hidden" name="t_code" id="t_code" value="<c:if test="${requestList.tracking_company eq '대한통운' }">'04'</c:if>"> --%>
<%-- 											<input type="hidden" name="t_invoice" id="t_invoice" value="${requestList.tracking_num }"> --%>
<!-- 											<input id="tracker" type="button" value="배송조회" class="ins_ans moreBtn"> -->
<!-- 									</td> -->
									<td>
										<c:choose>
											<c:when test="${requestList.inbound_tracking_num eq null }">입고전</c:when>
											<c:when test="${requestList.inbound_delivery_status eq '배송완료' }">
											    <button type="button" class="ins_ans moreBtn" onclick="window.open('${pageContext.request.contextPath }/trackingRegisterForm2?cream_idx=${requestList.cream_idx}&request_idx=${requestList.request_idx }', '운송장 등록', 'width=580, height=360, left=100, top=50')">상품 준비중</button>
											</c:when>
											<c:when test="${requestList.delivery_status eq '배송중' }">
												<input type="hidden" name="t_key"  id="t_key" value="vmXicQZCzQaQetF3y0M0xg">
												<input type="hidden" name="t_code" id="t_code" value="${requestList.tracking_code }">
<%-- 												<input type="hidden" name="t_code" id="t_code" value="<c:if test="${requestList.inbound_tracking_company eq '대한통운' }">'04'</c:if>"> --%>
												<input type="hidden" name="t_invoice" id="t_invoice" value="${requestList.tracking_num }">
												<input  type="button" value="배송중" class="ins_ans moreBtn tracker">
											</c:when>
<%-- 											<c:otherwise> --%>
<%-- 											</c:otherwise> --%>
										</c:choose>
									</td>
									<td>
										<button type="button" class="ins_ans moreBtn" onclick="window.open('${pageContext.request.contextPath }/shippingDetail?cream_idx=${requestList.cream_idx}&request_idx=${requestList.request_idx }', '운송장 등록', 'width=580, height=360, left=100, top=50')">상세보기</button>
									</td>
								</tr>
							</c:forEach>
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
	 	$('.tracker').click(function() {
			let apikey = "vmXicQZCzQaQetF3y0M0xg";
			
			$.ajax({
				type:"GET",
				url: "http://info.sweettracker.co.kr/api/v1/companylist?t_key=" + apikey,
				dataType: "JSON",
				success: function(data) {
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