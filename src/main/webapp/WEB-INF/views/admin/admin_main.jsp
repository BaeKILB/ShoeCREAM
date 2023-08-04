<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
	<section id="admin_cont">
		<div class="main_count">
			<div class="member_count">
				<i class="fa fa-user-circle" aria-hidden="true"></i>
				<div class="stat-text">전체 회원 수</div>
				<div class="stat-digit">${memberCount }</div>
			</div>
			<div class="joong_count">
				<i class="fa fa-cubes" aria-hidden="true"></i>
				<div class="stat-text">중고 상품 수</div>
				<div class="stat-digit">${productCount }</div>
			</div>
			<div class="auction_count">
				<i class="fa fa-gavel" aria-hidden="true"></i>
				<div class="stat-text">경매 상품 수</div>
				<div class="stat-digit">${auctionCount }</div>
			</div>
			<div class="cream_count">
				<i class="fa fa-star" aria-hidden="true"></i>
				<div class="stat-text">크림 상품 수</div>
				<div class="stat-digit">${creamCount }</div>
			</div>
		</div>
		<div class="charts-container">
			<div class="chart-card">
				<div class="card">
					<div class="card-header">
						<h4 class="card-title">경매 상품 카테고리별 분석</h4>
					</div>
					<div class="card-body">
						<div id="auction_chart" style="width: 700px; height: 500px;"></div>
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
                            title: '경매 상품 카테고리별 등록 수',
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
						<div id="product_chart" style="width: 700px; height: 500px;"></div>
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
                            title: '중고 상품 카테고리별 등록 수',
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