<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>구매자 정보</title>
<link href="${pageContext.request.contextPath }/resources/css/admin/common.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/etc/bootstrap.bundle.min.js"></script>
<link href="${pageContext.request.contextPath }/resources/css/etc/bootstrap.min.css" rel="stylesheet">
<script>
$(function() {
    let address = "${deliveryInfo.delivery_address }";
    let addrArr = address.split("/");
    // 주소
    $("#delivery_address1").val(addrArr[0]);
    $("#delivery_address2").val(addrArr[1]);
    $("#delivery_address3").val(addrArr[2]);
});
</script>
</head>
<body>
	<main class="container bg-light">
	    <div class="row mb-3">
	        <div class="col text-center">
	            <h1>배송지 정보</h1>
	        </div>
	    </div>
	    <div class="mb-3 row">
	        <label for="recipient_name" class="col-sm-2 col-form-label">구매자</label>
	        <div class="col-sm-10">
	            <input type="text" class="form-control-plaintext" value="${deliveryInfo.recipient_name }" readonly>
	        </div>
	    </div>
	    <div class="mb-3 row">
	        <label for="delivery_address" class="col-sm-2 col-form-label">주소</label>
	        <div class="col-sm-10">
                <div class="container">
                    <div class="mb-3 row">
			            <label for="delivery_address1" class="col-sm-2 col-form-label">우편번호</label>
			            <div class="col-sm-10">
			                <input type="text" class="form-control-plaintext" id="delivery_address1" readonly>
			            </div>
			        </div>
                    <div class="mb-3 row">
			            <label for="delivery_address2" class="col-sm-2 col-form-label">주소</label>
			            <div class="col-sm-10">
			                <input type="text" class="form-control-plaintext" id="delivery_address2" readonly>
			            </div>
			        </div>
                    <div class="mb-3 row">
			            <label for="delivery_address3" class="col-sm-2 col-form-label">상세주소</label>
			            <div class="col-sm-10">
			                <input type="text" class="form-control-plaintext" id="delivery_address3" readonly>
			            </div>
			        </div>
                </div>
                
	        </div>
	    </div>
	    <div class="mb-3 row">
	        <label for="recipient_phone" class="col-sm-2 col-form-label">연락처</label>
	        <div class="col-sm-10">
	            <input type="text" class="form-control-plaintext" value="${deliveryInfo.recipient_phone }" readonly>
	        </div>
	    </div>
	    <div class="mb-3 row">
	        <label for="delivery_request" class="col-sm-2 col-form-label">요청사항</label>
	        <div class="col-sm-10">
	            <input type="text" class="form-control-plaintext" value="${deliveryInfo.delivery_request }" readonly>
	        </div>
	    </div>
	    <div class="mb-3 row justify-content-center">
		    <div class="col-2 m-3">
		        <button type="button" class="btn btn-secondary" onclick="window.close()">닫기</button>
		    </div>
		</div>
	</main>
</body>
</html>
