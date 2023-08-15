<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link href="${pageContext.request.contextPath }/resources/css/admin/common.css" rel="stylesheet" type="text/css">

<style>
    body {
        background-color: #f8f9fa;
    }
    .container {
        background-color: #fff;
        padding: 20px;
        border-radius: 5px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        margin-top: 30px;
    }
    .container h1 {
        font-size: 24px;
        margin-bottom: 20px;
    }
    .col-form-label {
        font-weight: bold;
    }
    .btn-light.btn-half-height {
        background-color: #f8f9fa;
        border-color: #f8f9fa;
        height: 25px;
        padding: 0.375rem 0.75rem;
        font-size: 0.875rem;
    }
</style>

</head>
<body>
	<main class="container bg-light">
	    <div class="row mb-3">
	        <div class="col text-center">
	            <h1>배송지 정보</h1>
	        </div>
	    </div>
	    <div class="mb-3 row">
	        <label for="recipient_name" class="col-sm-2 col-form-label">받는사람</label>
	        <div class="col-sm-10">
	            <span>${map.customer_name }</span>
	        </div>
	    </div>
	    <div class="mb-3 row">
	        <label for="recipient_phone" class="col-sm-2 col-form-label">연락처</label>
	        <div class="col-sm-10">
	        	<span>${map.customer_phone}</span>
	        </div>
	    </div>
	    <div class="mb-3 row">
	        <label for="recipient_phone" class="col-sm-2 col-form-label">주소</label>
	        <div class="col-sm-10">
	        	<span>${map.shipping_address }</span>
	        </div>
	    </div>
	    <div class="mb-3 row">
	        <label for="delivery_request" class="col-sm-2 col-form-label">요청사항</label>
	        <div class="col-sm-10">
	        	<span>${map.shipping_memo }</span>
	        </div>
	    </div>
	    <br>
	    <div class="mb-3 row justify-content-center">
		    <div class="col-6 mt-3">
                <button type="button" class="btn btn-light btn-half-height" onclick="window.open('${pageContext.request.contextPath }/trackingRegisterForm2?cream_idx=${creamList.cream_idx}&request_idx=${creamList.request_idx }', '구매자정보', 'width=580, height=360, left=100, top=50')">운송장 등록</button>
                <button type="button" class="btn btn-light btn-half-height ml-2" onclick="window.close()">닫기</button>
            </div>
		</div>
	</main>
	
</body>
</html>