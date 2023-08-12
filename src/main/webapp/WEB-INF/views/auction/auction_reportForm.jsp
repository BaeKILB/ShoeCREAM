<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/etc/bootstrap.bundle.min.js"></script>
<link href="${pageContext.request.contextPath }/resources/css/etc/bootstrap.min.css" rel="stylesheet">
<script type="text/javascript">
function reportDiv(value){
	if (value == "") {
		$("#report_div").removeAttr('readonly');
	} else {
		$("#report_div").attr('readonly','readonly');
	}
	$("#report_div").val(value);
}
</script>
</head>
<body>
	<main class="container">
		<div class="row mb-3">
			<div class="col text-center">
				<h1>신고 등록 기본 정보</h1>
			</div>
		</div>
		<div class="row mb-3">
			<div class="col">
				<form action="registAuctionReport" method="post" class="container bg-light rounded-3">
					<input type="hidden" name="auction_idx" value="${auction.auction_idx }">
					<input type="hidden" name="seller_idx" value="${seller.mem_idx }">
					<input type="hidden" name="reporter_idx" value="${reporter.mem_idx }">
					<div class="mb-3 row">
						<label for="report_content" class="col-sm-2 col-form-label">상품명</label>
						<div class="col-sm-10">
							<input type="text" class="form-control-plaintext" id="report_content" name="report_content" value="${auction.auction_title }" readonly>
						</div>
					</div>
					<div class="mb-3 row">
						<label for="sellerNickName" class="col-sm-2 col-form-label">판매자</label>
						<div class="col-sm-10">
							<input type="text" class="form-control-plaintext" id="sellerNickName" value="${seller.mem_nickname }" readonly>
						</div>
					</div>
					<div class="mb-3 row">
						<label for="reporterNickName" class="col-sm-2 col-form-label">신고자</label>
						<div class="col-sm-10">
							<input type="text" class="form-control-plaintext" id="reporterNickName" value="${reporter.mem_nickname }" readonly>
						</div>
					</div>
					<div class="mb-3 row">
						<label for="report_div" class="col-sm-2 col-form-label">신고유형</label>
						<div class="col-sm-4">
							<input type="text" class="form-control fs-6" id="report_div" name="report_div" required>
						</div>
						<div class="col-sm-4">
							<select name="report_div" class="form-select form-select-sm mb-3" onchange="reportDiv(this.value)">
								<option value="" selected>기타(직접입력)</option>
								<option value="광고성 콘텐츠">광고성 콘텐츠</option>
								<option value="허위 상품">허위 상품</option>
								<option value="거래 금지 품목">거래 금지 품목</option>							
								<option value="안전거래 거부">안전거래 거부</option>
								<option value="사기 의심">사기 의심</option>
								<option value="개인 정보 유출 위험">개인 정보 유출 위험</option>
							</select>
						</div>
					</div>
					<div class="mb-3 row">
						<div class="col-sm-10">
							<div class="form-floating">
								<div class="mb-3">
									<label for="report_detail" class="form-label">신고사유</label>
									<textarea class="form-control" id="report_detail" name="report_detail" rows="5" required></textarea>
								</div>
							</div>
						</div>
					</div>
					<div class="mb-3 row justify-content-center">
						<div class="col-2 m-3">
							<button type="submit" class="btn btn-secondary">등록</button>
						</div>
						<div class="col-2 m-3">
							<button type="button" class="btn btn-secondary" onclick="window.close()">닫기</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</main>
</body>
</html>