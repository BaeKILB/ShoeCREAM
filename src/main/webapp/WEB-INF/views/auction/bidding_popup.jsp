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



	// 시간
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
                <span>${bid.bid_price }원 </span>
                <span>즉시구매가 : </span>
                <span>${auction.auc_buy_instantly }원</span>
            </div>
		</div>
		<div>
			<!-- 올리는 단위 정하기ㅏ 보증금 정하기 -->
			<c:set var="minimumBid" value="${bid.bid_price + auction.auc_bid_unit}" />
            <div>입찰 금액 (입찰단위 ${auction.auc_bid_unit} 원)</div>
            <input type="number" id="bid_price" name="bid_price" step="${auction.auc_bid_unit}" min="${minimumBid}" placeholder="현재 가격은 ${bid.bid_price }원 입니다" oninput="calculateGuaranteeAmount()" required>원
			
			
			
			<!-- 보증금 입찰 금액의 10퍼 -->
            <div>보증금</div>
			<input type="text" id="guarantee_amount" name="deposit" readonly>원
			<input type="button" value="보증금 결제하기" onclick="">
		</div>
		<input type="submit" value="입찰하기(테스트용)" onclick="location.href='close'" >
		<!-- <input type="button" value="입찰하기" onclick="placeBid()" id="bidButton" disabled> -->
		<!-- 보증금 결제 로직 완료되면 사용하기 -->
    </form>
</main>
</body>
</html>