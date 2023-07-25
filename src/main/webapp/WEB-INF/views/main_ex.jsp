<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ShoeCream - 임시메인</title>
<link rel="shortcut icon" href="${pageContext.request.contextPath }/resources/img/main_ex/shoecream-logo.png">

<!--아이콘-->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />

<!-- 부트스트랩 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-gH2yIJqKdNHPEq0n4Mqa/HGKIhSkIHeL5AyhkYV8i59U5AR6csBvApHHNl/vI1Bx" crossorigin="anonymous">
<!-- 부트스트랩 icon -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
<!-- 부트스트랩 js -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>

<!--css-->
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/main_ex/market/common.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/main_ex/market/index.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/main_ex/market/join.css">

<!-- js -->
<script src="${pageContext.request.contextPath }/resources/js/main_ex/market/jquery-3.6.0.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/main_ex/market/menu_hover.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/main_ex/market/login_modal.js"></script>
</head>
<body>
	<!-- 헤더 시작 -->
	<header>
		<jsp:include page="./inc_ex/header.jsp" />
	</header>
	<!--로그아웃 확인 모달창-->
        <div class="logout_modal_wrap hidden">
            <div class="logout_bg bg"></div>
            <div class="logout_modal">
                <h2>로그아웃</h2>
                <p>로그아웃 하시겠습니까?</p>
                <div class="btn_area">
                    <button type="button" class="btn_logout_no">취소</button>
                    <a href="" class="btn_logout_yes">확인</a>
                </div>
            </div>
        </div>

        <!--로그인/회원가입 모달창-->
        <div class="join_modal_wrap hidden">
            <div class="join_bg bg"></div>
            <div class="join_content">
                <button class="btn_join_close">
                    <img src="${pageContext.request.contextPath }/resources/images/market/thunder_join_close.png" alt="번개장터 로그인 창 닫기 버튼" width="24px" height="24px">
                </button>
                <div class="join_main">
                    <img src="${pageContext.request.contextPath }/resources/images/market/app.png" alt="번개장터 앱 로고">
                    <p>번개장터로 중고 거래 시작하기</p>
                    <p>간편하게 가입하고 상품을 확인하세요</p>
                    <div class="join_button_area">
                        <button class="join_kakao">
                            <div class="join_kakao_logo"></div>
                            카카오로 이용하기
                        </button>
                        <button class="join_naver">
                            <div class="join_naver_logo"></div>
                            네이버로 이용하기
                        </button>
                        <button class="join_google">
                            <div class="join_google_logo"></div>
                            구글로 이용하기
                        </button>
                    </div>
                    <div class="join_footer">
                        도움이 필요하시면 <span class="join_footer_email">이메일</span> 또는 고객센터 <span class="join_footer_cs">1670-2910</span>로 문의 부탁드립니다.<br>
                        고객센터 운영시간: 09~18시 (점심시간 12~13시, 주말/공휴일 제외)
                    </div>
                </div>
            </div>
        </div>
    <!-- main_content 영역 -->
        <div id="main_content">
            <!--메인 슬라이드-->
            <div id="carouselExampleControls" class="carousel slide" data-bs-ride="carousel">
                <div class="carousel-inner">
                    <div class="carousel-item active">
                        <img src="${pageContext.request.contextPath }/resources/img/main_ex/market/thunder_main_slider3.jpg" class="d-block w-100" alt="...">
                    </div>
                    <div class="carousel-item">
                        <img src="${pageContext.request.contextPath }/resources/img/main_ex/메인2.png" class="d-block w-100" alt="..." style="width: 1024px;height: 298.55px;">
                    </div>
                    <div class="carousel-item">
                        <img src="${pageContext.request.contextPath }/resources/img/main_ex/메인1.png" class="d-block w-100" alt="..." style="width: 1024px;height: 298.55px;">
                    </div>
                </div>
                <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleControls" data-bs-slide="prev">
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                    <span class="visually-hidden">Previous</span>
                </button>
                <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleControls" data-bs-slide="next">
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                    <span class="visually-hidden">Next</span>
                </button>
            </div>

            <!--앱 다운 배너-->
            <div class="banner_wrap">
                <img src="${pageContext.request.contextPath }/resources/img/main_ex/ejclxm.png" onclick="location.href='https://thecheat.co.kr/rb/?mod=_search'" alt="더치트배너" width="100%">
                <div class="qr_wrap">
                    <img src="${pageContext.request.contextPath }/resources/img/main_ex/ejclxmQR.png" alt="더치트 앱 다운로드 qr 코드" class="image_qr">
                </div>
            </div>


            <section class="main_goods">
          		  <c:choose>
               		<c:when test="${not empty sessionScope.sId}">
               			<h2>${sessionScope.sId }님 맞춤 상품 ❤️</h2>
               		</c:when>
               		<c:otherwise>
               			<h4>로그인 후 더 많은 정보를 볼 수 있습니다 🎶</h4>
               		</c:otherwise>
                 </c:choose>
                
                <!--상품 영역-->
                    <div class="goods_wrap col-lg-12 col-md-12"> 
                   		<!-- 상품 1개 카드 -->
                        <c:forEach items="${selectIntCtgr }" var="selectIntCtgr" begin="0" end="4">
	                        <div class="goods">
	                            <a href="product_detail?product_idx=${selectIntCtgr.product_idx }&product_Mcategory=${selectIntCtgr.product_Mcategory}&product_price=${selectIntCtgr.product_price}">
<!--                                		<div class="goods_image"> -->
<%-- 	                                    <img src="${pageContext.request.contextPath }/resources/fileUpload/hana_cat1.jpg" width="194" height="194" alt="상품 이미지"> --%>
<!-- 	                                </div> -->

										<c:forEach items="${fileList }" var="fileList">
					                        <c:set var="length" value="${fn:length(fileList.file_name) }" />
											<c:set var="index" value="${fn:indexOf(fileList.file_name, '_') }" />
											<c:set var="file_name" value="${fn:substring(fileList.file_name, index + 1, length) }" />
											<c:choose>
					                            <c:when test="${fileList.file_num eq selectIntCtgr.product_idx && selectIntCtgr.sale_status eq '판매중' }">
						                            <div class="goods_image">
						                                <img src="${pageContext.request.contextPath }/resources/fileUpload/${file_name}" width="194" height="194" alt="상품 이미지">
						                            </div>
					                            </c:when>
					                            <c:when test="${fileList.file_num eq selectIntCtgr.product_idx && selectIntCtgr.sale_status eq '판매완료' }">
					                            	<div class="goods_image">
						                                <img src="${pageContext.request.contextPath }/resources/fileUpload/${file_name}" width="194" height="194" alt="상품 이미지">
						                               	<img src="${pageContext.request.contextPath }/resources/images/soldOut.png" alt="판매완료" style="width: 170px; height: 120px; margin-bottom: 77px;">
						                            </div>
					                            </c:when>
					                        </c:choose>
				                        </c:forEach>
				                        
	                                <div class="goods_info">
	                                    <p class="goods_title">${selectIntCtgr.product_subject }</p>
	                                    <div class="goods_price_date">
	                                        <span class="goods_price">${selectIntCtgr.product_price }원</span>
	                                        <span class="goods_date_before">${selectIntCtgr.sale_status }</span>
	                                    </div>
	                                </div>
	                            </a>
	                        </div>
                        </c:forEach>
                        <!-- //상품 1개 카드 -->
                    </div>
                </section>
                
                
                <!--상품 영역-->
            <section class="main_goods">
                <h2>클레버 인기 상품 👍</h2>
                <!-- 0614 보아 시작!!!!!!!!!!!! -->
                <div class="goods_wrap">
	                <c:forEach items="${selectDibsProduct }" var="selectDibsProduct" begin="0" end="4">
		                        <div class="goods">
		                            <a href="product_detail?product_idx=${selectDibsProduct.product_idx }&product_Mcategory=${selectDibsProduct.product_Mcategory}&product_price=${selectDibsProduct.product_price}">
	<!--                                		<div class="goods_image"> -->
	<%-- 	                                    <img src="${pageContext.request.contextPath }/resources/fileUpload/hana_cat1.jpg" width="194" height="194" alt="상품 이미지"> --%>
	<!-- 	                                </div> -->
	
											<c:forEach items="${fileList }" var="fileList">
						                        <c:set var="length" value="${fn:length(fileList.file_name) }" />
												<c:set var="index" value="${fn:indexOf(fileList.file_name, '_') }" />
												<c:set var="file_name" value="${fn:substring(fileList.file_name, index + 1, length) }" />
												<c:choose>
						                            <c:when test="${fileList.file_num eq selectDibsProduct.product_idx && selectDibsProduct.sale_status eq '판매중' }">
							                            <div class="goods_image">
							                                <img src="${pageContext.request.contextPath }/resources/fileUpload/${file_name}" width="194" height="194" alt="상품 이미지">
							                            </div>
						                            </c:when>
						                            <c:when test="${fileList.file_num eq selectDibsProduct.product_idx && selectDibsProduct.sale_status eq '판매완료' }">
						                            	<div class="goods_image">
							                                <img src="${pageContext.request.contextPath }/resources/fileUpload/${file_name}" width="194" height="194" alt="상품 이미지">
							                               	<img src="${pageContext.request.contextPath }/resources/images/main_ex/soldOut.png" alt="판매완료" style="width: 170px; height: 120px; margin-bottom: 77px;">
							                            </div>
						                            </c:when>
						                        </c:choose>
					                        </c:forEach>
					                        
		                                <div class="goods_info">
		                                    <p class="goods_title">${selectDibsProduct.product_subject }</p>
		                                    <div class="goods_price_date">
		                                        <span class="goods_price">${selectDibsProduct.product_price }원</span>
		                                        <span class="goods_date_before">${selectDibsProduct.sale_status }</span>
		                                    </div>
		                                </div>
		                            </a>
		                        </div>
	                        </c:forEach>
                    <!-- 0614 보아 끝!!!!!!!!!!!! -->
                </div> 
            </section>
            
            
             <section class="main_goods">
                <h2>클레버 최신 상품 🆕</h2>
                <!--상품 영역-->
                    <div class="goods_wrap col-lg-12 col-md-12"> 
                   		<!-- 상품 1개 카드 -->
                        <c:forEach items="${productList }" var="productList" begin="0" end="4">
	                        <div class="goods">
	                            <a href="product_detail?product_idx=${productList.product_idx }&product_Mcategory=${productList.product_Mcategory}&product_price=${productList.product_price}">
<!--                                		<div class="goods_image"> -->
<%-- 	                                    <img src="${pageContext.request.contextPath }/resources/fileUpload/hana_cat1.jpg" width="194" height="194" alt="상품 이미지"> --%>
<!-- 	                                </div> -->

										<c:forEach items="${fileList }" var="fileList">
					                        <c:set var="length" value="${fn:length(fileList.file_name) }" />
											<c:set var="index" value="${fn:indexOf(fileList.file_name, '_') }" />
											<c:set var="file_name" value="${fn:substring(fileList.file_name, index + 1, length) }" />
											<c:choose>
					                            <c:when test="${fileList.file_num eq productList.product_idx && productList.sale_status eq '판매중' }">
						                            <div class="goods_image">
						                                <img src="${pageContext.request.contextPath }/resources/fileUpload/${file_name}" width="194" height="194" alt="상품 이미지">
						                            </div>
					                            </c:when>
					                            <c:when test="${fileList.file_num eq productList.product_idx && productList.sale_status eq '판매완료' }">
					                            	<div class="goods_image">
						                                <img src="${pageContext.request.contextPath }/resources/fileUpload/${file_name}" width="194" height="194" alt="상품 이미지">
						                               	<img src="${pageContext.request.contextPath }/resources/img/main_ex/soldOut.png" alt="판매완료" style="width: 170px; height: 120px; margin-bottom: 77px;">
						                            </div>
					                            </c:when>
					                        </c:choose>
				                        </c:forEach>
				                        
	                                <div class="goods_info">
	                                    <p class="goods_title">${productList.product_subject }</p>
	                                    <div class="goods_price_date">
	                                        <span class="goods_price">${productList.product_price }원</span>
	                                        <span class="goods_date_before">${productList.sale_status }</span>
	                                    </div>
	                                </div>
	                            </a>
	                        </div>
                        </c:forEach>
                        <!-- //상품 1개 카드 -->
                    </div>
                </section>
            
        </div>
        <!-- // main_content 영역 -->
	<!-- 풋터 시작 -->
	<footer>
		<jsp:include page="./inc_ex/footer.jsp" />
	</footer>
</body>
</html>