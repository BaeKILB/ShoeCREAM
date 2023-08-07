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
<%-- <link href="${pageContext.request.contextPath }/resources/css/admin/common.css" rel="stylesheet" type="text/css"> --%>

<script>
    // JavaScript function to display the selected price
    function selectSize(selectedSize) {
        // Access the priceSpan element
        var priceSpan = document.getElementById('priceSpan');

        // Get the cream object from the model attribute (스프링 모델 데이터 사용)
//         var cream = <c:out value="${cream}" />; // 스프링 모델 데이터를 JavaScript 변수로 가져옵니다.

        // Get the price for the selected size from the cream object
        var selectedPrice = cream['size' + selectedSize];

        // Update the priceSpan with the selected price
        priceSpan.innerText = selectedPrice;
    }
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
					<div class="carousel-inner"> <!-- 이미지 순차적으로 나오게 수정 0804이온 -->
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
						
<div class="row">
    <div class="col-3">사이즈</div>
    <div>
        <select name="inputSize" onchange="selectSize(this.value)">
            <c:forEach begin="220" step="5" end="310" varStatus="status">
                <option value="${status.index}">${status.index}</option>
            </c:forEach>
        </select>
    </div>
</div>

<div class="row">
    <div class="col-3">가격</div>
    <div class="col-4 fw-bold">
        <span id="priceSpan"></span>
    </div>
</div>

${cream }
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
					</div>
				</div>
		</section>

		<hr>
		<section class="row"> <!-- 상품정보 & 판매자정보 -->
			<div class="col-xl-8 col-xs-12">
				<div class="container">
					<div class="row"> 
						<div class="col">
							<div class="fs-5 fw-bold">상품정보</div>
							<p class="border rounded">${cream.cream_info }</p>
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