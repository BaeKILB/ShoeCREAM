<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath }/resources/css/admin/common.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

</head>
<body>
<form action="creamRefundPro" method="post">
	<input type="hidden" name="cream_idx" value="${map.cream_idx }">
	<input type="hidden" name="mem_idx" value="${map.mem_idx }">

	<main class="container bg-light">
	    <div class="row mb-3">
	        <div class="col text-center">
	            <h1>환불정보</h1>
	        </div>
	    </div>
	    <div class="mb-3 row">
	        <label for="recipient_name" class="col-sm-2 col-form-label">구매 상품</label>
	        <div class="col-sm-10">
	            <input type="text" class="form-control-plaintext" value="${map.cream_title }" readonly>
	        </div>
	    </div>
	    <div class="mb-3 row">
	        <label for="recipient_phone" class="col-sm-2 col-form-label">사이즈</label>
	        <div class="col-sm-10">
	            <input type="text" class="form-control-plaintext" value="${map.cream_size }" readonly>
	        </div>
	    </div>
	    <div class="mb-3 row">
	        <label for="delivery_request" class="col-sm-2 col-form-label">결제 금액</label>
	        <div class="col-sm-10">
	            <input type="text" class="form-control-plaintext" value="${map.cream_price }" readonly>
	        </div>
	    </div>
	    <div class="mb-3 row justify-content-center">
		    <div class="col-2 m-3">
		        <button type="submit" class="btn btn-secondary" >환불하기</button>
		        <button type="button" class="btn btn-secondary" onclick="window.close()">닫기</button>
		    </div>
		</div>
	</main>
</form>
</body>
</html>