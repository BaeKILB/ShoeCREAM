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
<link href="${pageContext.request.contextPath }/resources/css/admin/common.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
$(function() {
	companyList();
})

const apiKey = 'U0pjDTd6JAAZAtgvTEJPsQ';

const companyList = () => {
	$.ajax({
		type: "get"
		, url: "http://info.sweettracker.co.kr/api/v1/companylist"
		, data: {'t_key': apiKey}
	    , dataType: "json"
        , success: function(data) {
            for(let company of data.Company) {
                if(company.International == 'false') {
	            	let result = 
	            		"<option value='"+company.Name+"'>"+company.Name
	            		+"<input type='hidden' value='"+company.Code+"'>"
	            		+"</option>";
	            	
	            	$("#companySelectBox").append(result);
                }
            }	
        }
        , error: function(data) {
        	if (data.code == '101') {
        		console.log(data.msg);
        	} else if(data.code == '404') {
        		console.log(data.msg);
        	} else if(data.code == '500') {
        		console.log(data.msg);
        	}
        	let result = "<option>조회 오류</option>"
        	$("#companySelectBox").append(result);
        }
	});
};

function selectCompany(value) {
    $("#tracking_company").val(value);
    let code = $("option[value="+value+"]").children('input').val();
    $("#tracking_code").val(code);
};

//입찰하기 버튼 클릭
function trackingSubmit() {
    if($("#tracking_number").val() == '') {
        alert("운송장번호를 입력해주세요");
        $("#tracking_number").focus();
        return false;
    } else if ($("tracking_company").val() == '') {
        alert("택배회사를 선택해주세요");
        $("#companySelectBox").focus();
        return false;
    }
    
    $.ajax({ // 입찰 ajax
        type: "get"
        , url: "http://info.sweettracker.co.kr/api/v1/trackingInfo"
        , dataType: "json"
        , data: {
            't_code': $("#tracking_code").val()
            , 't_invoice': $("#tracking_number").val()
            , 't_key': apiKey
        }
        , success: function(data) {
        	if(data.code == '104' || data.code == '106') {
                alert("유효하지 않은 운송장 번호 입니다.");
                $("#tracking_number").val('').focus();
            } else {
	        	$("form").submit();
            }
        }
        , error: function(data) {
            console.log(data.msg);        	
        }
        
    })
}
</script>
</head>
<body>
	<main class="container">
		<div class="row mb-3">
			<div class="col text-center">
				<h1>운송장 정보</h1>
			</div>
		</div>
		<div class="row mb-3">
			<div class="col">
				<form action="trackingRegister2" method="post" class="container bg-light rounded-3">
					<input type="hidden" name="cream_idx" value="${cream.cream_idx }">
					<input type="hidden" name="request_idx" value="${request_idx }">
					<div class="mb-3 row">
						<label for="auction_title" class="col-sm-2 col-form-label">상품명</label>
						<div class="col-sm-10">
							<input type="text" class="form-control-plaintext" id="auction_title" value="${cream.cream_title }" readonly>
						</div>
					</div>
					<div class="mb-3 row">
						<label for="tracking_company" class="col-sm-2 col-form-label">택배사</label>
						<div class="col-sm-4">
							<input type="text" class="form-control fs-6" id="tracking_company" name="tracking_company" required readonly>
							<input type="hidden" id="tracking_code" name="tracking_code">
						</div>
						<div class="col-sm-4">
							<select class="form-select form-select-sm mb-3" id="companySelectBox" onchange="selectCompany(this.value)">
							     <option value="">택배사를 선택해주세요.</option>
							</select>
						</div>
					</div>
					<div class="mb-3 row">
						<label for="tracking_number" class="col-sm-2 col-form-label">운송장번호</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="tracking_number" name="tracking_number">
						</div>
					</div>
					<div class="mb-3 row justify-content-center">
						<div class="col-2 m-3">
							<button type="button" class="btn btn-secondary" onclick="trackingSubmit()">등록</button>
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