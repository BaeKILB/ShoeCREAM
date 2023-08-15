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
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/cream/cream_detail.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/etc/bootstrap.bundle.min.js"></script>

<!-- css파일  -->
<link href="${pageContext.request.contextPath }/resources/css/etc/bootstrap.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/resources/css/admin/common.css" rel="stylesheet" type="text/css">
<script>
 $(document).ready(function() {
     $('select[name="inputSize"]').on('change', function() {
         var selectedSize = $(this).val();
         var creamSizeValue = $('input[name="cream.size' + selectedSize + '"]').val();
         var formattedPrice = creamSizeValue + '원';
      // .value()를 사용한 방식
//          var creamSizeValue = $('#creamSize' + selectedSize).val();
        
         $('#priceSpan').text(formattedPrice);
     });
 });
</script>



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
	<input type="hidden" value="${cream.cream_idx }" id="cream_idx">
	<input type="hidden" value="${cream.mem_idx }" id="mem_idx">
  
	<main class="container">
		<section class="row">
			<div class="col-xl-6 col-xs-12">
				<div id="auctionCarousel" class="carousel slide"
					data-bs-ride="carousel">
					<div class="carousel-indicators">
						<button type="button" data-bs-target="#auctionCarousel" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
						<c:if test="${cream.image2.length() != 0}">
							<button type="button" data-bs-target="#auctionCarousel" data-bs-slide-to="1" aria-label="Slide 2"></button>
						</c:if>
						<c:if test="${cream.image3.length() != 0}">
							<button type="button" data-bs-target="#auctionCarousel" data-bs-slide-to="2" aria-label="Slide 3"></button>
						</c:if>
						<c:if test="${cream.image4.length() != 0}">
							<button type="button" data-bs-target="#auctionCarousel" data-bs-slide-to="3" aria-label="Slide 4"></button>
						</c:if>	
					</div>
					<div class="carousel-inner">
					    <div class="carousel-item active">
					        <img src="${pageContext.request.contextPath }${cream.image_path }/${cream.image1 }" class="d-block w-100" alt="상품이미지1">
					    </div>
						    <c:if test="${cream.image2.length() != 0}">
						        <div class="carousel-item">
						            <img src="${pageContext.request.contextPath }${cream.image_path }/${cream.image2 }" class="d-block w-100" alt="상품이미지2">
						        </div>
						    </c:if>
						    <c:if test="${cream.image3.length() != 0}">
						        <div class="carousel-item">
						            <img src="${pageContext.request.contextPath }${cream.image_path }/${cream.image3 }" class="d-block w-100" alt="상품이미지3">
						        </div>
						    </c:if>
						    <c:if test="${cream.image4.length() != 0}">
						        <div class="carousel-item">
						            <img src="${pageContext.request.contextPath }${cream.image_path }/${cream.image4 }" class="d-block w-100" alt="상품이미지4">
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
									<li class="breadcrumb-item"><a href="Cream">Home</a></li>
								</ol>
							</nav>
						</div>
					</div>
					<div class="row m-3">
						<div class="col">
							<div class="fs-2 fw-bold">${cream.cream_title }</div>
						</div>
					</div>
					<div class="card p-3">
						<div class="row">
						    <div class="col-md-6">사이즈</div>
						    <div  class="col-md-6">
						        <select name="inputSize" id="inputSizeSelect">
						            <c:forEach begin="220" step="5" end="310" varStatus="status">
						                <option value="${status.index}">${status.index}</option>
						            </c:forEach>
						        </select>
						    </div>
						</div>
						<br>
							<div class="row">
							    <div class="col-md-6" >가격</div>
							    <div class="col-4 fw-bold">
									<input type="hidden" name="cream.size220" value="${cream.size220}" id="220">
									<input type="hidden" name="cream.size225" value="${cream.size225}" id="225">
									<input type="hidden" name="cream.size230" value="${cream.size230}" id="230">
									<input type="hidden" name="cream.size235" value="${cream.size235}" id="235">
									<input type="hidden" name="cream.size240" value="${cream.size240}" id="240">
									<input type="hidden" name="cream.size245" value="${cream.size245}" id="245">
									<input type="hidden" name="cream.size250" value="${cream.size250}" id="250">
									<input type="hidden" name="cream.size255" value="${cream.size255}" id="255">
									<input type="hidden" name="cream.size260" value="${cream.size260}" id="260">
									<input type="hidden" name="cream.size265" value="${cream.size265}" id="265">
									<input type="hidden" name="cream.size270" value="${cream.size270}" id="270">
									<input type="hidden" name="cream.size275" value="${cream.size275}" id="275">
									<input type="hidden" name="cream.size280" value="${cream.size280}" id="280">
									<input type="hidden" name="cream.size285" value="${cream.size285}" id="285">
									<input type="hidden" name="cream.size290" value="${cream.size290}" id="290">
									<input type="hidden" name="cream.size295" value="${cream.size295}" id="295">
									<input type="hidden" name="cream.size300" value="${cream.size300}" id="300">
									<input type="hidden" name="cream.size305" value="${cream.size305}" id="305">
									<input type="hidden" name="cream.size310" value="${cream.size310}" id="310">
							        <span id="priceSpan" ></span>
							    </div>
							</div>
					</div> 
					<br>
					<br>
   								<div class="col text-center ">
			    	            	<button class="btn btn-light w-100" id="dibsBox">
							            <span <c:if test="${cream.isLogin != 0 }">onclick="dibsCheck()"</c:if>> 
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
								<br>
								<c:choose>
				    				<c:when test="${cream.isLogin == 0 }">
									    <div class="col-12">
									    	<button id="applyButton" class="btn btn-light w-100" onclick="location.href='login'">로그인</button>
										</div>
				    				</c:when>
				    				<c:otherwise>
					    				<div class="col-12">
				    	 			 	 <button id="applyButton" class="btn btn-light w-100">결제하기</button>
				    	            	</div>
				    				</c:otherwise>
								</c:choose>
			    	            <br>
								<br>
									<div class="row"> 
										<div class="fs-5 fw-bold">상품 보내실 곳</div>
										<p class="border rounded">
											(주)슈크림<br>
											주소 : 부산광역시 부산진구 동천로 109 삼한골든게이트 7층 <br>
											051-803-0909<br>
											상품을 보내신후 <a href="/ShoeCREAM/store/${cream.isLogin}">이곳</a> 을 눌러 운송장 번호를 등록해주세요</p>
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
										<a href="CreamDetail?cream_idx${rp.cream_idx }">
											<img src="${pageContext.request.contextPath }${rp.image_path }/${rp.image1 }" class="card-img-top img-fluid rounded">
											<div class="card-body d-none d-md-block">
												<h5 class="card-title">${rp.cream_title }</h5>
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
								<input type="button" class="w-100" onclick="location.href='/Cream'" value="연관상품 더보기">
		               		</div>	
		               	</div>
	               	</c:if>
	            </div>
			</c:if>
		</section>
		<hr>
		<section class="row"> <!-- 상품정보 & 판매자정보 -->
			<div class="col-xl-4 col-xs-12"> <!-- 판매자 정보 & 판매 물품 -->
				<div class="container">
					<div class="row">
						<div class="col-8 fw-bold fs-5 fw-bold">${cream.cream_title } 구매후기</div>
					</div>
					<c:forEach items="${reviewList }" var="review"> <!-- 후기가져오면 여기 바꾸면됨 -->
						<div class="row h-75">
							<div class="col-8">
								<div class="container">
									<div class="row">
										<div class="col">
<!-- 											<span> -->
<%-- 												<a href="${pageContext.request.contextPath }/store/${sellerInfo.mem_idx }" class="fw-bold fs-5"> --%>
<%-- 													<span>${review.mem_nickname }</span> --%>
<!-- 												</a> -->
<!-- 											</span> -->
											<span>
												<c:forEach begin="0" end="4" step="1" varStatus="status">
													<c:choose>
														<c:when test="${status.index < review.review_star }">
															<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-star-fill" viewBox="0 0 16 16">
  																<path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/>
															</svg>
														</c:when>
														<c:otherwise>
															<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-star" viewBox="0 0 16 16">
															  <path d="M2.866 14.85c-.078.444.36.791.746.593l4.39-2.256 4.389 2.256c.386.198.824-.149.746-.592l-.83-4.73 3.522-3.356c.33-.314.16-.888-.282-.95l-4.898-.696L8.465.792a.513.513 0 0 0-.927 0L5.354 5.12l-4.898.696c-.441.062-.612.636-.283.95l3.523 3.356-.83 4.73zm4.905-2.767-3.686 1.894.694-3.957a.565.565 0 0 0-.163-.505L1.71 6.745l4.052-.576a.525.525 0 0 0 .393-.288L8 2.223l1.847 3.658a.525.525 0 0 0 .393.288l4.052.575-2.906 2.77a.565.565 0 0 0-.163.506l.694 3.957-3.686-1.894a.503.503 0 0 0-.461 0z"/>
															</svg>
														</c:otherwise>
													</c:choose>
												</c:forEach>
											</span>
										</div>
									</div>
									<div class="row">
										<div class="col">
											<b class="fs-6">${review.review_content }</b>
										</div>
									</div>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>
        </section>
		
		
		
		
	
	</main>
<script>
    const selectElement = document.getElementById('inputSizeSelect');
    const applyButton = document.getElementById('applyButton');

    applyButton.addEventListener('click', function () {
        const selectedValue = selectElement.value;
        const creamIdx = "${cream.cream_idx}"; 
        const url = new URL('http://localhost:8089/ShoeCREAM/payForm2'); 
        
        url.searchParams.set('cream_idx', creamIdx); // 파라미터 이름 수정
        url.searchParams.set('selectedSize', selectedValue);
        
        location.href = url; // URL로 이동
    });
</script>

	
</body>
</html>