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
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/auction/auction_detail.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/etc/bootstrap.bundle.min.js"></script>
<!-- css파일  -->
<link href="${pageContext.request.contextPath }/resources/css/etc/bootstrap.min.css" rel="stylesheet">
<%-- <link href="${pageContext.request.contextPath }/resources/css/admin/common.css" rel="stylesheet" type="text/css"> --%>


<!-- 테스트용 css -->
<style type="text/css">
  Slideshow container  
 .slideshow-container { 
    max-width: 1000px; 
    position: relative; 
    margin: auto; 
 } 

  Hide the images by default  
 .mySlides { 
    display: none; 
 } 

  Next & previous buttons  
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

  Position the "next button" to the right  
 .next { 
    right: 0; 
    border-radius: 3px 0 0 3px; 
 } 

  On hover, add a black background color with a little bit see-through  
 .prev:hover, .next:hover { 
    background-color: rgba(0, 0, 0, 0.8); 
 } 

  The dots/bullets/indicators  
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

  Fading animation  
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
 
  .card-img-top { 
  	height: 10rem; 
  	object-fit: cover; 
  } 
 
 a {
 	text-decoration: none;
 	color: #000;
 }
 
</style>
</head>
<body>
	<hr>
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
	<main class="container">
		<section class="row">
			<div class="col-xl-6 col-xs-12">
				<div id="auctionCarousel" class="carousel slide"
					data-bs-ride="carousel">
					<div class="carousel-indicators">
						<button type="button" data-bs-target="#auctionCarousel" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
						<c:if test="${auction.image2.length() != 0}">
							<button type="button" data-bs-target="#auctionCarousel" data-bs-slide-to="1" aria-label="Slide 2"></button>
						</c:if>
						<c:if test="${auction.image3.length() != 0}">
							<button type="button" data-bs-target="#auctionCarousel" data-bs-slide-to="2" aria-label="Slide 3"></button>
						</c:if>
						<c:if test="${auction.image4.length() != 0}">
							<button type="button" data-bs-target="#auctionCarousel" data-bs-slide-to="3" aria-label="Slide 4"></button>
						</c:if>	
					</div>
					<div class="carousel-inner"> <!-- 이미지 순차적으로 나오게 수정 0804이온 -->
					    <div class="carousel-item active">
					        <img src="${pageContext.request.contextPath }${auction.image_path }/${auction.image1 }" class="d-block w-100" alt="상품이미지1">
					    </div>
						    <c:if test="${auction.image2.length() != 0}">
						        <div class="carousel-item">
						            <img src="${pageContext.request.contextPath }${auction.image_path }/${auction.image2 }" class="d-block w-100" alt="상품이미지2">
						        </div>
						    </c:if>
						    <c:if test="${auction.image3.length() != 0}">
						        <div class="carousel-item">
						            <img src="${pageContext.request.contextPath }${auction.image_path }/${auction.image3 }" class="d-block w-100" alt="상품이미지3">
						        </div>
						    </c:if>
						    <c:if test="${auction.image4.length() != 0}">
						        <div class="carousel-item">
						            <img src="${pageContext.request.contextPath }${auction.image_path }/${auction.image4 }" class="d-block w-100" alt="상품이미지4">
						        </div>
						    </c:if>
					</div>
					<button class="carousel-control-prev" type="button"
						data-bs-target="#auctionCarousel" data-bs-slide="prev">
						<span class="carousel-control-prev-icon" aria-hidden="true"></span>
						<span class="visually-hidden">Previous</span>
					</button>
					<button class="carousel-control-next" type="button"
						data-bs-target="#auctionCarousel" data-bs-slide="next">
						<span class="carousel-control-next-icon" aria-hidden="true"></span>
						<span class="visually-hidden">Next</span>
					</button>
				</div>
			</div>
			<div class="col-xl-6 col-xs-12">
				<div class="container"> <!-- 오른쪽 -->
					<div class="row">
						<div class="col">
							<nav class="d-none d-xl-block" style="--bs-breadcrumb-divider: url(&#34;data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='8' height='8'%3E%3Cpath d='M2.5 0L1 1.5 3.5 4 1 6.5 2.5 8l4-4-4-4z' fill='currentColor'/%3E%3C/svg%3E&#34;);" aria-label="breadcrumb">
								<ol class="breadcrumb" id="categoryPath">
									<li class="breadcrumb-item"><a href="Auction">Home</a></li>
									<li class="breadcrumb-item"><a href="Auction?lc_code=${auction.lc_code }">${auction.lc_name }</a></li>
									<li class="breadcrumb-item"><a href="Auction?lc_code=${auction.lc_code }&mc_code=${auction.mc_code}">${auction.mc_name }</a></li>
								</ol>
							</nav>
						</div>
					</div>
					<div class="row m-3">
						<div class="col">
							<div class="fs-2 fw-bold">${auction.auction_title }</div>
						</div>
					</div>
					<c:if test="${auction.auc_state eq '진행' }">
						<div class="row">
							<div class="col-3">현재가</div>
							<div class="col-4 fw-bold">
				    			<c:choose>
									<c:when test="${bid eq null }">
									    ${auction.auc_start_price }원
									</c:when>
									<c:otherwise>
									    ${bid.bid_price }원
									</c:otherwise>
						     	</c:choose>
							</div>
						</div>
					</c:if>
					<div class="row">
						<div class="col-3">즉시구매가</div>
						<div class="col-4 fw-bold">
							${auction.auc_buy_instantly }원
						</div>
					</div>
					<div class="row mb-2">
						<div class="col-3">
				            <span>입찰수</span> <!-- 입찰내역 count -->
				            <span class="fw-bold"> 
								<c:choose>
								    <c:when test="${bidCount eq null }">
								        0
								    </c:when>
								    <c:otherwise>
								        ${bidCount }
								    </c:otherwise>
								</c:choose>
							</span>회
						</div>
						<div class="col">
							<div>
								<c:choose>
									<c:when test="${bidCount eq null }">
										<div>경매기록 없음</div>
									</c:when>
									<c:otherwise>
							            <button class="btn" id="bidHistoryBtn">경매기록</button>
									</c:otherwise>
								</c:choose>
				            </div>
				    	</div>
					</div>
					<div class="row">
						<div class="col">
				            <div id="bidHistory" class="container"></div>
						</div>
					</div>
					<c:if test="${auction.auc_state eq '진행' }">
						<div class="row justify-content-end mb-2">
							<div class="col fs-5 fw-bold text-danger text-end" id="acdBox">&nbsp;</div>
						</div>
					</c:if>
					<div class="row mb-2">
				    	<c:choose>
				    		<c:when test="${auction.auc_state eq '마감' }">
				    			<div class="col text-center display-3 mt-3">거래 종료</div>
				    		</c:when>
				    		<c:otherwise>
				    			<c:choose>
				    				<c:when test="${auction.isLogin == 0 }">
									    <div class="col-12">
									    	<button class="btn btn-secondary text-light w-100" onclick="location.href='login'">
									    		<div class="fs-5 fw-bold">로그인</div> <!-- 뭘로하지..? -->
									    	</button>
										</div>
				    				</c:when>
									<c:when test="${auction.mem_idx eq principal.member.mem_idx}">
									    <div class="col-6">
									    	<button class="btn btn-secondary text-light w-100" onclick="location.href='AuctionModifyForm?auction_idx=${auction.auction_idx}'">
									    		<div class="fs-5 fw-bold">수정</div> <!-- 뭘로하지..? -->
									    	</button>
										</div>
										<div class="col-6">
											<button class="btn btn-secondary text-light w-100" onclick="confirmDelete()">
						                     	<!-- 삭제 버튼 클릭 시 "삭제하시겠습니까?" 메세지 출력 후 확인 버튼 누르면 삭제 서블릿 요청 -->
												<div class="fs-5 fw-bold">삭제</div> <!-- 뭘로하지..? -->
											</button>
									    </div>
				    				</c:when>
				    				<c:otherwise>
				    				    <c:choose>
				    				        <c:when test="${bid.mem_idx eq principal.member.mem_idx}">
												<div class="col-12">
													<button class="btn btn-secondary text-light w-100" onclick="buyingPopup()">
														<div class="fs-5 fw-bold">즉시 구매</div>
													</button>
											    </div>
											</c:when>
											<c:otherwise>
	                                             <div class="col-6">
                                                    <button class="btn btn-secondary text-light w-100" onclick="tenderPopup()">
                                                        <div class="fs-5 fw-bold">입찰</div>
                                                        <div>
        
                                                        </div>
                                                    </button>
                                                </div>
                                                <div class="col-6">
                                                    <button class="btn btn-secondary text-light w-100" onclick="buyingPopup()">
                                                        <div class="fs-5 fw-bold">즉시 구매</div>
                                                    </button>
                                                </div>
											</c:otherwise>
				    				    </c:choose>
				    				</c:otherwise>
				    			</c:choose>
			    	            <div class="col text-center ">
			    	            	<button class="btn btn-light w-100" id="dibsBox">
							            <span <c:if test="${auction.isLogin != 0 }">onclick="dibsCheck()"</c:if>> 
							                <c:choose>
												<c:when test="${dibs eq null }">
													<img class="dibsImage" alt="heart-fill" src="${pageContext.request.contextPath }/resources/img/auction/favorite-heart-false.svg">
													<span>${dibsCount }</span>
							                    </c:when>
												<c:otherwise>
													<img class="dibsImage" alt="heart" src="${pageContext.request.contextPath }/resources/img/auction/favorite-heart-true.svg">
													<span>${dibsCount }</span>
							                    </c:otherwise>
											</c:choose> 
										</span>
			    	            	</button>
								</div>
				    		</c:otherwise>
				    	</c:choose>
					</div>
				</div>
			</div>
		</section>
		<section class="row">
			<c:if test="${fn:length(relatedProducts) > 0 }">
		        <hr>
				<div class="col"> <!-- 연관상품 -->
		            <div class="container">
		            	<div class="row mb-2">
			                <div class="col fs-5 fw-bold">연관상품</div>
		            	</div>
		            	<div class="row">
							<c:forEach var="rp" items="${relatedProducts }" varStatus="status">
								<c:if test="${status.index < 4}">
									<div class="card col-xs-6 col-3">
										<a href="AuctionDetail?auction_idx${rp.auction_idx }">
											<img src="${pageContext.request.contextPath }${rp.image_path }/${rp.image1 }" class="card-img-top img-fluid rounded">
											<div class="card-body d-none d-md-block">
												<h5 class="card-title">${rp.auction_title }</h5>
											</div>
										</a>
									</div>
								</c:if>
			               	</c:forEach>
		            	</div>
		            </div>
	               	<c:if test="${fn:length(relatedProducts) > 5 }">
		               	<div class="row">
		               		<div class="col">
								<input type="button" class="w-100" onclick="location.href='Auction?lc_code=${auction.lc_code}&mc_code=${auction.mc_code }'" value="연관상품 더보기">
		               		</div>	
		               	</div>
	               	</c:if>
	            </div>
			</c:if>
		</section>
		<hr>
		<section class="row"> <!-- 상품정보 & 판매자정보 -->
			<div class="col-xl-8 col-xs-12">
				<div class="container">
					<div class="row"> 
						<div class="col">
							<div class="fs-5 fw-bold">상품정보</div>
							<p class="border rounded">${auction.auction_info }</p>
						</div>
					</div>
					<div class="row"> <!-- 높이조절해야됨 -->
						<div class="col">
							<div class="fs-5 fw-bold">거래시 주의사항</div>
							<p class="border rounded">주의사항 작성</p>
						</div>
					</div>
				</div>
				<div>
	            </div>
			</div>
			<div class="col-xl-4 col-xs-12"> <!-- 판매자 정보 & 판매 물품 -->
				<div class="container">
					<div class="row mb-3">
		                <div class="col"> <!-- 판매자 정보 -->
							<div class="fs-5 fw-bold">판매자 정보</div>
							<span id="sellerInfo">
<%-- 							<a href="${pageContext.request.contextPath }/store/${sellerInfo.mem_idx }"> <!-- 판매자 상점 URL 입력필요 --> --%>
								<a href="#?mem_idx=${sellerInfo.mem_idx }"> <!-- 판매자 상점 URL 입력필요 -->
									<span>${sellerInfo.mem_nickname }</span>
								</a>
							</span>
						</div>
					</div>
					<div class="row mb-2 justify-content-center"> <!-- 판매 물품 -->
						<c:if test="${fn:length(sellerItemList) > 0 }">
							<c:forEach var="sil" items="${sellerItemList }" varStatus="status">
								<c:if test="${status.index < 4}">
									<div class="col-3 col-xl-6 mb-2">
										<a href="AuctionDetail?auction_idx=${sil.auction_idx }" >
											<img src="${pageContext.request.contextPath }${sil.image_path }/${sil.image1 }" class="img-fluid rounded"> <!-- 사진사이즈 줄여야됨 -->
										</a>
									</div>
								</c:if>
							</c:forEach>
						</c:if>
					</div>
					<c:if test="${fn:length(sellerItemList) > 5 }">
						<div class="row">
		               		<div class="col">
								<input type="button" class="btn w-100" onclick="location.href='#?mem_idx=${sellerInfo.mem_idx }'" value="판매물품 더보기"> <!-- 기능구현 필요 -->
		               		</div>	
		               	</div>
	               	</c:if>
				</div>
				<div class="container">
					<c:forEach begin="1" end="5" var="i"> <!-- 후기가져오면 여기 바꾸면됨 -->
						<div class="row">
							<div class="col">
								<span>작성자${i }</span>
								<span>후기내용${i }</span>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>
        </section>
	</main>
</body>
</html>