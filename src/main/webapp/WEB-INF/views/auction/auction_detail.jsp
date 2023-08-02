<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<c:set var="principal" value="${null}" />

<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal" var="principal" />
</sec:authorize>
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

.hidden {
	display: none;
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

        <div>
	        <span id="">${auction.lc_name }</span>
	        <span> > </span>
	        <span id="">${auction.mc_name }</span>
        </div>
        <div>
            <span>${auction.auction_title }</span>
            <c:if test="${auction.isLogin != 0 }">
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
            </c:if>
        </div>
    	<c:choose>
    		<c:when test="${auction.auc_state eq '마감' }">
    			<div>거래 종료</div>
    		</c:when>
    		<c:otherwise>
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
					<div>
						<c:choose>
							<c:when test="${bid eq null }">
								<div>경매기록 없음</div>
							</c:when>
							<c:otherwise>
					            <div id="bidHistoryBtn">경매기록</div>
					            <div id="bidHistory">
					            </div>
							</c:otherwise>
						</c:choose>
		            </div>
		        </div>
		        <div id="acdBox"></div> <!-- const closeTimeCheck() -->
		        <div>
					<c:choose>
						<c:when test="${auction.mem_idx eq principal.member.mem_idx}">
							<input type="button" value="수정" onclick="location.href='AuctionModifyForm?auction_idx=${auction.auction_idx}'">
		<!--                      삭제 버튼 클릭 시 "삭제하시겠습니까?" 메세지 출력 후 확인 버튼 누르면 삭제 서블릿 요청 -->
		                    <input type="button" value="삭제" onclick="confirmDelete()">
						</c:when>
						<c:otherwise>
							<input type="button" value="입찰-팝업" onclick="tenderPopup();">
							<input type="button" value="즉시구매-팝업" onclick="buyingPopup();">
						</c:otherwise>
					</c:choose>
		        </div>
    		</c:otherwise>
    	</c:choose>
        <hr>
		<c:if test="${fn:length(relatedProducts) > 0 }">
			<div> <!-- 연관상품 -->
                <div>연관상품</div>
                <div> 
					<c:forEach var="rp" items="${relatedProducts }" varStatus="status">
						<c:if test="${status.index < 4}">
							<div>
								<div>
									<a href="AuctionDetail?auction_idx${rp.auction_idx }" >
										<span>${rp.auction_title }</span>
										<img src="${pageContext.request.contextPath }${rp.image_path }/${rp.image1 }"> <!-- 사진사이즈 줄여야됨 -->
									</a>
								</div>
							</div>
						</c:if>
                	</c:forEach>
					<div>
						<input type="button" onclick="location.href='Auction?lc_code=${auction.lc_code}&mc_code=${auction.mc_code }'" value="연관상품 더보기"> <!-- 기능구현 필요 -->
					</div>
                </div>
            </div>
		</c:if>
		<hr>
		<div> <!-- 상품정보 & 판매자정보 -->
			<div> <!-- 상품정보 -->
				<div>상품정보</div>
				<div>
					<p>${auction.auction_info }</p>
	            </div>
	            <div> <!-- 판매자 정보 & 판매 물품 -->
	                <div> <!-- 판매자 정보 -->
						<span id="sellerInfo">
							<a href="#?mem_idx=${sellerInfo.mem_idx }"> <!-- 판매자 상점 URL 입력필요 -->
								<span>판매자 닉네임 : ${sellerInfo.mem_nickname }</span>
							</a>
						</span>
					</div>
					<div> <!-- 판매 물품 -->
						<c:if test="${fn:length(sellerItemList) > 0 }">
							<c:forEach var="sil" items="${sellerItemList }" varStatus="status">
								<c:if test="${status.index < 3}">
									<div>
										<div>
											<a href="AuctionDetail?auction_idx${sil.auction_idx }" >
												<span>${sil.auction_title }</span>
												<img src="${pageContext.request.contextPath }${sil.image_path }/${sil.image1 }"> <!-- 사진사이즈 줄여야됨 -->
											</a>
										</div>
									</div>
								</c:if>
							</c:forEach>
							<div>
								<input type="button" value="판매물품 더보기"> <!-- 기능구현 필요 -->
							</div>
						</c:if>
					</div>
	            </div>
            </div>
        </div>
   </section>
</body>
</html>