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
</head>
<body>
<main>
<!-- 입찰하기 버튼 누르는 경우 이동할 페이지, 
보여줄 메세지 (가격이랑 끝나는날 이후 경쟁자 생기면 알람 주겟다는거?) -->
<h1>경매 입찰</h1>
${auction}
    <hr>
${bid }
    <form method="post" action="biddingPro">
		<input type="hidden" value="${auction.auction_idx }"  name="auction_idx">
		<input type="hidden" value="${bid.bid_price }"  id="old_bid_price">
		<input type="hidden" value="${auction.auc_close_date }" id="auc_close_date">
		<div>
		    <div>입찰 상품</div>
			<hr>
			<div>
			    <span>상품명 : </span>
			    <span>${auction.auction_title }</span>
			</div>
			<div>
			    <span>경매 마감일자 : </span>
			    <span id="acdBox"></span>
			</div>
		</div>
		<div>
            <div>입찰 하기</div>
            <hr>
            <div>
                <span>현재가 : </span>
                <c:choose>
                	<c:when test="${bid eq null }">
						<span>${auction.auc_start_price }원</span>                	
                	</c:when>
                	<c:otherwise>
		                <span>${bid.bid_price }원 </span>
                	</c:otherwise>
                </c:choose>
                <span>즉시구매가 : </span>
 				<span>${auction.auc_buy_instantly }원 </span>            </div>
		</div>
		<div>
			<!-- 올리는 단위 정하기ㅏ 보증금 정하기 -->
			<c:choose>
				<c:when test="${bid eq null }">
					<c:set var="minimumBid" value="${auction.auc_start_price }" />
				</c:when>
				<c:otherwise>
					<c:set var="minimumBid" value="${bid.bid_price + auction.auc_bid_unit}" />
				</c:otherwise>
			</c:choose>
            <div>입찰 금액 (입찰단위 ${auction.auc_bid_unit} 원)</div>
<%--             <input type="number" id="bid_price" name="bid_price" step="${auction.auc_bid_unit}" min="${minimumBid}" max="${auction.auc_buy_instantly }" placeholder="현재 가격은 ${bid.bid_price }원 입니다" oninput="calculateGuaranteeAmount()" onchange=bidUnit() required>원 --%>
			
				<c:choose>
				    <c:when test="${bidCount eq null }">
				    	<c:set var="minimumBid" value="${auction.auc_start_price + auction.auc_bid_unit }" />
           				 <input type="number" id="bid_price" name="bid_price" step="${auction.auc_bid_unit}" min="${minimumBid}" max="${auction.auc_buy_instantly }" placeholder="현재 가격은 ${auction.auc_start_price }원 입니다" oninput="calculateGuaranteeAmount()"  onchange="bidUnit()" required>원
				    </c:when>
				    <c:otherwise>
				    	<c:set var="minimumBid" value="${bid.bid_price + auction.auc_bid_unit}" />
           				 <input type="number" id="bid_price" name="bid_price" step="${auction.auc_bid_unit}" min="${minimumBid}" max="${auction.auc_buy_instantly }" placeholder="현재 가격은 ${bid.bid_price }원 입니다" oninput="calculateGuaranteeAmount()" onchange="bidUnit()" required>원
				    </c:otherwise>
				</c:choose>
			
			<!-- 보증금 입찰 금액의 10퍼 -->
            <div>보증금</div>
			<input type="text" id="guarantee_amount" name="deposit" readonly>원
			<input type="button" value="보증금 결제하기" onclick="">
		</div>
		<input type="submit" value="입찰하기(테스트용)" onclick="bidConfirmation()" >
		<!-- <input type="button" value="입찰하기" onclick="placeBid()" id="bidButton" disabled> -->
		<!-- 보증금 결제 로직 완료되면 사용하기 -->
    </form>
</main>
</body>
</html>