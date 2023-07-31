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
<!-- 자바스크립트 파일 -->
<script type="text/javascript"
   src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>
<script type="text/javascript"
   src="${pageContext.request.contextPath }/resources/js/auction/auction_detail.js"></script>

<!-- css파일  -->
<link
   href="${pageContext.request.contextPath }/resources/css/admin/common.css"
   rel="stylesheet" type="text/css">

<!-- 테스트용 css -->
<style type="text/css">
/* Slideshow container */
.slideshow-container {
   max-width: 1000px;
   position: relative;
   margin: auto;
}

/* Hide the images by default */
.mySlides {
   display: none;
}

/* Next & previous buttons */
.prev, .next {
   cursor: pointer;
   position: absolute;
   top: 50%;
   width: auto;
   margin-top: -22px;
   padding: 16px;
   color: white;
   font-weight: bold;
   font-size: 18px;
   transition: 0.6s ease;
   border-radius: 0 3px 3px 0;
   user-select: none;
}

/* Position the "next button" to the right */
.next {
   right: 0;
   border-radius: 3px 0 0 3px;
}

/* On hover, add a black background color with a little bit see-through */
.prev:hover, .next:hover {
   background-color: rgba(0, 0, 0, 0.8);
}

/* The dots/bullets/indicators */
.dot {
   cursor: pointer;
   height: 15px;
   width: 15px;
   margin: 0 2px;
   background-color: #bbb;
   border-radius: 50%;
   display: inline-block;
   transition: background-color 0.6s ease;
}

.active, .dot:hover {
   background-color: #717171;
}

/* Fading animation */
.fade {
   animation-name: fade;
   animation-duration: 1.5s;
}

@
keyframes fade {
   from {opacity: .4
}

to {
   opacity: 1
}
}

#dibsBox {
    cursor: pointer;
}

.dibsImage {
    width: 20px;
    height: 20px;
}

#sellerInfo {
    cursor: pointer;
}
</style>
</head>
<body>
   <h1>경매</h1>
   <input type="hidden" value="${auction.auction_idx }" id="auction_idx">
   <input type="hidden" value="${auction.auc_close_date }" id="auc_close_date">
   <input type="hidden" value="${auction.mem_idx }" id="mem_idx">
   <!-- 가지고 올 정보 
   from 공통테이블
   1. 카테고리 대 중 소 
   2. 제품명
   3. 상품코드
   
   from 옥션테이블
   1. 현재가격 경매테이블에서 max가격으로 bid_price (bid_list Table)
   2. 시작가격 auc_start_price
   5. 즉시구매가 auc_buy_instantly
   3. 입찰수 bid_date 로 count하나? n회 
   4. 경매 마감일 (남은시간)
-->
   <!--    좌측 상품 사진 옆으로 넘기는 형태 -->
   <!-- Slideshow container -->
   

    <section>
        <div>
			<img src="${pageContext.request.contextPath }${auction.image_path }/${auction.image1 }">
			<img src="${pageContext.request.contextPath }${auction.image_path }/${auction.image2 }" hidden>
			<img src="${pageContext.request.contextPath }${auction.image_path }/${auction.image3 }" hidden>
			<img src="${pageContext.request.contextPath }${auction.image_path }/${auction.image4 }" hidden>
        </div>
        <div class="slideshow-container">
		<!-- Full-width images with number and caption text -->
			<div class="mySlides fade">
	            <img src="${pageContext.request.contextPath }${auction.image_path }/${auction.image1 }" style="width: 100%">
			</div>
			<div class="mySlides fade">
	            <img src="${pageContext.request.contextPath }${auction.image_path }/${auction.image2 }" style="width: 100%">
			</div>
			<div class="mySlides fade">
	            <img src="${pageContext.request.contextPath }${auction.image_path }/${auction.image3 }" style="width: 100%">
			</div>
			<div class="mySlides fade">
	            <img src="${pageContext.request.contextPath }${auction.image_path }/${auction.image4 }" style="width: 100%">
			</div>
            <!-- Next and previous buttons -->
			<a class="prev" onclick="plusSlides(-1)">&#10094;</a> 
			<a class="next" onclick="plusSlides(1)">&#10095;</a>
        </div>
        <!-- The dots/circles -->
        <div style="text-align: center">
	        <span class="dot" onclick="currentSlide(1)"></span> 
	        <span class="dot" onclick="currentSlide(2)"></span> 
	        <span class="dot" onclick="currentSlide(3)"></span> 
	        <span class="dot" onclick="currentSlide(4)"></span>
        </div>
        <div>
	        <span id="">${auction.lc_name }</span>
	        <span> > </span>
	        <span id="">${auction.mc_name }</span>
        </div>
        <div>
            <span>${auction.auction_title }</span>
            <span id="dibsBox"> 
                <c:choose>
					<c:when test="${dibs eq null }">
						<img class="dibsImage" alt="하트 아이콘하트)" src="${pageContext.request.contextPath }/resources/img/auction/favorite-heart-false.svg">
						<span>${dibsCount }</span>
                    </c:when>
					<c:otherwise>
						<img class="dibsImage" alt="하트 아이콘(빈하트)" src="${pageContext.request.contextPath }/resources/img/auction/favorite-heart-true.svg">
						<span>${dibsCount }</span>
                    </c:otherwise>
				</c:choose> 
			</span>
        </div>
	    <div>
	        <span>
	              <span>현재가격 : </span>
	              <span>
	                   <c:choose>
	                       <c:when test="${bid eq null }">
	                           ${auction.auc_start_price } 원
	                       </c:when>
	                       <c:otherwise>
	                           ${bid.bid_price } 원
	                       </c:otherwise>
	                   </c:choose>
	              </span>
	        </span>
	        <span>
	              <span>시작가격 : </span>
	              <span>${auction.auc_start_price }</span>
	        </span>
	        <div>
	              <span>즉시구매가 : </span>
	              <span>${auction.auc_buy_instantly }</span>
	        </div>
	    </div>
        <hr>
        <div>
            <span>입찰수 : </span> <!-- 입찰내역 count -->
            <span> 
				<c:choose>
				    <c:when test="${bidCount eq null }">
				        0 회
				    </c:when>
				    <c:otherwise>
				        ${bidCount } 회
				    </c:otherwise>
				</c:choose>
			</span>
            <span id="">경매기록</span> <!-- const auctionHistory() -->
        </div>
        <div id="acdBox"></div> <!-- const closeTimeCheck() -->
        <div>
<%-- 			<c:choose> --%>
<%-- 				<c:when test="${auction.mem_id eq sessionScope.sId }"> --%>
<%-- 					<input type="button" value="수정" onclick="location.href='BoardModifyForm?board_num=${board.board_num}&pageNum=${param.pageNum}'"> --%>
<!-- <!--                     삭제 버튼 클릭 시 "삭제하시겠습니까?" 메세지 출력 후 확인 버튼 누르면 삭제 서블릿 요청 -->
<!--                     <input type="button" value="삭제" onclick="confirmDelete()"> -->
<%-- 				</c:when> --%>
<%-- 				<c:otherwise> --%>
<!-- 					<input type="button" value="입찰-팝업" onclick="tenderPopup();"> -->
<!-- 					<input type="button" value="즉시구매-팝업" onclick="buyingPopup();"> -->
<%-- 				</c:otherwise> --%>
<%-- 			</c:choose> --%>
			<input type="button" value="입찰-팝업" onclick="tenderPopup();">
            <input type="button" value="즉시구매-팝업" onclick="buyingPopup();">
        </div>
        <div> <!-- 연관상품, 상품정보 & 판매자정보 -->
            <hr>
            <div>
                <div>연관상품</div>
                <div> <!-- 연관상품 -->
                    <div>연관상품1</div>
                    <div>연관상품2</div>
                    <div>연관상품3</div>
                    <div>연관상품4</div>
                    <div>연관상품5</div>
                </div>
            </div>
            <hr>
            <div> <!-- 상품정보 & 판매자정보 -->
	            <div>
	               <div>상품정보</div>
	               <div>${auction.auction_info }</div>
	            </div>
	            <div>
	               <div> <!-- 판매자정보 -->
<%-- 	                   <span id="sellerInfo">${sellerInfo.mem_nickname }</span> --%>
	                   <span id="sellerInfo"> 판매자 닉네임 : ${auction.mem_idx }</span>
	               </div>
	               <div> <!-- 판매자 후기  -->
	                   <div>후기1</div>
	                   <div>후기2</div>
	                   <div>후기3</div>
	                   <div>후기1</div>
	               </div>
	            </div>
            </div>
        </div>
   </section>
</body>
</html>