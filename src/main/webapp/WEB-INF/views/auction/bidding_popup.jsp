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

<script type="text/javascript">
//입찰금액은 현재가 보다 커야한다
function calculateGuaranteeAmount() {
	  const currentBidPrice = ${bid_price}; // 현재가 가져오기
	  const bidInput = document.getElementById("bid_price");
	  const enteredBidPrice = parseInt(bidInput.value, 10);

	  if (enteredBidPrice <= currentBidPrice) {
	    alert("입찰 금액은 현재가보다 커야 합니다.");
	    bidInput.value = ""; // 잘못된 금액 입력 시 값을 초기화
	    bidInput.focus(); // 포커스를 다시 입력 상자로 이동
	    return;
	  }

	  // 입력된 금액이 현재가보다 크면 다른 작업을 수행하거나 폼을 제출할 수 있습니다.
	  // 이곳에 원하는 로직을 추가하세요.
	}

//보증금 자동계산 js

function calculateDepositeAmount() {
  // 입찰 금액을 가져옵니다.
  const bidPriceInput = document.getElementById("bid_price");
  const bidPrice = parseFloat(bidPriceInput.value);

  // 보증금을 계산하고 입력 상자에 표시합니다.
  const guaranteeAmountInput = document.getElementById("guarantee_amount");
  const guaranteeAmount = bidPrice * 0.1; // 입찰 금액의 10%
  guaranteeAmountInput.value = guaranteeAmount.toFixed(0); // 소수점 이하 반올림
}

// 초기화: 페이지 로드 시 보증금 칸에 초기 값으로 0을 표시합니다.
document.addEventListener("DOMContentLoaded", () => {
  document.getElementById("guarantee_amount").value = "0";
}); 
     
     
//보증금 결제 되어야 입찰하기 버튼 활성화
// function payGuarantee() {
//     // 보증금 결제 로직을 구현합니다. (여기서는 가정으로 alert 창을 사용합니다.)
//     alert("보증금을 결제해주세요!");

//     // 보증금이 결제되면 "입찰하기" 버튼을 활성화합니다.
//     document.getElementById("bidButton").disabled = false;
//   }

//   function placeBid() {
//     // 입찰하기 버튼 클릭 시 처리 로직을 구현합니다.
//     // 이 부분은 입찰이 성공했을 때 실행되어야 할 내용을 넣어주시면 됩니다.
//     alert("입찰이 완료되었습니다!");
//   }
  
  

  
  

</script>
</head>
<body>
<!-- 입찰하기 버튼 누르는 경우 이동할 페이지, 
보여줄 메세지 (가격이랑 끝나는날 이후 경쟁자 생기면 알람 주겟다는거?) -->
<h1>경매 입찰</h1>
${auction}
<form method="post" action="biddingPro">
<input type="hidden" value="${auction.auction_idx }"  name="auction_idx">
<h3>입찰 상품</h3>   
<hr>
<h4>상품명 : ${auction.auction_title }</h4>
<h4>경매 마감일자 : ${auction.auc_close_date }</h4>
<!-- <h4>최대 구매 가능 수량 : 1 개</h4> -->

<h3>입찰하기</h3>   
<hr>
<h4>현재가 : ${bid_price }원 | 즉시구매가 :${auction.auc_buy_instantly }원</h4>
<!-- <h4>입찰 수량</h4> <input type="text" >개 -->
<!-- 입찰 수량은 판매 수량보다 클수없게 제약 -->
<h4>입찰 금액</h4> 
<input type="text" id="bid_price" name="bid_price" oninput="calculateDepositeAmount()" onchange="calculateGuaranteeAmount()" required>원

<!-- 올리는 단위 정하기ㅏ 보증금 정하기 -->
<h4>보증금 </h4> 
<input type="text" id="guarantee_amount" name="deposit" readonly>원
<input type="button" value="보증금 결제하기" onclick="">
<!-- 보증금 입찰 금액의 10퍼 -->
<br>
<input type="submit" value="입찰하기(테스트용)" onclick="location.href='close'" >
<!-- <input type="button" value="입찰하기" onclick="placeBid()" id="bidButton" disabled> -->
<!-- 보증금 결제 로직 완료되면 사용하기 -->
</form>

</body>
</html>