<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
	<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/common/common.css">
	<link href="${pageContext.request.contextPath}/resources/css/junggo/product_detail.css" rel="stylesheet">
	<%-- 	<link href="${pageContext.request.contextPath}/resources/css/inc/top.css" rel="styleSheet"> --%>
	<%-- 	<link href="${pageContext.request.contextPath}/resources/css/inc/footer.css" rel="styleSheet"> --%>
	<link href="${pageContext.request.contextPath }/resources/css/etc/bootstrap.min.css" rel="stylesheet">
	<script	src="${pageContext.request.contextPath }/resources/js/etc/bootstrap.bundle.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.0.js"></script>
</head>
<body>

	<header>
		

	<script type="text/javascript">
		function deleteConfirmPD() {
			if(!confirm("게시글을 삭제 하시겠습니까? 삭제하시면 네를 눌려주세요")) {
				return false;
			} else {
				location.href="${pageContext.request.contextPath}/productDelete?product_idx=${jungGoNoh.product_idx}&mem_idx=${jungGoNoh.mem_idx}&buyier_idx=${principal.member.mem_idx}";
			}
		}
		
		function deleteConfirmRV() {
			if(!confirm("게시글을 삭제 하시겠습니까? 삭제하시면 네를 눌려주세요")) {
				return false;
			} else {
				location.href="${pageContext.request.contextPath}/reviewDelete?product_idx=${jungGoNoh.product_idx}&mem_idx=${jungGoNoh.mem_idx}&buyier_idx=${principal.member.mem_idx}";
			}
		}
		 
	
	</script>
	<!-- 헤더 시작 -->
		<jsp:include page="../inc_ex/header.jsp" />
	<link href="${pageContext.request.contextPath}/resources/css/junggo/product_detail.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/resources/css/junggo/common.css" rel="stylesheet">


	</header>
<div id="main_cont">
<%-- 		--------${jungGoNoh}------------ --%>
		<section id="sec_con" class="inr product_view">
		<div class="container">
			<div class= "row">
		<%-- 슬라이드 쇼 --%>
			<div class="slide_wrap col-sm-12 col-lg-6">
				<div class="slide">
					<div class="mySlides">
						<div class="numbertext">1&nbsp;&nbsp;/&nbsp;&nbsp;4</div>
						<img src="${pageContext.request.contextPath}/resources/upload/${jungGoNoh.image1_name}">
					</div>

					<div class="mySlides">
						<div class="numbertext">2&nbsp;&nbsp;/&nbsp;&nbsp;4</div>
						<img src="${pageContext.request.contextPath}/resources/upload/${jungGoNoh.image2_name}">
					</div>

					<div class="mySlides">
						<div class="numbertext">3&nbsp;&nbsp;/&nbsp;&nbsp;4</div>
						<img src="${pageContext.request.contextPath}/resources/upload/${jungGoNoh.image3_name}">
					</div>

					<div class="mySlides">
						<div class="numbertext">4&nbsp;&nbsp;/&nbsp;&nbsp;4</div>
						<img src="${pageContext.request.contextPath}/resources/upload/${jungGoNoh.image4_name}">
					</div>
					<a class="prev" onclick="plusSlides(-1)">❮</a> <a class="next" onclick="plusSlides(1)">❯</a>
				</div>

				<div class="G1">
					<div class="column">
						<img class="demo cursor" src="${pageContext.request.contextPath}/resources/upload/${jungGoNoh.image1_name}" onclick="currentSlide(1)">
					</div>
					<div class="column">
						<img class="demo cursor" src="${pageContext.request.contextPath}/resources/upload/${jungGoNoh.image2_name}" onclick="currentSlide(2)">
					</div>
					<div class="column">
						<img class="demo cursor" src="${pageContext.request.contextPath}/resources/upload/${jungGoNoh.image3_name}" onclick="currentSlide(3)">
					</div>
					<div class="column">
						<img class="demo cursor" src="${pageContext.request.contextPath}/resources/upload/${jungGoNoh.image4_name}" onclick="currentSlide(4)">
					</div>
				</div>
			</div>
			<script>
			let slideIndex = 1;
			showSlides(slideIndex);

			function plusSlides(n) {
				showSlides(slideIndex += n);
			}

			function currentSlide(n) {
				showSlides(slideIndex = n);
			}

			function showSlides(n) {
				let i;
				let slides = document.getElementsByClassName("mySlides");
				let dots = document.getElementsByClassName("demo");
				if (n > slides.length) {
					slideIndex = 1
				}
				if (n < 1) {
					slideIndex = slides.length
				}
				for (i = 0; i < slides.length; i++) {
					slides[i].style.display = "none";
				}
				for (i = 0; i < dots.length; i++) {
					dots[i].className = dots[i].className
							.replace(" active", "");
				}
				slides[slideIndex - 1].style.display = "block";
				dots[slideIndex - 1].className += " active";
			}
			
	
			
			function changeFavorite(selFav){

				}



			</script>
			<%-- 슬라이드쇼 끝 --%>
			
			
			<div class="view_info col-sm-12 col-lg-6">

				<div class="view_cont">
					<p class="product_catrgory">&nbsp;&nbsp;&nbsp;&nbsp;
					<a href="${pageContext.request.contextPath}">HOME</a> 
						> 
					<a href="${pageContext.request.contextPath}/JunggoSearch?lc_code=${jungGoNoh.lc_code}">${jungGoNoh.lc_name}</a> 
						> 
					<a href="${pageContext.request.contextPath}/JunggoSearch?lc_code=${jungGoNoh.lc_code}&mc_code=${jungGoNoh.mc_code}">${jungGoNoh.mc_name}</a>
<%-- 						<c:choose> --%>
<%-- 							<c:when test="${jungGoNoh.lc_code == '1'}"> --%>
<!-- 								남성 > -->
<%-- 								<c:choose> --%>
<%-- 									<c:when test="${jungGoNoh.mc_code == 1}">운동화</c:when> --%>
<%-- 									<c:when test="${jungGoNoh.mc_code == 2}">구두</c:when>						 --%>
<%-- 								</c:choose> --%>
<%-- 							</c:when> --%>
<%-- 							<c:when test="${jungGoNoh.lc_code == '2'}"> --%>
<!-- 								여성 >  -->
<%-- 								<c:choose> --%>
<%-- 									<c:when test="${jungGoNoh.mc_code == 1}">운동화</c:when> --%>
<%-- 									<c:when test="${jungGoNoh.mc_code == 2}">구두</c:when>						 --%>
<%-- 								</c:choose> --%>
<%-- 							</c:when> --%>
<%-- 						</c:choose> --%>
					 
					</p>
					<div class="product_name">
						<h4>${jungGoNoh.product_title} </h4><span class="product_progress">${jungGoNoh.product_sell_status}</span>
						<p><fmt:formatNumber value="${jungGoNoh.product_price}" pattern="#,###"/>원(₩)</p>
					</div>
					
					
					
					<div class="product_viewStatus">
						<div class="view_status">
						🕐&nbsp;<span id="prd_date"></span> &nbsp;👁‍🗨&nbsp; ${jungGoNoh.product_readcount} &nbsp;❤️&nbsp;  ${jungGoNoh.dibs_count } &nbsp;🔔&nbsp; ${jungGoNoh.report_count }
						</div>
						<div class="reportBtn">
						<a href="${pageContext.request.contextPath}/reportCountTable?product_idx=${jungGoNoh.product_idx}&mem_idx=${jungGoNoh.mem_idx}" class="report_btn" onclick="window.open(this.href, '_blank', 'width=500, height=400'); return false;">신고조회</a>
						</div>
					</div>
					<div class="product_productStatus">
						상품 상태 : ${jungGoNoh.product_status}<br>
						사이즈 : ${jungGoNoh.product_size}	mm<br>
						브랜드 : ${jungGoNoh.product_brand}<br>
						거래지역 : ${jungGoNoh.product_location}<br>
						거래 방법 : ${jungGoNoh.product_payment}<br>
<%-- 						접속한사람: ${principal.member.mem_id} --%>
<%-- 						파는사람:	${jungGoNoh.mem_id}		 --%>
<%-- 						접속한 사람 idx: ${principal.member.mem_idx} --%>
<%-- 						파는사람idx : ${jungGoNoh.mem_idx}  --%>
								
					</div>
					<script>
					function removeSecond(){
						let productIDate = document.querySelector('#prd_date');
						
						
						let productID = "${jungGoNoh.product_date}";
						
						productIDate.innerText = productID.slice(0,productID.length-2);
						
					}
					removeSecond();
					</script>
<!-- 						<div class="product_tag"> -->
<!-- 						#바지 #바지 #바지 #바지 #바지 -->
					</div>
				
					
					<div class="button_array">
						
						<form action="dibsPro" method="post" enctype="multipart/form-data" class ="muti_button">						
							<input type="hidden" name="product_idx" id="product_idx" value="${jungGoNoh.product_idx}"/>
							<input type="hidden" name="favorite_check" id="favorite_check" value="${dibs.favorite_check}"/>
							<input type="hidden" name="mem_id" id="mem_id" value="${jungGoNoh.mem_id}"/>
							<input type="hidden" name="mem_idx" id="mem_idx" value="${jungGoNoh.mem_idx}"/>
<%-- 							<a href="${pageContext.request.contextPath}/cancelOrComplete?product_idx=${jungGoNoh.product_idx}&mem_idx=${jungGoNoh.mem_idx}&buyier_idx=${principal.member.mem_idx}" class="warning_message">임시 버튼</a> --%>
							
							<!-- buyier_idx 미접속시 0으로 받아오게끔 하기-->
							<c:choose>
								<c:when test="${empty principal.member.mem_idx}">
								    <input type="hidden" name="buyier_idx" id="buyier_idx" value="0"/>
								</c:when>
								<c:otherwise>
								   <input type="hidden" name="buyier_idx" id="buyier_idx" value="${principal.member.mem_idx}"/>
								</c:otherwise>
							</c:choose>
							
							<!-- buyier_idx 미접속시 0으로 받아오게끔 하기-->
							
							<c:choose>
								<c:when test="${principal.member.mem_idx == jungGoNoh.mem_idx }">
									<a href="${pageContext.request.contextPath}/junggoModifyForm?product_idx=${jungGoNoh.product_idx}&mem_idx=${jungGoNoh.mem_idx}&buyier_idx=${principal.member.mem_idx}" class="modify_Btn">수정하기</a>
									<button type="button"  class="delete_btn" onclick="deleteConfirmPD()">삭제하기</button>								
								</c:when>
								<c:otherwise>
									<c:choose>
										<c:when test="${dibs.favorite_check =='Y' }">
											<input type="submit"  class="UnFavorite_btn" value="💔 찜 해제">
										</c:when>
										<c:otherwise>
											<input type="submit" class="favorite_btn" value="♥ 찜 등록"/>		
										</c:otherwise>
									</c:choose>
								</c:otherwise>
							</c:choose>
						</form>		
				
										
						<%-- 0801 - 경인 수정 1:1대화 누를시 채팅 작업 트리거 --%>
						<form id="jungChatForm" action="JungChat" method="POST">
							<input type="hidden" name="product_idx" value="${jungGoNoh.product_idx }">
							<a href="javascript: document.querySelector('#jungChatForm').submit()" class="chat_btn">1:1 대화톡 
		                    </a>
						</form>
						<%-- 채팅 작업 끝 --%>
                    </div>
				</div>
			</div>
		</div>
		
		<div class="container">
			<div class="row">
			<div class="view_more_info more_wrap_box col-sm-12 col-lg-6">
				<p class="view_title">상품 정보</p>
				<div class="more_box">
					<div>
						<p>⚠️&nbsp;&nbsp;거래전 주의 사항</p>
						<br>
						판매자가 별도의 메신저로 결제링크를 보내거나 <br>
						직거래(직접송금)을 유도하는 경우<br> 사기일 가능성이 높으니 거래를 자제해 주시고<br>
						<br>
						<a href="${pageContext.request.contextPath}/registReportForm?product_idx=${jungGoNoh.product_idx}&mem_idx=${jungGoNoh.mem_idx}&buyier_idx=${principal.member.mem_idx}" class="warning_message" onclick="window.open(this.href, '_blank', 'width=800, height=400'); return false;">여기를 클릭하여 중고나라 고객센터로 <br>신고해주시기 바랍니다.</a>
					</div>
				</div>
				<div class="product_content" style="word-break:break-all;">
					${jungGoNoh.product_info}
				</div>
			</div>
			
			<div class="seller_wrap more_wrap_box col-sm-12 col-lg-6">
	
				<div class="seller_profile_wrap">
					<img class="seller_profile" src="${pageContext.request.contextPath}/resources/upload/profile/${jungGoNoh.mem_profileImageUrl}">
					<p class="seller_name">${jungGoNoh.mem_nickname}</p>
					<p class="seller_Lv">${jungGoNoh.mem_rank}</p>
				</div>
				<div class="seller_products">
					<p class="seller_products_title">${jungGoNoh.mem_nickname}님의 상품정보</p>
					<div class="more_product">
						<c:forEach var="moreProductListSmall" items="${moreProductListSmall}">
					
						
						
							<div style=" cursor: pointer;" onclick="location.href='productDetail?product_idx=${moreProductListSmall.product_idx}';">
								<img class="more_product_img" src="${pageContext.request.contextPath}/resources/upload/${moreProductListSmall.image1}">
								<p class="more_product_name">${moreProductListSmall.product_title}</p>
								<span><fmt:formatNumber value="${moreProductListSmall.product_price}" pattern="#,###"/>원</span>
								<p class="more_product_status">${moreProductListSmall.product_sell_status}</p>
							</div>
							
						</c:forEach>	
										
					</div>						
					<div class="review_wrap more_wrap_box">
						<div class="view_tit_sec">
							<p class="view_tit">${jungGoNoh.mem_nickname}에 대한 고객 리뷰</p>
							<a href="${pageContext.request.contextPath }/store/${jungGoNoh.mem_idx}">더보기</a>
						</div>
					</div>
					<div class="more_cont">
<%-- 					<a class="modify_btn" href="${pageContext.request.contextPath}/registJReviewForm?product_idx=${jungGoNoh.product_idx}&mem_idx=${jungGoNoh.mem_idx}&buyier_idx=${principal.member.mem_idx}" onclick="window.open(this.href, '_blank', 'width=500, height=400'); return false;">임시작성</a> --%>
<%-- 							<a class="modify_btn" href="${pageContext.request.contextPath}/modifyJReviewForm?product_idx=${jungGoNoh.product_idx}&mem_idx=${jungGoNoh.mem_idx}&buyier_idx=${principal.member.mem_idx}" onclick="window.open(this.href, '_blank', 'width=500, height=400'); return false;">임시수정</a> --%>
<!-- 							<a class="modify_btn" onclick="deleteConfirmRV()">임시삭제</a> -->
						<div class="rev_cont">  
						
						<c:forEach var="moreReviewListSmall" items="${moreReviewListSmall}">
						<div class="repeat">
						<img class="buyer_profile" src="${pageContext.request.contextPath}/resources/upload/profile/${moreReviewListSmall.mem_profileImageUrl}">
							<span class="rev_name">${moreReviewListSmall.mem_nickname}</span>
							<span class="rev_date">${moreReviewListSmall.review_date}</span>
							<ul class=""> 
								<li class="">
									<span class="write_s">
										<span>
											<!-- 별점 구현 초보, 새로운 거 알면 바꾸기-->
											<c:choose>
	   											<c:when test="${moreReviewListSmall.review_star eq 0 }">
	 												<span>★</span>
													<span>★</span>
													<span>★</span>
													<span>★</span>
													<span>★</span>
	   											</c:when>
	   											<c:when test="${moreReviewListSmall.review_star eq 1 }">
	 												<span class="fill">★</span>
													<span>★</span>
													<span>★</span>
													<span>★</span>
													<span>★</span>
	   											</c:when>
	   											<c:when test="${moreReviewListSmall.review_star eq 2 }">
	 												<span class="fill">★</span>
													<span class="fill">★</span>
													<span>★</span>
													<span>★</span>
													<span>★</span>
	   											</c:when>
	   											<c:when test="${moreReviewListSmall.review_star eq 3 }">
	 												<span class="fill">★</span>
													<span class="fill">★</span>
													<span class="fill">★</span>
													<span>★</span>
													<span>★</span>
	   											</c:when>
	   											<c:when test="${moreReviewListSmall.review_star eq 4 }">
	 												<span class="fill">★</span>
													<span class="fill">★</span>
													<span class="fill">★</span>
													<span class="fill">★</span>
													<span>★</span>
	   											</c:when>
	  											<c:otherwise>
	   												<span class="fill">★</span>
													<span class="fill">★</span>
													<span class="fill">★</span>
	   												<span class="fill">★</span>
													<span class="fill">★</span>
												</c:otherwise>
											</c:choose>
											<!-- 별점 구현 초보 -->
										</span>
									</span>
									<span class="rev_txt">${moreReviewListSmall.review_content}</span>
									<span class="rev_txt_hobertext">${moreReviewListSmall.review_content}</span>
								</li>
							</ul>
							</div>
					</c:forEach>
						</div>
					</div>
				</div>
			</div>
		</div>
	 </div>
	</section>
</div>
	<footer>
		<jsp:include page="../inc_ex/footer.jsp" />
	</footer>
</body>
</html>