<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>구매자 정보</title>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/etc/bootstrap.bundle.min.js"></script>
<link href="${pageContext.request.contextPath }/resources/css/etc/bootstrap.min.css" rel="stylesheet">
<script>
$(function() {
    let address = "${deliveryInfo.address }";
    let addrArr = address.split("/");
    // 주소
    $("#addr1").val(addrArr[0]);
    $("#addr2").val(addrArr[1]);
    $("#addr3").val(addrArr[2]);
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
	        <label for="report_content" class="col-sm-2 col-form-label">구매자</label>
	        <div class="col-sm-10">
	            <input type="text" class="form-control-plaintext" value="${deliveryInfo.name }" readonly>
	        </div>
	    </div>
	    <div class="mb-3 row">
	        <label for="sellerNickName" class="col-sm-2 col-form-label">주소</label>
	        <div class="col-sm-10">
                <div class="container">
                    <div class="mb-3 row">
			            <label for="report_content" class="col-sm-2 col-form-label">우편번호</label>
			            <div class="col-sm-10">
			                <input type="text" class="form-control-plaintext" id="addr1" readonly>
			            </div>
			        </div>
                    <div class="mb-3 row">
			            <label for="report_content" class="col-sm-2 col-form-label">주소</label>
			            <div class="col-sm-10">
			                <input type="text" class="form-control-plaintext" id="addr2" readonly>
			            </div>
			        </div>
                    <div class="mb-3 row">
			            <label for="report_content" class="col-sm-2 col-form-label">상세주소</label>
			            <div class="col-sm-10">
			                <input type="text" class="form-control-plaintext" id="addr3" readonly>
			            </div>
			        </div>
                </div>
                
	        </div>
	    </div>
	    <div class="mb-3 row">
	        <label for="reporterNickName" class="col-sm-2 col-form-label">연락처</label>
	        <div class="col-sm-10">
	            <input type="text" class="form-control-plaintext" value="${deliveryInfo.phone }" readonly>
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
