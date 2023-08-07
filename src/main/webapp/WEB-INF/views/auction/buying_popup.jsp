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
            <div>${auction.auction_title }</div>
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
    <form method="post" action="buyingPro">
        <input type="hidden" value="${auction.auction_idx }"  name="auction_idx">
        <input type="hidden" value="${auction.auc_buy_instantly }"  name="auc_buy_instantly">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-2">
                    <input type="submit" class="btn btn-secondary" value="결제하기" >
                </div>
                <div class="col-2">
                    <input type="button" class="btn btn-secondary" value="닫기" onclick="window.close()" >
                </div>
            </div>
        </div>
        <!-- <input type="button" value="입찰하기" onclick="placeBid()" id="bidButton" disabled> -->
        <!-- 보증금 결제 로직 완료되면 사용하기 -->
    </form>
</main>
</body>
</html>