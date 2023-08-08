<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/etc/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<link href="${pageContext.request.contextPath }/resources/css/etc/bootstrap.min.css" rel="stylesheet">
<script>
//웹소켓
let socket = null;
let ws = new SockJS("<c:url value="/alram"/>");
socket = ws;

//입찰하기 버튼 클릭
function Confirmation(event) {
    // 사용자에게 확인을 받기 위한 컨펌창 표시
    var confirmBid = confirm("구매를 진행하시겠습니까?");
    
    if (confirmBid) {
		$.ajax({ // 입찰 ajax
		    type: "post"
		    , url: "buyingPro"
		    , dataType: "json"
		    , data: {
		        'auction_idx': $("input[name=auction_idx]").val()
		    }
		})
		.done(function(data) { // 구매 done 시작
		    if (data.result) {
		        // 성공
		        alert(data.msg);
		        if (${not empty bid }) {
			         $.ajax({ // 알람 ajax
			             type: "POST"
			             , url: "registerAlram"
			             , dataType: "text"
			             , data: {
			                 'cmd':'1'
			                 , 'sender':'0'
			                 , 'receiver':'${bid.mem_idx}'
			                 , 'product_idx':'${auction.auction_idx}'
			                 , 'product_title':'${auction.auction_title}'
			             }
			         })
			         .done(function(result){ // 알람 done 시작
			             if(result == 1) { // 성공
			                 let msg = "auction, 0,${bid.mem_idx},${auction.auction_idx},${auction.auction_title}";
			                 alert(msg);
			                 socket.send(msg);
			             }
			         	refreshParentWindow(); // 부모 창 새로고침
						closeCurrentWindow(); // 현재 창 닫기
			         }) // 알람 done 끝
			         .fail(function(errorThrown) {
			         	console.log(errorThrown)
			         })
		        } else {
		            refreshParentWindow(); // 부모 창 새로고침
		            closeCurrentWindow(); // 현재 창 닫기
		        } 
		    } else {
		        alert(data.msg);
		        history.back();
		    }
		}) // 구매 done 끝
		.fail(function(errorThrown) {
		    console.log(errorThrown)
		})
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
<main class="container">
<!-- 입찰하기 버튼 누르는 경우 이동할 페이지, 
보여줄 메세지 (가격이랑 끝나는날 이후 경쟁자 생기면 알람 주겟다는거?) -->
    <div class="row"> <!-- 경매 제목 행 -->
        <div class="col">
            <div class="display-4 fw-bold text-center">즉시 구매</div>
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
            <div class="fw-bold">${auction.auction_title }</div>
        </div>
    </div>
    <div class="row">
	    <div class="col-3">
	        <div class="text-center">브랜드</div>
	    </div>
	    <div class="col-6">
	        <div class="fw-bold">${auction.auction_brand}</div>
	    </div>
    </div>
    <div class="row">
	    <div class="col-3">
	        <div class="text-center">사이즈</div>
	    </div>
	    <div class="col-6">
	        <div class="fw-bold">${auction.auction_size}</div>
	    </div>
    </div>
    <div class="row">
        <div class="col-3">
            <div class="text-center">즉시구매가</div>
        </div>
        <div class="col-6">
            <div class="fw-bold">${auction.auc_buy_instantly }원</div>
        </div>
    </div>
    <form method="post" action="buyingPro">
        <input type="hidden" value="${auction.auction_idx }"  name="auction_idx">
        <input type="hidden" value="${auction.auc_buy_instantly }"  name="auc_buy_instantly">
        <div class="container">
            <div class="row justify-content-evenly">
                <div class="col-2">
                    <input type="button" class="btn btn-secondary" value="결제" onclick="Confirmation()">
                </div>
                <div class="col-2">
                    <input type="button" class="btn btn-secondary" value="닫기" onclick="window.close()" >
                </div>
            </div>
        </div>
        <!-- <input type="button" value="입찰하기" onclick="placeBid()" id="bidButton" disabled> -->
        <!-- 보증금 결제 로직 완료되면 사용하기 -->
    </form>
    
    <div class="fw-bold fs-6">
    	<p>즉시구매를 신청하시고 바로 결제를 완료하지 않으시면, 즉시구매가 취소됩니다.</p>
    	<p>슈크림은 통신판매 중개자로서 통신판매의 당사자가 아닙니다.</p> 
    	<p>본 상품은 개별판매자가 등록한 상품으로 상품, 상품정보, 거래에 관한 의무와 책임은 각 판매자에게 있습니다.</p>
    	<p>슈크림의 결제시스템을 이용하지 않고 판매자의 계좌로 상품대금을 송금 하는등의 방법으로 직거래를 하는경우, 상품을 받지못하는 등의 피해가 발생할 수 있습니다.</p> 
    	<p>직거래로 인한 피해 발생시, 슈크림은 일체의 책임을 지지 않습니다.</p>
    </div>
</main>
</body>
</html>