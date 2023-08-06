<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>입찰 팝업</title>
<script type="text/javascript"
   src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/etc/bootstrap.bundle.min.js"></script>
<script type="text/javascript">

//보증금
function calculateGuaranteeAmount() {
    const bidPrice = parseFloat(document.getElementById("bid_price").value);
    const guaranteeAmount = bidPrice * 0.1; // 입찰 금액의 10%
    document.getElementById("guarantee_amount").value = guaranteeAmount.toFixed(0);
}

function bidUnit() {
    const bidPriceInput = document.getElementById("bid_price");
    const bidPrice = parseFloat(bidPriceInput.value);
    const bidUnit = "${auction.auc_bid_unit}";
    const minimumBid = "${bid.bid_price + auction.auc_bid_unit}";
    const guaranteeAmountInput = document.getElementById("guarantee_amount");

    if (bidPrice % parseFloat(bidUnit) !== 0 || bidPrice<minimumBid) {
        alert(bidUnit + "원 단위로, \n"+minimumBid+"원 이상의 값을 입력해주세요.");
        bidPriceInput.value = ''; // 입력값 초기화
        guaranteeAmountInput.value = ''; // 보증금 값 초기화
        bidPriceInput.focus(); 
    }
}


	// 시간
	const updateTimer = () => {
	    const future = Date.parse($("#auc_close_date").val());
	    const now = new Date();
	    const diff = future - now;
	    
	    if (diff < 0) {
	        $("#acdBox").html("경매 마감");
	    } else {
	        const days = Math.floor(diff / (1000 * 60 * 60 * 24));
	        const hours = Math.floor(diff / (1000 * 60 * 60));
	        const mins = Math.floor(diff / (1000 * 60));
	        const secs = Math.floor(diff / 1000);
	        
	        const d = days;
	        const h = hours - days * 24;
	        const m = mins - hours * 60;
	        const s = secs - mins * 60;
	        
	        let result =  
	        '<span>' + d + '<span>일</span>' +
	        '<span>' + h + '<span>시</span>' +
	        '<span>' + m + '<span>분</span>' +
	        '<span>' + s + '<span>초</span>';
	        
	        $("#acdBox").html(result);
	    }
	}
	
	// 시간 반복
	setInterval(() => {
	    updateTimer()   
	}, 1000);


	//입찰하기 버튼 클릭
	function bidConfirmation(event) {
	    // 사용자에게 확인을 받기 위한 컨펌창 표시
	    var confirmBid = confirm("입찰을 진행하시겠습니까? 입찰 후에는 취소가 불가능합니다.");

	    if (confirmBid) {
	        // 폼을 서버로 제출합니다.
	        document.getElementById("biddingForm").submit();
	        
	        // 현재 창 닫기
	        closeCurrentWindow();

	        // 부모 창 새로고침
	        refreshParentWindow();
	    }
	}
	
	function closeCurrentWindow() {
	    // 현재 창 닫기
	    window.close();
	}
	
	function refreshParentWindow() {
	    // 부모 창 새로고침
	    if (window.opener && !window.opener.closed) {
	        window.opener.location.reload();
	    }
	}
</script>
<link href="${pageContext.request.contextPath }/resources/css/etc/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<main class="container">
<!-- 입찰하기 버튼 누르는 경우 이동할 페이지, 
보여줄 메세지 (가격이랑 끝나는날 이후 경쟁자 생기면 알람 주겟다는거?) -->
	<div class="row"> <!-- 경매 제목 행 -->
		<div class="col">
			<div class="display-4 fw-bold text-center">경매 입찰</div>
			<hr>
		</div>
	</div>
	<div class="row">
		<div class="col">
			<div class="fs-5 fw-bold">상품정보</div>
		</div>
	</div>
	<div class="row">
		<div class="col-3">
		    <div class="text-center">상품명</div>
		</div>
		<div class="col-6">
		    <div>${auction.auction_title }</div>
		</div>
	</div>
	<div class="row">
		<div class="col-3">
			<div class="text-center">남은시간</div>
		</div>
		<div class="col-6">
			<div id="acdBox"></div>
		</div>
	</div>
	<div class="row">
		<div class="col-3">
			<div class="text-center">현재가</div>
		</div>
		<div class="col-6">
               <c:choose>
               	<c:when test="${bid eq null }">
					<div>${auction.auc_start_price }원</div>                	
               	</c:when>
               	<c:otherwise>
	                <div>${bid.bid_price }원</div>
               	</c:otherwise>
               </c:choose>
		</div>
	</div>
	<div class="row">
		<div class="col-3">
			<div class="text-center">즉시구매가</div>
		</div>
		<div class="col-6">
			<div>${auction.auc_buy_instantly }원</div>
		</div>
	</div>
	<div class="row">
		<div class="col-3">
			<div class="text-center">입찰 단위</div>
		</div>
		<div class="col-6">
			<div>${auction.auc_bid_unit}원</div>		
		</div>
	</div>
	<hr>
    <form method="post" action="biddingPro">
		<input type="hidden" value="${auction.auction_idx }"  name="auction_idx">
		<input type="hidden" value="${bid.bid_price }"  id="old_bid_price">
		<input type="hidden" value="${auction.auc_close_date }" id="auc_close_date">
		<div class="container">
			<div class="row">
				<div class="col">
					<div class="fs-5 fw-bold">입찰</div>
				</div>
			</div>
			<div class="row">
				<label for="bid_price" class="col-form-label col-3">입찰금액</label>
				<c:choose>
				    <c:when test="${bid eq null }">
				    	<c:set var="minimumBid" value="${auction.auc_start_price }" />
						<input type="number" class="form-control col" id="bid_price" name="bid_price" step="${auction.auc_bid_unit}" min="${minimumBid}" max="${auction.auc_buy_instantly }" placeholder="현재 가격은 ${auction.auc_start_price }원 입니다" oninput="calculateGuaranteeAmount()"  onchange="bidUnit()" required>
				    </c:when>
				    <c:otherwise>
				    	<c:set var="minimumBid" value="${bid.bid_price + auction.auc_bid_unit}" />
						<input type="number" class="form-control col" id="bid_price" name="bid_price" step="${auction.auc_bid_unit}" min="${minimumBid}" max="${auction.auc_buy_instantly }" placeholder="현재 가격은 ${bid.bid_price }원 입니다" oninput="calculateGuaranteeAmount()" onchange="bidUnit()" required>
				    </c:otherwise>
				</c:choose>
			</div>
			<div class="row">
				<!-- 보증금 입찰 금액의 10퍼 -->
				<label class="col-form-label col-3">보증금</label>
				<input type="text" class="form-control-plaintext form-control col" id="guarantee_amount" name="deposit">
			</div>
			<div class="row justify-content-center">
				<div class="col-2">
					<input type="submit" class="btn btn-secondary" value="입찰하기" onclick="bidConfirmation()" >
				</div>
				<div class="col-2">
					<input type="reset" class="btn btn-secondary" value="초기화" onclick="location.reload()" >
				</div>
				<div class="col-2">
					<input type="button" class="btn btn-secondary" value="닫기" onclick="close()" >
				</div>
			</div>
		</div>
		<!-- <input type="button" value="입찰하기" onclick="placeBid()" id="bidButton" disabled> -->
		<!-- 보증금 결제 로직 완료되면 사용하기 -->
    </form>
</main>
</body>
</html>