<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

	<link href="${pageContext.request.contextPath}/resources/css/junggo/product_detail.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/resources/css/junggo/common.css" rel="stylesheet">
	<%-- 	<link href="${pageContext.request.contextPath}/resources/css/inc/top.css" rel="styleSheet"> --%>
	<%-- 	<link href="${pageContext.request.contextPath}/resources/css/inc/footer.css" rel="styleSheet"> --%>
	<link href="${pageContext.request.contextPath }/resources/css/etc/bootstrap.min.css" rel="stylesheet">
	<script	src="${pageContext.request.contextPath }/resources/js/etc/bootstrap.bundle.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.0.js"></script>
</head>
<body>

	<header>
	<%--top 탑 활성화시 css도 살려야함--%>
<%-- <jsp:include page="../../../inc/top1.jsp"></jsp:include> --%>

<script type="text/javascript">
	function deleteConfirm() {
		if(!confirm("게시글을 삭제 하시겠습니까?")) {
			return false;
		} else {
			location.href="${pageContext.request.contextPath}/productDelete?product_idx=${jungGoNoh.product_idx}";
		}
	}
	

</script>




	</header>
	<%--입력하지 않은 자료 보낼 때--%>
<%-- 		<input type="hidden" name="car_model" value="${map.car_info.car_model}"/> --%>
		
		<section id="sec_con" class="inr product_view">
		<div class="container">
			<div class= "row">
		<%-- 슬라이드 쇼 --%>
			<div class="slide_wrap col-sm-12 col-lg-6">
				<div class="slide">
					<div class="mySlides">
						<div class="numbertext">1&nbsp;&nbsp;/&nbsp;&nbsp;4</div>
						<img src="${pageContext.request.contextPath}/resources/upload/car/${map.car_info.car_file_path}/${map.car_info.car_file2}">
					</div>

					<div class="mySlides">
						<div class="numbertext">2&nbsp;&nbsp;/&nbsp;&nbsp;4</div>
						<img src="${pageContext.request.contextPath}/resources/upload/car/${map.car_info.car_file_path}/${map.car_info.car_file3}">
					</div>

					<div class="mySlides">
						<div class="numbertext">3&nbsp;&nbsp;/&nbsp;&nbsp;4</div>
						<img src="${pageContext.request.contextPath}/resources/upload/car/${map.car_info.car_file_path}/${map.car_info.car_file4}">
					</div>

					<div class="mySlides">
						<div class="numbertext">4&nbsp;&nbsp;/&nbsp;&nbsp;4</div>
						<img src="${pageContext.request.contextPath}/resources/upload/car/${map.car_info.car_file_path}/${map.car_info.car_file5}">
					</div>
					<a class="prev" onclick="plusSlides(-1)">❮</a> <a class="next" onclick="plusSlides(1)">❯</a>
				</div>

				<div class="G1">
					<div class="column">
						<img class="demo cursor" src="${pageContext.request.contextPath}/resources/upload/car/${map.car_info.car_file_path}/${map.car_info.car_file2}" onclick="currentSlide(1)">
					</div>
					<div class="column">
						<img class="demo cursor" src="${pageContext.request.contextPath}/resources/upload/car/${map.car_info.car_file_path}/${map.car_info.car_file3}" onclick="currentSlide(2)">
					</div>
					<div class="column">
						<img class="demo cursor" src="${pageContext.request.contextPath}/resources/upload/car/${map.car_info.car_file_path}/${map.car_info.car_file4}" onclick="currentSlide(3)">
					</div>
					<div class="column">
						<img class="demo cursor" src="${pageContext.request.contextPath}/resources/upload/car/${map.car_info.car_file_path}/${map.car_info.car_file5}" onclick="currentSlide(4)">
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
					<p class="product_catrgory">HOME > ${jungGoNoh.lc_code} > ${jungGoNoh.mc_code} </p>
					<div class="product_name">
						<h4>${jungGoNoh.product_title} </h4><span class="product_progress">${jungGoNoh.product_sell_status}</span>
						<p><fmt:formatNumber value="${jungGoNoh.product_price}" pattern="#,###"/></p>
					</div>
					<div class="product_viewStatus">
						🕐&nbsp;${jungGoNoh.product_date} &nbsp;&nbsp;&nbsp;&nbsp;👁‍🗨&nbsp; ${jungGoNoh.product_readcount} &nbsp;&nbsp;&nbsp;&nbsp;   ❤️&nbsp;  5 - Count(dibs type_num)
					</div>
					<div class="product_productStatus">
						상품 상태 : ${jungGoNoh.product_status}<br>
						사이즈 : ${jungGoNoh.product_size}	mm<br>
						브랜드 : ${jungGoNoh.product_brand}<br>
						거래지역 : ${jungGoNoh.product_location}<br>
						거래 방법 : ${jungGoNoh.product_payment}<br>					
					</div>
<!-- 						<div class="product_tag"> -->
<!-- 						#바지 #바지 #바지 #바지 #바지 -->
					</div>
					<div class="button_array">
												
						<c:choose>
						<c:when test="'N' eq 'N' "> <%--${jungGoNoh.dibs_check}--%> 
								<button type="button"  class="favorite_btn" onclick="sample1();">♥ 찜 등록</button>
							</c:when>
							<c:otherwise>
								<button type="button"  class="UnFavorite_btn" onclick="sample2();">💔 찜 해제</button>
							</c:otherwise>
						</c:choose>
						
	                    <c:choose>
							<c:when test="'N' eq 'N' "><%--${session.sId eq jungGoNoh.member_id }--%>
								<button type="button"  class="delete_btn" onclick="deleteConfirm()">삭제하기</button>
							</c:when>
							<c:otherwise>
								<a href="resPayment?car_idx=${map.car_idx}&res_rental_date=${map.res_rental_date}&res_return_date=${map.res_return_date}
	                             &brc_rent_name=${map.brc_rent_name}&brc_return_name=${map.brc_return_name}" class="chat_btn">
	                    	1:1 대화톡 
	                    		</a>
							</c:otherwise>
						</c:choose>
	                    
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
						판매자가 별도의 메신저로 결제링크를 보내거나 직거래(직접송금)을<br>
						유도하는 경우 사기일 가능성이 높으니 거래를 자제해 주시고<br>
						<span>중고나라 고객센터로 신고해주시기 바랍니다.</span>
					</div>
				</div>
				<div class="product_content">
					${jungGoNoh.product_info}
				</div>
			</div>
			
			<div class="seller_wrap more_wrap_box col-sm-12 col-lg-6">
	
				<div class="seller_profile_wrap">
					<img class="seller_profile" src="${pageContext.request.contextPath}/resources/img/junggo/profile_m.png">
					<p class="seller_name"></p><%--${jungGoNoh.mem_nickname} --%>
					<p class="seller_Lv"></p><%--${jungGoNoh.mem_rank}--%>
				</div>
				<div class="seller_products">
					<p class="seller_products_title">님의 상품정보</p><%--${jungGoNoh.mem_nickname}--%>
					<div class="more_product">
						<div>
							<img class="more_product_img" src="${pageContext.request.contextPath}/resources/img/junggo/first.jpg">
							<p class="more_product_name">사제 군장- (중,경)mem_idx>mem_</p>
							<span>15,000원</span>
						</div>
						<div>
							<img class="more_product_img" src="${pageContext.request.contextPath}/resources/img/junggo/second.jpg">
							<p class="more_product_name">마우스</p>	
							<span>5,000원</span>
						</div>
						<div>
							<img class="more_product_img" src="${pageContext.request.contextPath}/resources/img/junggo/third.jpg">
							<p class="more_product_name">마우스2</p>
							<span>3,000원</span>
						</div>					
					</div>						
					<div class="review_wrap more_wrap_box">
						<div class="view_tit_sec">
							<p class="view_tit">고객 리뷰</p>
							<a href="${pageContext.request.contextPath }/reviewList">더보기</a>
						</div>
					</div>
					<div class="more_cont">
						<div class="rev_cont">
						<%-- <c:forEach var="reviewListS" items="${map.reviewListS }">--%>
						<img class="buyer_profile" src="${pageContext.request.contextPath}/resources/img/junggo/profile_m.png">
							<span class="rev_name">바지산사람DD</span>
							<span class="rev_date">23-07-19</span>
							<ul class=""> 
								<li class="">
									<span class="write_s">
										<span>
											<!-- 별점 구현 초보, 새로운 거 알면 바꾸기-->
											<c:set var="starLank" value="4"/><!-- value=${reviewListS.rev_star} -->
											<c:choose>
	   											<c:when test="${starLank eq 0 }">
	 												<span>★</span>
													<span>★</span>
													<span>★</span>
													<span>★</span>
													<span>★</span>
	   											</c:when>
	   											<c:when test="${starLank eq 1 }">
	 												<span class="fill">★</span>
													<span>★</span>
													<span>★</span>
													<span>★</span>
													<span>★</span>
	   											</c:when>
	   											<c:when test="${starLank eq 2 }">
	 												<span class="fill">★</span>
													<span class="fill">★</span>
													<span>★</span>
													<span>★</span>
													<span>★</span>
	   											</c:when>
	   											<c:when test="${starLank eq 3 }">
	 												<span class="fill">★</span>
													<span class="fill">★</span>
													<span class="fill">★</span>
													<span>★</span>
													<span>★</span>
	   											</c:when>
	   											<c:when test="${starLank eq 4 }">
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
							
									<span class="rev_txt">좋은 거래였습니다</span>
								</li>
							</ul>
					<%--</c:forEach> --%>
						</div>
					</div>
				</div>
			</div>
		</div>
	 </div>
	</section>
	<footer>
	<%--footer 풋터 활성화 시 css도 살려야함--%>
<%-- 		<jsp:include page="../../../inc/footer.jsp"></jsp:include> --%>
	</footer>
</body>
</html>