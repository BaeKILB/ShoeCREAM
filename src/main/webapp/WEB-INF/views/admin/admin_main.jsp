<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath}/resources/css/admin/common.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/admin/adminMain.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.7.0.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/adm_dash.css">
</head>
<body>
	<aside>
		<jsp:include page="inc/sidebar.jsp"></jsp:include>
	</aside>
	<c:set var="pageNum" value="1" />
	<c:if test="${not empty param.pageNum }">
		<c:set var="pageNum" value="${param.pageNum }" />	
	</c:if>
	<section id="admin_cont">
		<div class="main_cont">
			<div class="main_cont_card member_count">
				<div class="card_cont">
					<div class="stat-text">
						<h4>전체 회원 수</h4>
					</div>
					<div class="stat-icon">
						<i class="fa fa-user-circle" aria-hidden="true"></i>
					</div>
				</div>
				<div class="card_cont">
					<h4 class="fw-bold">${memberCount }</h4>
				</div>
			</div>
			<div class="main_cont_card joong_count">
				<div class="card_cont">
					<div class="stat-text">
						<h4>중고 상품 수</h4>
					</div>
					<div class="stat-icon">
						<i class="fa fa-cubes" aria-hidden="true"></i>
					</div>
				</div>
				<div class="card_cont">
					<h4 class="fw-bold">${productCount }</h4>
				</div>
			</div>
			<div class="main_cont_card auction_count">
				<div class="card_cont">
					<div class="stat-text">
						<h4>경매 상품 수</h4>
					</div>
					<div class="stat-icon">
						<i class="fa fa-gavel" aria-hidden="true"></i>
					</div>
				</div>
				<div class="card_cont">
					<h4 class="fw-bold">${auctionCount }</h4>
				</div>
			</div>
			<div class="main_cont_card cream_count">
				<div class="card_cont">
					<div class="stat-text">
						<h4>크림 상품 수</h4>
					</div>
					<div class="stat-icon">
						<i class="fa fa-star" aria-hidden="true"></i>
					</div>
				</div>
				<div class="card_cont">
					<h4 class="fw-bold">${creamCount }</h4>
				</div>
			</div>
		</div>
		<div class="charts-container">
			<div class="chart-card">
				<div class="card">
					<div class="card-header">
						<h4 class="card-title">경매 상품 카테고리별 분석</h4>
					</div>
					<div class="card-body">
						<div id="auction_chart"></div>
						<script type="text/javascript"
							src="https://www.gstatic.com/charts/loader.js"></script>
						<script type="text/javascript">
		                    google.charts.load("current", { packages: ["corechart"] });
		                    google.charts.setOnLoadCallback(drawChart);
		
		                    function drawChart() {
		                        var data = new google.visualization.DataTable();
		                        data.addColumn('string', '상품카테고리');
		                        data.addColumn('number', '상품개수');
		                        data.addRows([
		                            ["${productList[0].category}", ${productList[0].count}],
		                            ["${productList[1].category}", ${productList[1].count}],
		                            ["${productList[2].category}", ${productList[2].count}]
		                        ]);
		
		                        var options = {
// 		                            title: '경매 상품 카테고리별 등록 수',
		                            is3D: true
		                        };
		
		                        var chart = new google.visualization.PieChart(document.getElementById('auction_chart'));
		                        chart.draw(data, options);
		                    }
               			</script>
					</div>
				</div>
			</div>
			<div class="chart-card">
				<div class="card">
					<div class="card-header">
						<h4 class="card-title">중고 상품 카테고리별 분석</h4>
					</div>
					<div class="card-body">
						<div id="product_chart"></div>
						<script type="text/javascript"
							src="https://www.gstatic.com/charts/loader.js"></script>
						<script type="text/javascript">
		                    google.charts.load("current", { packages: ["corechart"] });
		                    google.charts.setOnLoadCallback(drawChart);
		
		                    function drawChart() {
		                        var data = new google.visualization.DataTable();
		                        data.addColumn('string', '상품카테고리');
		                        data.addColumn('number', '상품개수');
		                        data.addRows([
		                            ["${auctionList[0].category}", ${auctionList[0].count}],
		                            ["${auctionList[1].category}", ${auctionList[1].count}],
		                            ["${auctionList[2].category}", ${auctionList[2].count}],
		                        ]);
		
		                        var options = {
// 		                            title: '중고 상품 카테고리별 등록 수',
		                            is3D: true
		                        };
		
		                        var chart = new google.visualization.PieChart(document.getElementById('product_chart'));
		                        chart.draw(data, options);
		                    }
              		 	 </script>
					</div>
				</div>
			</div>
		</div>
		<div class="qst_list charts-container">
			<div class="card-header">
				<h4 class="card-title">1:1 문의 조회</h4>
			</div>
			<div class="card-body">
				<div class="table_container">
					<table class="inq_list_table table">
						<thead>
							<tr>
								<th scope="col">글 번호</th>
								<th scope="col">이름</th>
								<th scope="col">제목</th>
								<th scope="col">작성일</th>
								<th scope="col">문의유형</th>
								<th scope="col">답변상태</th>
							</tr>
						</thead>
						<tbody class="tbody">
							<c:forEach var="qstItem" items="${qstList }">
								<c:choose>
									<c:when test="${qstItem.qst_board_re_seq eq 0}">
										<tr>
											<td>${qstItem.qst_idx }</td>
											<td>${qstItem.mem_name }</td>
											<td>
												<a href="QstBoardDetail?qst_idx=${qstItem.qst_idx }&qst_board_re_ref=${qstItem.qst_board_re_ref }&pageNum=${pageNum }">
													<span>${qstItem.qst_subject }</span>
												</a>
											</td>
											<td><fmt:formatDate value="${qstItem.qst_date }" pattern="yy-MM-dd"/></td>
											<td>${qstItem.qst_type }</td>
											<td>
												<c:if test="${qstItem.ans_status eq 'N'}">
													<a href="QstWriteForm?qst_idx=${qstItem.qst_idx }&pageNum=${pageNum }" class="ins_ans moreBtn">
														답변하기
													</a> 
												</c:if>
												<c:if test="${qstItem.ans_status eq 'Y'}">
													<a href="QstModifyForm?qst_idx=${qstItem.qst_idx }&pageNum=${pageNum }" class="mod_ans moreBtn">
														답변수정
													</a> 
												</c:if>
											</td>
										</tr>
									</c:when>
								</c:choose>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</section>
	<script type="text/javascript">
		$(document).ready(function() {
			$('.cont_item_a.adminMain').addClass('active');
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