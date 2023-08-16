<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ include file="../../inc_ex/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>shocream - 마이페이지</title>
<link rel="shortcut icon"href="${pageContext.request.contextPath }/resources/img/member/mem_mypage/shoecream-logo.png">

<!--아이콘-->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />

<!-- 부트스트랩 -->
<link href="${pageContext.request.contextPath }/resources/css/etc/bootstrap.min.css" rel="stylesheet">

<!-- 부트스트랩 icon -->
<!-- <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css"> -->

<!--CSS-->
<%-- <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/member/market/common.css"> --%>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/member/market/index.css">
<%-- <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/member/goods/goods_comon.css"> --%>
<%-- <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/main_ex/market/common.css"> --%>

<%-- <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/member/social/style.css"> --%>
<%-- <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/member/social/story.css"> --%>
<%-- <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/member/social/popular.css"> --%>
<%-- <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/member/social/profile.css"> --%>
<%-- <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/member/social/upload.css"> --%>
<%-- <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/member/social/update.css"> --%>
<%-- <link rel="shortcut icon" href="${pageContext.request.contextPath }/resources/img/member/social/insta.svg"> --%>


<link href="${pageContext.request.contextPath }/resources/css/member/common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/resources/css/member/mem_page/mem_info_update.css" rel="stylesheet">

<!-- 상점 메뉴(중고판매내역... 후기까지) CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/member/market/market_my_store.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/member/goods/goods_history.css">

<!-- js -->
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>
<script	src="${pageContext.request.contextPath }/resources/js/member/market/menu_hover.js"></script>
<script	src="${pageContext.request.contextPath }/resources/js/member/store/store_menu.js"></script>
<script	src="${pageContext.request.contextPath }/resources/js/member/goods/goods_history_common.js"></script>
<script	src="${pageContext.request.contextPath }/resources/js/member/goods/goods_buy_history.js"></script>
<script	src="${pageContext.request.contextPath }/resources/js/member/store/store.js"></script>

</head>

<style>
.left-box {
  float: left;
  width: 50%;
}

.right-box {
  float: right;
  width: 50%;
}

.goods_info {
	padding: 0px 0px;
}

.goods_info h2.goods_title {
	padding-bottom: 0px;
}

#my_store_right_mid > div {
    display: inline-block;
    margin-right: 0px;
}

.btn_confirm {
    display: flex;
    line-height: 1;
}
.btn_confirm {
    color: #fff;
}

 .btn-half-height {
     font-size: 0.5rem !important;
     padding: 0.25rem 0.5rem !important;
 }
 
.btn-half-height {
  height: 50%;
}

.goods_image img {
    width: 94px;
    height: 94px;
}

.btn-check-label {
  font-size: 13px;
}

.ReviewImage {
 border-radius: 70%;
}

.goods_date {
  font-size:13px; 
  color:#6c757d;
}

.goods_button {
  font-size:14px;
}

.reviewStar {
	text-shadow: 0 0 0 #FFA500;
	color :transparent;
}

.btn btn-light btn-half-height {
	font-size: 14px;
}

  .my_store_menu_content_wrapper {
    margin: 0;
    max-width: 100%;
  }

  .menu_bar {
    margin: 0 auto;
  }
  
   

 }
</style>


<body>
<script type="text/javascript">

/* [바로구매]버튼을 클릭하면 계좌이체를 할 수 있는 새창이 띄워짐 */
function payAuction(idx, price, id, title){
    window.open("auction_bank_userInfo?auction_idx="+idx+"&auction_final_price="+price+"&member_id="+id+"&auction_title="+title , "바로구매새창", "width=800, height=1200" );
// 	alert(idx + " " + price + " " + id + " " + title)
}

// $(function() {
//     $(document).on("click", ".payAuction", function() {
//          var idx = $(this).attr("title");
//          var price = $(this).attr("value");
//          payAuction(idx, price);
//      })
//  });
 
//  document.getElementById("reportDiv").style.display="none";
//  document.getElementById("reportDiv").style.display="block";
 
</script>
	<!-- 헤더 시작 -->
<%-- 	<jsp:include page="../../inc_ex/header_social.jsp" /> --%>
	<!-- main_content 영역 -->
	<div id="main_content">
		<!-- 프로필 영역 -->
		<div class="container" style="margin-top: 200px;">
		    <div class="row">
		        <div class="col-md-12">
		            <div class="d-flex my-3">
		                <div class="col-md-2">
		                    <div class="profile_thumb">
		                        <input type="file" id="profileImageFile" name="profileImageFile" accept="image/jpeg,image/png" hidden="hidden" onchange="handleImageChange(event)">
		                        <img src="${pageContext.request.contextPath}/resources/upload/profile/${storeInfo.mem_profileImageUrl}" alt="사용자 이미지" class="thumb_img rounded-circle" onerror="this.src='https://kream.co.kr/_nuxt/img/blank_profile.4347742.png'" style="object-fit: cover; width: 100px; height: 100px;">
		                    </div>
		                </div>
		                <div class="col-md-6 d-flex flex-column">
		                    <div class="profile_detail">
		                        <strong class="name">${storeInfo.mem_nickname}</strong>
		                    </div>
		                    <div class="mem_email">
		                   	 	<p class="text-black-50">${storeInfo.mem_email}</p>
		                    </div>
		                    <c:choose>
		                    	<c:when test="${principal.member.mem_idx == storeInfo.mem_idx }">
				                    <div class="profile_btn_box mt-auto">
				                        <button type="button" class="btn btn-outline-secondary btn-sm" onclick="location.href='${pageContext.request.contextPath }/mypage/profile'">프로필 관리</button>
				                        <button type="button" class="btn btn-outline-secondary btn-sm" onclick="location.href='${pageContext.request.contextPath }/social/${mem_idx}'">내 소셜</button>
				                    </div>                    	
		                    	</c:when>
		                    	<c:otherwise>
		                    		<div class="profile_btn_box mt-auto">
				                        <button type="button" class="btn btn-outline-secondary btn-sm" onclick="location.href='${pageContext.request.contextPath }/social/${mem_idx}'">${storeInfo.mem_nickname }님 소셜</button>
		                    		</div> 
		                    	</c:otherwise>
		                    </c:choose>
		                </div>
		                 <div class="col-md-2">
		                    <div class="member_rank d-flex flex-column align-items-center justify-content-center">
		                        <a class="membership_item disabled" style="text-decoration: none;">
		                            <strong class="info" style="color: black;"> 일반 회원 </strong>
		                            <p class="title" style="color: gray;">회원 등급</p>
		                        </a>
		                    </div>
		                </div>
		                <div class="col-md-2">
		                    <div class="member_point d-flex flex-column align-items-center justify-content-center">
		                        <a class="membership_item" style="text-decoration: none;">
		                            <strong class="info" style="color: black;">${storeInfo.mem_point }</strong>
		                            <p class="title" style="color: gray;">포인트</p>
		                        </a>
		                    </div>
		                </div>
		            </div>
		        </div>
		    </div>
		</div>
		<!-- 프로필 영역 끝 -->
		
		<!-- 하단 내역 부분 -->
		<div id="my_store_menu">
			<div class="container text-center menu_bar">
				<div class="row">
					<div class="col my_store_menus sales_menu">
						중고판매내역 
					</div>
					<div class="col my_store_menus purchases_menu">
						중고구매내역 
					</div>
					<div class="col my_store_menus auction_menu">
						내 경매 
					</div>
					<div class="col my_store_menus auctionbid_menu">
						경매 참가 내역 
					</div>
					<div class="col my_store_menus secondhandLike_menu">
						내 커스텀
					</div>
					<div class="col my_store_menus auctionLike_menu">
						찜 
					</div>
					<div class="col my_store_menus auctiongoods_menu">
						후기
					</div>
				</div>
			</div>
			<div class="container">
			<div id="my_store_menu_content">
				<div id="sales_menu_area" class="common_menu">
					<div class="row" style="display: flex; justify-content: space-between; align-items: center;">
					    <div class ="col-sm-10">
					        <p>
					            판매내역
					        </p>
					        <!-- 생략된 주석 -->
					    </div>
					    <div class="col-sm-2 justify-content-end">
					        <ul class="goods_cate">
					            <select class="form-selljunggo form-select form-select-sm" aria-label=".form-select-sm example">
					              <option selected>전체</option>
					              <option value="대기중">대기중</option>
					              <option value="예약중">예약중</option>
					              <option value="거래대기중">거래대기중</option>
					              <option value="거래완료">거래완료</option>
					            </select>
					        </ul>
					    </div>
					</div>
					<!-- 최신순 ~ 저가 -->
					<c:set var="productCount" value="${productSellList.size()}"/> 
					
					<div class="container">
						<div class="row">
							<div class="col-1 " style="height:50%">
								<div>전체</div>
							</div>
							<div class="col-8">
								<div class="sc-bqjOQT kIgFPj"><b>${productCount}개</b></div>
							</div>
							<div class="col-auto" style="">
						      <input type="radio" class="btn-check" name="productSellCheck" id="productSellLatest" autocomplete="off" checked>
						      <label class="btn btn-check-label" for="productSellLatest">최신순</label>
						      
						      <input type="radio" class="btn-check" name="productSellCheck" id="productSellPopular" autocomplete="off">
						      <label class="btn btn-check-label" for="productSellPopular">인기순</label>
						      
						      <input type="radio" class="btn-check" name="productSellCheck" id="productSellCheckHigh" autocomplete="off">
						      <label class="btn btn-check-label" for="productSellCheckHigh">고가</label>
						      
						      <input type="radio" class="btn-check" name="productSellCheck" id="productSellCheckLow" autocomplete="off">
						      <label class="btn btn-check-label" for="productSellCheckLow">저가</label>
							</div>
						</div>
					</div>
					<div class="container mt-4">
					  <c:forEach items="${productSellList}" var="productSellList">
					    <!--중고 후기 상품-->
					<%--     <c:if test="${dibList.dibs_type eq '경매상품'}"> --%>
               <div class="goods mb-4">
                        <div class="row no-gutters align-items-end">
                            <div class="col-12 col-md-auto">
                                <a href="${pageContext.request.contextPath}/productDetail?product_idx=${productSellList.product_idx}">
                                    <div class="goods_image" style="width: 94px; height: 94px;">
					               		<c:choose>
											<c:when test="${productSellList.product_sell_status eq '대기중' }">
												<img src="${pageContext.request.contextPath}${productSellList.image_path }/${productSellList.image1}" alt="상품 이미지">
											</c:when>
											<c:when
												test="${productSellList.product_sell_status eq '예약중' }">
												<img src="${pageContext.request.contextPath }${productSellList.image_path }/${productSellList.image1}" alt="상품 이미지">
												<span class="goods_front"> <i class="far fa-check-circle"></i><br> 
												예약중
												</span>
											</c:when>
											<c:when
												test="${productSellList.product_sell_status eq '거래대기중' }">
												<img src="${pageContext.request.contextPath }${productSellList.image_path }/${productSellList.image1}" alt="상품 이미지">
												<span class="goods_front"> <i class="far fa-check-circle"></i><br> 
												거래대기중
												</span>
											</c:when>
											<c:when
												test="${productSellList.product_sell_status eq '거래완료' }">
												<img src="${pageContext.request.contextPath }${productSellList.image_path }/${productSellList.image1}" alt="상품 이미지">
												<span class="goods_front"> <i class="far fa-check-circle"></i><br> 
												거래완료
												</span>
											</c:when>
										</c:choose>
					                </div>
					            </a>
					          </div>
                            <div class="col-12 col-md-2">
                                <div class="goods_info">
                                    <h2 class="goods_title">${productSellList.product_title}</h2>
                                    <p class="goods_price">
                                        <span class="bold">${productSellList.product_price}</span>원
                                    </p>
                                    <p class="goods_shop">${productSellList.mem_nickname}</p>
                                </div>
                            </div>
                            <div class="col-12 col-md-7">
                            </div>
                            <div class="col-12 col-md-auto">
                                <div class="ml-auto">
                                    <div class="goods_date">
                                        <time datetime="${productSellList.product_date}">${productSellList.product_date}</time>
                                    </div>
                                </div>
								<c:choose>
									    <c:when test="${principal.member.mem_idx == storeInfo.mem_idx }">
									        <div class="profile_btn_box mt-auto">
									            <div class="goods_button">
									                <c:choose>
									                    <c:when test="${productSellList.product_sell_status eq '대기중' }"> 
									                        <button type="button" class="btn btn-light btn-half-height" style="width: 53px; height:30px; margin-top:40px;" onclick="location.href='${pageContext.request.contextPath}/junggoModifyForm?product_idx=${productSellList.product_idx }&mem_idx=${productSellList.mem_idx }&buyier_idx=${productSellList.mem_idx }'">수정</button>
									                        <button type="button" class="btn btn-light btn-half-height" style="width: 53px; height:30px; margin-top:40px;" onclick="location.href='${pageContext.request.contextPath}/productDelete?product_idx=${productSellList.product_idx }&mem_idx=${productSellList.mem_idx }&buyier_idx=${productSellList.mem_idx }'">삭제</button>
									                    </c:when>
									                    <c:when test="${productSellList.product_sell_status eq '예약중' }">
									                        <button type="button" class="btn btn-light btn-half-height" style="width: 53px; height:30px; margin-top:40px;" onclick="location.href='${pageContext.request.contextPath}/chatRooms?chat_area=0&chat_room_idx=${productSellList.chat_room_idx }'">채팅</button>
									                    </c:when>
									                    <c:when test="${productSellList.product_sell_status eq '거래대기중' }">
									                        <button type="button" class="btn btn-light btn-half-height" style="width: 53px; height:30px; margin-top:40px;" onclick="location.href='${pageContext.request.contextPath}/chatRooms?chat_area=0&chat_room_idx=${productSellList.chat_room_idx }'">채팅</button>
									                    </c:when>
									                    <c:when test="${productSellList.product_sell_status eq '거래완료' }">
									                        <button type="button" class="btn btn-light btn-half-height" style="width: 53px; height:30px; margin-top:40px;" onclick="location.href='${pageContext.request.contextPath}/productDelete?product_idx=${productSellList.product_idx }&mem_idx=${productSellList.mem_idx }&buyier_idx=${productSellList.mem_idx }'">삭제</button>
									                    </c:when>
									                </c:choose>
									            </div>
									        </div>                     
									    </c:when>
									    <c:otherwise>
									        <div class="profile_btn_box mt-auto">
									            <button type="button" class="btn btn-light btn-half-height" style="width: 53px; height:30px; margin-top:40px;" onclick="location.href='${pageContext.request.contextPath}/productDetail?product_idx=${productSellList.product_idx}'">상세보기</button>
									        </div> 
									    </c:otherwise>
									</c:choose>
		                            </div>
		                        </div>
		                    </div>
		                </c:forEach>
		            </div>
				</div>
				<!-- 판매 내역 끝 -->
				
				<!-- 구매 내역 시작  -->
				<div id="purchases_menu_area" class="common_menu">
					<div style="display: flex; justify-content: space-between; align-items: center;">
					    <div>
					        <p>
					            구매내역
					        </p>
					        <!-- 생략된 주석 -->
					    </div>
					    <div class="">
					        <ul class="goods_cate">
                                <select class="form-buyjunggo form-select form-select-sm" aria-label=".form-select-sm example">					              <option selected>전체</option>
					              <option value="결제완료">결제완료</option>
					              <option value="거래완료">거래완료</option>
					              <option value="결제취소">결제취소</option>
					              <option value="거래취소">거래취소</option>
					            </select>
					        </ul>
					    </div>

					</div>
<%-- 					<c:set var="productCount" value="${productSellList.size()}"/>  --%>
					
						 <div class="container">
							<div class="row">
								<div class="col-1">
									<div>전체</div>
								</div>
								<div class="col-8">
									<div class="sc-bqjOQT kIgFPj"><b>${productBuyList.size()}개</b></div>
								</div>
								<div class="col-auto" style="">
							      <input type="radio" class="btn-check" name="productBuyCheck" id="productBuyLatest" autocomplete="off" checked>
							      <label class="btn btn-check-label" for="productBuyLatest">최신순</label>
							      
							      <input type="radio" class="btn-check" name="productBuyCheck" id="productBuyPopular" autocomplete="off">
							      <label class="btn btn-check-label" for="productBuyPopular">인기순</label>
							      
							      <input type="radio" class="btn-check" name="productBuyCheck" id="productBuyCheckHigh" autocomplete="off">
							      <label class="btn btn-check-label" for="productBuyCheckHigh">고가</label>
							      
							      <input type="radio" class="btn-check" name="productBuyCheck" id="productBuyCheckLow" autocomplete="off">
							      <label class="btn btn-check-label" for="productBuyCheckLow">저가</label>
								</div>
							</div>
						</div>
					<div>
						<!-- 구매 내역 메인 컨텐츠 -->
						<!--반품 모달-->
						<div class="modal_return_area hidden">
							<div class="return_bg bg"></div>
							<div class="return_modal">
								<h2>알림</h2>
								<p>반품신청 하시겠습니까?</p>
								<div class="btn_area">
									<button type="button" class="btn_no">아니요</button>
									<button type="button" class="btn_yes">네</button>
								</div>
							</div>
						</div>
						<!--상품수령 모달-->
						<div class="modal_decide_area hidden">
							<div class="decide_bg bg"></div>
							<div class="decide_modal">
								<div class="decide_content">
									<h2>상품을 수령하셨나요?</h2>
									<p>
										구매확정 후에는 취소할 수 없습니다.<br> 만약 상품 수령 전에 미리 구매확정을 할 경우 사기 위험에
										노출될 수 있습니다.<br> (불법적 금융대출 목적으로 이용 시 금융거래에 불이익을 받을 수
										있습니다.)
									</p>
								</div>
								<div class="btn_area">
									<button type="button" class="btn_no">아니요</button>
									<button type="button" class="btn_yes">네</button>
								</div>
							</div>
						</div>
						<!--리뷰 모달-->
						<div class="modal_review_area hidden">
							<div class="review_bg bg"></div>
							<div class="review_modal">
								<h2>알림</h2>
								<p>
									후기는 앱에서만 작성할 수 있습니다 <br> 작성하시겠습니까?
								</p>
								<div class="btn_area">
									<button type="button" class="btn_no">아니요</button>
									<button type="button" class="btn_yes">네</button>
								</div>
							</div>
						</div>
					<div class="container mt-4">
					  <c:forEach items="${productBuyList}" var="productBuyList">
					    <!--중고 후기 상품-->
					<%--     <c:if test="${dibList.dibs_type eq '경매상품'}"> --%>
					      <div class="goods mb-4">
					        <div class="row no-gutters">
					
					          <div class="col-12 col-md-auto">
					            <a href="${pageContext.request.contextPath}/productDetail?product_idx=${productBuyList.product_idx}">
					                <div class="goods_image" style="width: 94px; height: 94px;">
					                    <!-- 실제 이미지 구현 부분 -->
											<c:choose>
											<c:when test="${productBuyList.pay_status eq '결제완료' }">
												<img src="${pageContext.request.contextPath}${productBuyList.image_path }/${productBuyList.image1}" alt="상품 이미지">
												<span class="goods_front"> <i class="far fa-check-circle"></i><br> 
												결제완료
												</span>
											</c:when>
											<c:when
												test="${productBuyList.pay_status eq '거래완료' }">
												<img src="${pageContext.request.contextPath }${productBuyList.image_path }/${productBuyList.image1}" alt="상품 이미지">
												<span class="goods_front"> <i class="far fa-check-circle"></i><br> 
												거래완료
												</span>
											</c:when>
											<c:when
												test="${productBuyList.pay_status eq '결제취소' }">
												<img src="${pageContext.request.contextPath }${productBuyList.image_path }/${productBuyList.image1}" alt="상품 이미지">
												<span class="goods_front"> <i class="far fa-check-circle"></i><br> 
												결제취소
												</span>
											</c:when>
											<c:when
												test="${productBuyList.pay_status eq '거래취소' }">
												<img src="${pageContext.request.contextPath }${productBuyList.image_path }/${productBuyList.image1}" alt="상품 이미지">
												<span class="goods_front"> <i class="far fa-check-circle"></i><br> 
												거래취소
												</span>
											</c:when>
										</c:choose>
					                </div>
					            </a>
					          </div>
					          <div class="col-12 col-md-2">
					            <div class="goods_info">
					              <h2 class="goods_title">${productBuyList.product_title}</h2>
					              <p class="goods_price">
					                <span class="bold">${productBuyList.product_price}</span>원
					              </p>
					              <p class="goods_shop">${productBuyList.seller_nickname}</p>
					            </div>
					          </div>
					            <div class="col-12 col-md-7">
					<%--               <p class="goods_date" style=" width: 400px;" >${productSellList.review_content}</p> --%>
					          	</div>
                            <div class="col-12 col-md-auto">
                                <div class="ml-auto">
                                    <div class="goods_date">
                                        <time datetime="${productBuyList.product_date}">${productBuyList.product_date}</time>
                                    </div>
                                </div>
								<c:choose>
									    <c:when test="${principal.member.mem_idx == storeInfo.mem_idx }">
									        <div class="profile_btn_box mt-auto">
									            <div class="goods_button">
									                <c:choose>
														<c:when test="${productBuyList.pay_status eq '결제완료' }">
									                        <button type="button" class="btn btn-light btn-half-height" style="width: 53px; height:30px; margin-top:40px;" onclick="location.href='${pageContext.request.contextPath}/chatRooms?chat_area=0&chat_room_idx=${productBuyList.chat_room_idx }'">채팅</button>
									                    </c:when>
									                    <c:when test="${productBuyList.pay_status eq '거래완료' }">
									                        <button type="button" class="btn btn-light btn-half-height" style="width: 53px; height:30px; margin-top:40px;" onclick="location.href='${pageContext.request.contextPath}/chatRooms?chat_area=0&chat_room_idx=${productBuyList.chat_room_idx }'">채팅</button>
									                        <button type="button" class="btn btn-light btn-half-height" style="width: 53px; height:30px; margin-top:40px;" onclick="location.href='${pageContext.request.contextPath}/productDelete?product_idx=${productBuyList.product_idx }&mem_idx=${productBuyList.mem_idx }&buyier_idx=${productBuyList.mem_idx }'">삭제</button>
									                    </c:when>
									                    <c:when test="${productBuyList.pay_status eq '결제취소' }">
									                        <button type="button" class="btn btn-light btn-half-height" style="width: 53px; height:30px; margin-top:40px;" onclick="location.href='${pageContext.request.contextPath}/chatRooms?chat_area=0&chat_room_idx=${productBuyList.chat_room_idx }'">채팅</button>
									                    </c:when>
									                    <c:when test="${productBuyList.pay_status eq '거래취소' }">
									                        <button type="button" class="btn btn-light btn-half-height" style="width: 53px; height:30px; margin-top:40px;" onclick="location.href='${pageContext.request.contextPath}/productDelete?product_idx=${productBuyList.product_idx }&mem_idx=${productBuyList.mem_idx }&buyier_idx=${productBuyList.mem_idx }'">삭제</button>
									                    </c:when>
									                </c:choose>
									            </div>
									        </div>                     
									    </c:when>
									    <c:otherwise>
									        <div class="profile_btn_box mt-auto">
									            <button type="button" class="btn btn-light btn-half-height" style="width: 53px; height:30px; margin-top:40px;" onclick="location.href='${pageContext.request.contextPath}/productDetail?product_idx=${productBuyList.product_idx}'">상세보기</button>
									        </div> 
									    </c:otherwise>
									</c:choose>
		                            </div>
					        </div>
					      </div>
					<%--     </c:if> --%>
					  </c:forEach>
					</div>
					</div>
				</div>
				<!-- 구매 내역 끝 -->
					
				<!-- 내 경매 시작 -->
				<div id="auction_menu_area" class="common_menu">
					<div style="display: flex; justify-content: space-between; align-items: center;">
					    <div>
					        <p>
					            내 경매
					        </p>
					        <!-- 생략된 주석 -->
					    </div>
					    <div class="">
					        <ul class="goods_cate">
					            <select class="form-auction form-select form-select-sm" aria-label=".form-select-sm example">
					              <option selected>전체</option>
					              <option value="대기">대기</option>
					              <option value="진행">진행</option>
					              <option value="마감">마감</option>
					            </select>
					        </ul>
					    </div>
					</div>
					<div class="container mt-4">
					  <c:forEach items="${auctionList}" var="auctionList">
					    <!--경매 상품-->
					      <div class="goods mb-4">
					        <div class="row no-gutters">
					          <div class="col-12 col-md-auto">
					            <a href="${pageContext.request.contextPath }/AuctionDetail?auction_idx=${auctionList.auction_idx}">
					              <div class="goods_image" style=" width: 94px; height: 94px;">
									<c:choose>
										<c:when	test="${auctionList.auc_state eq '대기' }">
											<img src="${pageContext.request.contextPath }${auctionList.image_path }/${auctionList.image1}" alt="상품 이미지">
											<span class="goods_front"> 경매 대기 중 </span>
										</c:when>
										<c:when	test="${auctionList.auc_state eq '진행' }">
											<img src="${pageContext.request.contextPath }${auctionList.image_path }/${auctionList.image1}" alt="상품 이미지">
											<span class="goods_front"> 경매 진행 중 </span>
										</c:when>
										<c:when test="${auctionList.auc_state eq '마감' }">
											<img src="${pageContext.request.contextPath }${auctionList.image_path}/${auctionList.image1}" alt="상품 이미지">
											<span class="goods_front"> <i class="far fa-check-circle"></i><br> 
											경매 마감
											</span>
										</c:when>
									</c:choose>
					              </div>
					            </a>
					          </div>
					          <div class="col-12 col-md-9">
					            <div class="goods_info">
					              <h2 class="goods_title">${auctionList.auction_title}</h2>
					              <p class="goods_price">
					               <c:choose>
					                   <c:when test="${auctionList.auc_state eq '대기' }">
					                       <span class="bold">경매 시작전</span>
					                       <p class="goods_date">경매 시작 시간 : ${auctionList.auc_regist_date}</p>
					                   </c:when>
					                   <c:when test="${auctionList.auc_state eq '진행' }">
					                       <c:choose>
                                                <c:when test="${auctionList.bid_price eq null }">
									                <span class="bold">입찰 없음</span>
                                                    <p class="goods_date">경매 마감 시간 : ${auctionList.auc_close_date}
<%--                                                         <fmt:formatDate value="${auctionList.auc_close_date}" pattern="yyyy-MM-dd HH:mm"/> --%>
                                                    </p>
                                                </c:when>
                                                <c:when test="${auctionList.bid_price ne null }">
									                <span class="bold">현재 입찰가 : ${auctionList.bid_price}</span>원
                                                    <p class="goods_date">경매 마감 시간 : ${auctionList.auc_close_date}
<%--                                                         <fmt:formatDate value="${auctionList.auc_close_date}" pattern="yyyy-MM-dd HH:mm"/> --%>
                                                    </p>
                                                </c:when>
					                       </c:choose>
					                   </c:when>
					                   <c:when test="${auctionList.auc_state eq '마감' }">
					                       <c:choose>
					                           <c:when test="${auctionList.bid_price eq null }">
									                <span class="bold">입찰 없음</span>
					                           </c:when>
					                           <c:when test="${auctionList.bid_price ne null && auctionList.bid_state eq '낙찰'}">
									                <span class="bold">낙찰가 : ${auctionList.bid_price }</span>
					                           </c:when>
					                           <c:when test="${auctionList.bid_price ne null && auctionList.bid_state eq '즉시구매'}">
									                <span class="bold">즉시구매가 : ${auctionList.bid_price }</span>
					                           </c:when>
					                       </c:choose>
					                   </c:when>
					               </c:choose>
					              </p>
					            </div>
					          </div>
					            <div class="col-12 col-md-auto">
					                <div class="ml-auto">
					                    <div class="goods_date">
										    <time datetime="${auctionList.auction_date}">${auctionList.auction_date}</time>
										</div>
										<div>
											<c:choose>
												<c:when test="${auctionList.auc_state eq '대기' }">
							                    	<button type="button" class="btn btn-light btn-half-height" style="width: 53px; height:30px; margin-top:40px;" onclick="location.href='${pageContext.request.contextPath }/AuctionModifyForm?auction_idx=${auctionList.auction_idx}'">수정</button>
							                    	<button type="button" class="btn btn-light btn-half-height" style="width: 53px; height:30px; margin-top:40px;" onclick="aucDeleteConfirm(${auctionList.auction_idx})">삭제</button>
												</c:when>
												<c:when test="${auctionList.auc_state eq '진행' }">
													<c:if test="${auctionList.bid_price eq null }">
    							                    	<button type="button" class="btn btn-light btn-half-height" style="width: 53px; height:30px; margin-top:40px;" onclick="location.href='${pageContext.request.contextPath }/AuctionModifyForm?auction_idx=${auctionList.auction_idx}'">수정</button>
    							                    	<button type="button" class="btn btn-light btn-half-height" style="width: 53px; height:30px; margin-top:40px;" onclick="aucDeleteConfirm(${auctionList.auction_idx})">삭제</button>
													</c:if>
												</c:when>
												<c:when test="${auctionList.auc_state eq '마감' }">
													<c:choose>
														<c:when test="${auctionList.bid_price ne null }"> <!-- 입찰이 있을경우 -->
															<c:choose>
																<c:when test="${auctionList.pay_status eq '결제완료' }"> <!-- 결제완료시 -->
																	<c:choose>
																		<c:when test="${auctionList.tracking_num eq null }"> <!-- 운송장 미등록시 -->
                                                                            <button type="button" class="btn btn-light btn-half-height" style="width: 53px; height:30px; margin-top:40px;" onclick="window.open('${pageContext.request.contextPath }/deliveryInfo?auction_idx=${auctionList.auction_idx}', '구매자정보', 'width=580, height=550, left=100, top=50')">구매자 정보</button>
                                                                            <button type="button" class="btn btn-light btn-half-height" style="width: 53px; height:30px; margin-top:40px;" onclick="window.open('${pageContext.request.contextPath }/trackingRegisterForm?auction_idx=${auctionList.auction_idx}', '운송장 등록', 'width=580, height=360, left=100, top=50')">운송장 등록</button>
																		</c:when>
																		<c:when test="${auctionList.tracking_num ne null }"> <!-- 운송장 등록시 -->
                                                                            <button type="button" class="btn btn-light btn-half-height" style="width: 53px; height:30px; margin-top:40px;" onclick="location.href=''">뭘로하지</button>
																		</c:when>
																	</c:choose>
																</c:when>
																<c:otherwise> <!-- 결제 완료 외 -->
																	
																</c:otherwise>
															</c:choose>
														</c:when>
														<c:when test="${auctionList.bid_price eq null }"> <!-- 입찰이 없을경우 -->
															<!-- 재등록이나 기간연장으로 대체 -->
														</c:when>
													</c:choose>
												</c:when>
											
											</c:choose>
					                	</div>
					                </div>
					            </div>
					        </div>
					      </div>
				        </c:forEach>
				    </div>
                </div>
				<!-- 내 경매 끝 -->	
				<!-- 경매참가내역 시작 -->
					<div id="auctionbid_menu_area" class="common_menu">
					<div style="display: flex; justify-content: space-between; align-items: center;">
					    <div>
					        <p>
					            경매 참가 내역
					        </p>
					        <!-- 생략된 주석 -->
					    </div>
					    <div class="">
					        <ul class="goods_cate">
					            <select class="form buyAuction form-select form-select-sm" aria-label=".form-select-sm example">
					              <option selected>전체</option>
					              <option value="입찰">입찰</option>
					              <option value="낙찰">낙찰</option>
					              <option value="유찰">유찰</option>
					              <option value="즉시구매">즉시구매</option>
					            </select>
					        </ul>
					    </div>
					</div>
				<div class="container mt-4">
				  <c:forEach items="${auctionBidList}" var="auctionList">
				    <!--경매 상품-->
				      <div class="goods mb-4">
				        <div class="row no-gutters">
				
				          <div class="col-12 col-md-auto">
				            <a href="${pageContext.request.contextPath }/AuctionDetail?auction_idx=${auctionList.auction_idx}">
				              <div class="goods_image" style=" width: 94px; height: 94px;">
								<c:choose>
									<c:when	test="${auctionList.bid_state eq '입찰' }">
										<img src="${pageContext.request.contextPath }${auctionList.image_path }/${auctionList.image1}" alt="상품 이미지">
										<span class="goods_front"> 입찰 </span>
									</c:when>
									<c:when	test="${auctionList.bid_state eq '낙찰' }">
										<img src="${pageContext.request.contextPath }${auctionList.image_path}/${auctionList.image1}" alt="상품 이미지">
                                          <span class="goods_front"> <i class="far fa-check-circle"></i><br> 
                                            낙찰
                                          </span>
									</c:when>
									<c:when test="${auctionList.bid_state eq '유찰' }">
										<img src="${pageContext.request.contextPath }${auctionList.image_path}/${auctionList.image1}" alt="상품 이미지">
										<span class="goods_front"> 유찰 </span>
									</c:when>
									<c:when test="${auctionList.bid_state eq '즉시구매' }">
										<img src="${pageContext.request.contextPath }${auctionList.image_path}/${auctionList.image1}" alt="상품 이미지">
                                          <span class="goods_front"> <i class="far fa-check-circle"></i><br> 
                                            즉시구매
                                          </span>
									</c:when>
								</c:choose>
				              </div>
				            </a>
				          </div>
				          <div class="col-12 col-md-9">
				            <div class="goods_info">
				              <h2 class="goods_title">${auctionList.auction_title}</h2>
				              <p class="goods_price">
                                <c:choose>
                                    <c:when test="${auctionList.bid_state eq '즉시구매' }">
						                <span class="bold">즉시구매가 : ${auctionList.bid_price}</span>원
                                    </c:when>
                                    <c:when test="${auctionList.bid_state eq '낙찰' }">
						                <span class="bold">낙찰가 : ${auctionList.bid_price}</span>원
                                    </c:when>
                                    <c:otherwise>
						                <span class="bold">입찰가 : ${auctionList.bid_price}</span>원
                                    </c:otherwise>
                                </c:choose>
				              </p>
				            </div>
				          </div>
				            <div class="col-12 col-md-auto">
				                <div class="ml-auto">
				                    <div class="goods_date">
									    <time datetime="${auctionList.bid_date}">${auctionList.bid_date}</time>
									</div>
									<div>
									    <c:if test="${auctionList.bid_state eq '낙찰' || auctionList.bid_state eq '즉시구매'}">
	                                        <c:choose>
	                                            <c:when test="${auctionList.pay_status eq null }">
                                                    <button type="button" class="btn btn-light btn-half-height" onclick="location.href='${pageContext.request.contextPath }/auctionPayForm?auction_idx=${auctionList.auction_idx}&auctionMethod=0'">결제</button>
	                                            </c:when>
	                                            <c:when test="${auctionList.pay_status eq '결제완료' && auctionList.delivery_status ne '인수'}">
	                                               <c:choose>
		                                                <c:when test="${auctionList.tracking_num ne null && auctionList.tracking_company ne null && auctionList.delivery_status ne '배송완료' }">
									                    	<button type="button" class="btn btn-light btn-half-height" onclick="trackingInfo('${auctionList.tracking_code }','${auctionList.tracking_num}')">배송조회</button>
		                                                </c:when>
		                                                <c:when test="${auctionList.delivery_status eq '배송완료' }">
									                    	<button type="button" class="btn btn-light btn-half-height" onclick="confirmAcquisition(${auctionList.auction_idx})">인수확인</button>
		                                                </c:when>
	                                               </c:choose>
	                                            </c:when>
	                                            <c:when test="${auctionList.jung_rev_idx eq null }">
							                    	<button type="button" class="btn btn-light btn-half-height" onclick="location.href='${pageContext.request.contextPath }/AucRegistReviewForm?product_idx=${auctionList.auction_idx}&mem_idx=${auctionList.mem_idx }&buyer_idx=${auctionList.buyer_idx }'">구매후기 작성</button>
	                                            </c:when>
	                                            <c:otherwise>
	                                            	<button type="button" class="btn btn-light btn-half-height" onclick="location.href='${pageContext.request.contextPath }/AucModifyReviewForm?product_idx=${auctionList.auction_idx}&mem_idx=${auctionList.mem_idx }&buyer_idx=${auctionList.buyer_idx }'">구매후기 수정</button>
	                                            </c:otherwise>
	                                        </c:choose>
									    </c:if>
				                	</div>
				                </div>
				            </div>
				        </div>
				      </div>
				    </c:forEach>
				</div>
				</div>				
				<!-- 경매낙찰내역 시작 -->
			
<!-- 커스텀 시작 -->
				<div id="secondhandLike_menu_area" class="common_menu">
					<div style="display: flex; justify-content: space-between; align-items: center;">
					    <div>
					        <p>
					            내 커스텀
					        </p>
					        <!-- 생략된 주석 -->
					    </div>
				    	<div class="">
					        <ul class="goods_cate">
					            <select class="form-custom form-select form-select-sm" aria-label=".form-select-sm example">
					              <option selected>전체</option>
					              <option value="배송중">배송중</option>
					              <option value="배송완료">배송완료</option>
					            </select>
					        </ul>
					    </div>
					</div>
					<div>
						<!--커스텀-->
					<div class="container mt-4">
					  <c:forEach items="${creamList }" var="creamList">
						<input type="hidden" name="request_idx" value="${creamList.request_idx }">
					      <div class="goods mb-4">
					        <div class="row no-gutters">
					          <div class="col-12 col-md-auto"> <!-- 이미지랑 하이퍼링크 섹션 -->
					              <div class="goods_image" style=" width: 94px; height: 94px;">
					            <a href="${pageContext.request.contextPath }/CreamDetail?cream_idx=${creamList.cream_idx}">
									<img src="${pageContext.request.contextPath }${creamList.image_path }/${creamList.image1}" alt="상품 이미지">
					            </a>
									</div>
					          </div>
					          
					          <div class="col-12 col-md-9">
					            <div class="goods_info">
					              <h2 class="goods_title">상품명 : ${creamList.cream_title}</h2>
					              <p class="goods_price">사이즈 : ${creamList.cream_size}</p>
					              <p class="goods_price">결제금액 : ${creamList.cream_price} 원</p>
					              <c:choose>
					              	<c:when test="${creamList.inbound_tracking_num eq null }">
						              <p class="goods_price">현재상태 : 입고대기중</p>
					              	</c:when>
					                <c:when test="${creamList.inbound_tracking_num ne null && creamList.inbound_delivery_status ne '배송완료'}"> <!-- 운송장 등록시 -->
					                  <p class="goods_price">현재상태 : 입고중</p>
									</c:when>
									<c:when test="${creamList.inbound_delivery_status eq '배송완료' && creamList.tracking_num eq null}">
									  <p class="goods_price">현재상태 : 상품준비중</p>
									</c:when>
									<c:when test="${creamList.tracking_num ne null && creamList.delivery_status eq '배송완료'}">
										<p class="goods_price">현재상태 : 거래완료</p>
									</c:when>
									<c:otherwise>
										<p class="goods_price">현재상태 : 배송중</p>
									</c:otherwise>
					              </c:choose>
					            </div>
					          </div>
					            <div class="col-12 col-md-auto">
					            <!-- 진짜 시연용으로 굴러가게만 해놓음 야매임 수정반드시 해야함 seller_idx부분 반드시 -->
									<c:choose>
										<c:when test="${creamList.inbound_tracking_num eq null }"> <!-- 운송장 미등록시 -->
                                            <button type="button" class="btn btn-light btn-half-height" style="width: 53px; height:30px; margin-top:40px;" onclick="window.open('${pageContext.request.contextPath }/trackingRegisterForm2?cream_idx=${creamList.cream_idx}&request_idx=${creamList.request_idx }', '구매자정보', 'width=580, height=800, left=100, top=50')">운송장 등록</button>
                                            <button type="button" class="btn btn-light btn-half-height" style="width: 53px; height:30px; margin-top:40px;" onclick="window.open('${pageContext.request.contextPath }/creamRefund?cream_idx=${creamList.cream_idx}&request_idx=${creamList.request_idx }', '구매자정보', 'width=200, height=360, left=100, top=50')">환불 요청</button>
										</c:when>
										<c:when test="${creamList.tracking_num ne null && creamList.delivery_status eq '배송중'}"> <!-- 운송장 등록시 -->
											<input type="hidden" name="t_key"  id="t_key" value="vmXicQZCzQaQetF3y0M0xg">
											<input type="hidden" name="t_code" id="t_code" value="${creamList.tracking_code }">
											<input type="hidden" name="t_invoice" id="t_invoice" value="${creamList.tracking_num }">
											<input  type="button" value="배송조회" class="btn btn-light btn-half-height tracker">
										</c:when>
										<c:when test="${creamList.delivery_status eq '배송완료' }"> 
											<button type="button" class="btn btn-light btn-half-height" onclick="window.open('${pageContext.request.contextPath }/CreRegistReviewForm?product_idx=${creamList.cream_idx}&mem_idx=1234&buyer_idx=${creamList.mem_idx }','구매후기 등록', 'width=680, height=700, left=100, top=50')">구매후기 등록</button>
										</c:when>
									</c:choose>
					       	     </div>
					      </div>
					      </div>
				        </c:forEach>
				    </div>
				    </div>
				</div>
				<!-- 커스텀 끝 -->
				
				<!-- 찜 시작 -->
				<div id="auctionLike_menu_area" class="common_menu">
					<div style="display: flex; justify-content: space-between; align-items: center;">
					    <div>
					        <p>
					            내 찜
					        </p>
					        <!-- 생략된 주석 -->
					    </div>
					    <div class="">
					        <ul class="goods_cate">
					            <select class="form-dibselect form-select-sm" aria-label=".form-select-sm example">
					              <option selected>전체</option>
					              <option value="junggo">중고상품</option>
					              <option value="action">경매상품</option>
					              <option value="cream">크림상품</option>
					            </select>
					        </ul>
					    </div>
					</div>
					<!-- 최신순 ~ 저가 -->
					<c:set var="dibListCount" value="${dibList.size()}"/> 
					<div class="container">
						<div class="row">
							<div class="col-1">
								<div>전체</div>
							</div>
							<div class="col-8">
								<div class="sc-bqjOQT kIgFPj"><b>${dibListCount }개</b></div>
							</div>
							<div class="col-auto" style="">
						      <input type="radio" class="btn-check" name="dibsCheck" id="dibsCheckLatest" autocomplete="off" checked>
						      <label class="btn btn-check-label" for="dibsCheckLatest">최신순</label>
						      
						      <input type="radio" class="btn-check" name="dibsCheck" id="dibsCheckPopular" autocomplete="off">
						      <label class="btn btn-check-label" for="dibsCheckPopular">인기순</label>
						      
						      <input type="radio" class="btn-check" name="dibsCheck" id="dibsCheckHigh" autocomplete="off">
						      <label class="btn btn-check-label" for="dibsCheckHigh">고가</label>
						      
						      <input type="radio" class="btn-check" name="dibsCheck" id="dibsCheckLow" autocomplete="off">
						      <label class="btn btn-check-label" for="dibsCheckLow">저가</label>
							</div>
						</div>
					</div>
					<!--내 찜 시작-->
					<div class="container mt-4">
					  <c:forEach items="${dibList}" var="dibList">
					    <!--경매 상품-->
					    <c:if test="${dibList.dibs_type eq '경매상품'}">
					      <div class="goods mb-4" data-dib-type="${dibList.dibs_type}" data-dib-type="경매상품">
					        <div class="row no-gutters">
					
					          <div class="col-12 col-md-auto">
						        <a href="${pageContext.request.contextPath}/AuctionDetail?auction_idx=${dibList.product_idx}">
					              <div class="goods_image" style=" width: 94px; height: 94px;">
									<c:choose>
										<c:when	test="${dibList.auc_state eq '대기' }">
											<img src="${pageContext.request.contextPath }${dibList.image_path }/${dibList.image1}" alt="상품 이미지">
											<span class="goods_front"> 경매 대기 중 </span>
										</c:when>
										<c:when	test="${dibList.auc_state eq '진행' }">
											<img src="${pageContext.request.contextPath }${dibList.image_path }/${dibList.image1}" alt="상품 이미지">
											<span class="goods_front"> 경매 진행 중 </span>
										</c:when>
										<c:when	test="${dibList.auc_state eq '낙찰' }">
											<img src="${pageContext.request.contextPath }${dibList.image_path}/${dibList.image1}" alt="상품 이미지">
											<span class="goods_front"> 경매 낙찰 중 </span>
										</c:when>
										<c:when test="${dibList.auc_state eq '마감' }">
											<img src="${pageContext.request.contextPath }${dibList.image_path}/${dibList.image1}" alt="상품 이미지">
											<span class="goods_front"> <i class="far fa-check-circle"></i><br> 
											경매 마감
											</span>
										</c:when>
									</c:choose>
					              </div>
					            </a>
					          </div>
					          <div class="col-12 col-md-9">
					            <div class="goods_info">
					              <h2 class="goods_title">${dibList.auction_title}</h2>
					              <p class="goods_price">
					                <span class="bold">최종 낙찰가 : ${dibList.auction_final_price}</span>원
					              </p>
					              <p class="goods_shop">${dibList.seller_nickname}</p>
					              <p class="goods_date">경매 시작 시간 : ${dibList.auc_regist_date}</p>
					            </div>
					          </div>
					            <div class="col-12 col-md-auto">
					                <div class="ml-auto">
					                    <div class="goods_date">
										    <time datetime="${dibList.product_date}">${dibList.auction_date}</time>
										</div>
										<div>
						                    <c:choose>
						                    	<c:when test="${principal.member.mem_idx == storeInfo.mem_idx }">
								                    <div class="profile_btn_box mt-auto">
														<button type="button" class="btn btn-light btn-half-height btn-dib-cancel" style="width: 53px; height:30px; margin-top:40px;" data-product-idx="${dibList.product_idx}" >찜취소</button>
								                    	<button type="button" class="btn btn-light btn-half-height" style="width: 53px; height:30px; margin-top:40px;" onclick="location.href='myChatting'">상세보기</button>
								                    </div>                    	
						                    	</c:when>
						                    	<c:otherwise>
						                    		<div class="profile_btn_box mt-auto">
						                    		</div> 
						                    	</c:otherwise>
						                    </c:choose>
					                	</div>
					                </div>
					            </div>
					        </div>
					      </div>
					    </c:if>
				    <!--중고 상품 찜-->
						<c:if test="${dibList.dibs_type eq '중고상품'}">
						    <div class="goods mb-4" data-dib-type="중고상품">
						        <div class="row no-gutters align-items-start">
						            <div class="col-12 col-md-auto">
					            		<a href="${pageContext.request.contextPath}/productDetail?product_idx=${dibList.product_idx}">
							                <div class="goods_image" style="width: 94px; height: 94px;">
							                    <!-- 실제 이미지 구현 부분 -->
												<c:choose>
											<c:when test="${dibList.product_sell_status eq '대기중' }">
												<img src="${pageContext.request.contextPath}${dibList.image_path }/${dibList.image1}" alt="상품 이미지">
											</c:when>
											<c:when
												test="${dibList.product_sell_status eq '예약중' }">
												<img src="${pageContext.request.contextPath }${dibList.image_path }/${dibList.image1}" alt="상품 이미지">
												<span class="goods_front"> <i class="far fa-check-circle"></i><br> 
												예약중
												</span>
											</c:when>
											<c:when
												test="${dibList.product_sell_status eq '거래대기중' }">
												<img src="${pageContext.request.contextPath }${dibList.image_path }/${dibList.image1}" alt="상품 이미지">
												<span class="goods_front"> <i class="far fa-check-circle"></i><br> 
												거래대기중
												</span>
											</c:when>
											<c:when
												test="${dibList.product_sell_status eq '거래완료' }">
												<img src="${pageContext.request.contextPath }${dibList.image_path }/${dibList.image1}" alt="상품 이미지">
												<span class="goods_front"> <i class="far fa-check-circle"></i><br> 
												거래완료
												</span>
											</c:when>
										</c:choose>
							                </div>
						                </a>
						            </div>
						            <div class="col-12 col-md-9">
										<div class="goods_info">
											<h2 class="goods_title">${dibList.product_title }</h2>
											<p class="goods_price">
												<span class="bold">${dibList.product_price }</span>원
											</p>
											<p class="goods_shop">${dibList.seller_nickname }</p>
						<%-- 					<p class="goods_date">${dibList.product_date }</p> --%>
										</div>
						            </div>
						            <div class="col-12 col-md-auto">
						                <div class="ml-auto">
						                    <div class="goods_date">
											    <time datetime="${dibList.product_date}">${dibList.product_date}</time>
											</div>
											<div>
					                    		<c:choose>
							                    	<c:when test="${principal.member.mem_idx == storeInfo.mem_idx }">
									                    <div class="profile_btn_box mt-auto">
									                    	<button type="button" class="btn btn-light btn-half-height" style="width: 53px; height:30px; margin-top:40px;" onclick="location.href=''">찜취소</button>
									                    	<button type="button" class="btn btn-light btn-half-height" style="width: 53px; height:30px; margin-top:40px;" onclick="location.href='myChatting'">상세보기</button>
									                    </div>                    	
							                    	</c:when>
							                    	<c:otherwise>
							                    		<div class="profile_btn_box mt-auto">
							                    		</div> 
							                    	</c:otherwise>
						                    	</c:choose>
						                	</div>
						                </div>
						            </div>
						        </div>
						    </div>
						</c:if>
						<c:if test="${dibList.dibs_type eq '크림상품'}">
						    <div class="goods mb-4" data-dib-type="크림상품">
						        <div class="row no-gutters align-items-start">
						            <div class="col-12 col-md-auto">
					            		<a href="${pageContext.request.contextPath}/CreamDetail?cream_idx=${dibList.product_idx}">
							                <div class="goods_image" style="width: 94px; height: 94px;">
							                    <!-- 실제 이미지 구현 부분 -->
												<img src="${pageContext.request.contextPath}${dibList.image_path }/${dibList.image1}" alt="상품 이미지">
							                </div>
						                </a>
						            </div>
						            <div class="col-12 col-md-9">
										<div class="goods_info">
											<h2 class="goods_title">${dibList.cream_title }</h2>
<!-- 											<p class="goods_price"> -->
<%-- 												<span class="bold">${dibList.product_price }</span>원 --%>
<!-- 											</p> -->
											<p class="goods_shop">커스텀 제작</p>
						<%-- 					<p class="goods_date">${dibList.product_date }</p> --%>
										</div>
						            </div>
						            <div class="col-12 col-md-auto">
						                <div class="ml-auto">
<!-- 						                    <div class="goods_date"> -->
<%-- 											    <time datetime="${dibList.product_date}">${dibList.product_date}</time> --%>
<!-- 											</div> -->
											<div>
					                    		<c:choose>
							                    	<c:when test="${principal.member.mem_idx == storeInfo.mem_idx }">
									                    <div class="profile_btn_box mt-auto">
															<button type="button" class="btn btn-light btn-half-height btn-dib-cancel2" style="width: 53px; height:30px; margin-top:40px;" data-product-idx="${dibList.product_idx}" >찜취소</button>
									                    	<button type="button" class="btn btn-light btn-half-height" style="width: 53px; height:30px; margin-top:40px;" onclick="location.href='myChatting'">상세보기</button>
									                    </div>                    	
							                    	</c:when>
							                    	<c:otherwise>
							                    		<div class="profile_btn_box mt-auto">
							                    		</div> 
							                    	</c:otherwise>
						                    	</c:choose>
						                	</div>
						                </div>
						            </div>
						        </div>
						    </div>
						</c:if>
				  </c:forEach>
				</div>
			</div>
			<!-- 내 찜 끝 -->
				
			<!-- 후기 시작 -->
			<div id="auctiongoods_menu_area" class="common_menu">
				<div style="display: flex; justify-content: space-between; align-items: center;">
				    <div>
				        <p>
				           내 후기
				        </p>
				        <!-- 생략된 주석 -->
				    </div>
				    <div class="">
				        <ul class="goods_cate">
				            <select class="form-select form-select-sm" aria-label=".form-select-sm example">
				              <option selected>전체</option>
				              <option value="중고상품">중고상품</option>
				              <option value="경매상품">경매상품</option>
				              <option value="크림상품">크림상품</option>
				            </select>
				        </ul>
				    </div>
				</div>
			    <!-- 중략 -->
			 	<c:set var="jungReivewListCount" value="${jungReivewList.size()}"/> 
			    <div class="container">
					<div class="row">
						<div class="col-1">
							<div>전체</div>
						</div>
						<div class="col-8">
							<div class="sc-bqjOQT kIgFPj"><b>${jungReivewListCount }개</b></div>
						</div>
<!-- 						<div class="col-auto" style=""> -->
<!-- 					      <input type="radio" class="btn-check" name="" id="" autocomplete="off" checked> -->
<!-- 					      <label class="btn btn-check-label" for="">최신순</label> -->
					      
<!-- 					      <input type="radio" class="btn-check" name="" id="" autocomplete="off"> -->
<!-- 					      <label class="btn btn-check-label" for="">별점순</label> -->
<!-- 						</div> -->
					</div>
				</div>
				<div class="container mt-4">
				  <c:forEach items="${jungReivewList}" var="jungReivewList">
				    <!--후기-->
				<%--     <c:if test="${dibList.dibs_type eq '경매상품'}"> --%>
				      <div class="goods mb-4">
				        <div class="row no-gutters">
				
				          <div class="col-12 col-md-auto">
				            <a href="${pageContext.request.contextPath}/social/${jungReivewList.writer_idx}">
				                <div class="goods_image " style="width: 94px; height: 94px; border-radius: 70%">
									<img src="${pageContext.request.contextPath}/resources/upload/profile/${jungReivewList.writer_profileImageUrl}" alt="상품 이미지" class ="ReviewImage" onerror="this.src='${pageContext.request.contextPath }/resources/img/member/social/memProfile.jpg'">
				                </div>
				            </a>
				          </div>
				          <div class="col-12 col-md-2">
				            <div class="goods_info">
				              <h2 class="goods_title border" style="font-size:14px;">
				              <c:if test="${jungReivewList.review_type == '중고상품'}">
				              	<a href="${pageContext.request.contextPath}/productDetail?product_idx=${jungReivewList.product_idx}">${jungReivewList.jung_title}</a>
			              	  </c:if>
				              <c:if test="${jungReivewList.review_type == '경매상품'}">
				              	<a href="${pageContext.request.contextPath}/AuctionDetail?auction_idx=${jungReivewList.product_idx}">${jungReivewList.auction_title}</a>
			              	  </c:if>
				              <c:if test="${jungReivewList.review_type == '크림상품'}">
				              	<a href="${pageContext.request.contextPath}/productDetail?product_idx=${jungReivewList.product_idx}">${jungReivewList.cream_title}</a>
			              	  </c:if>
			              	  </h2>
				              <p class="goods_price">
            						<span class="reviewStar">
										<span>
											<!-- 별점 구현 초보, 새로운 거 알면 바꾸기-->
											<c:choose>
	   											<c:when test="${jungReivewList.review_star eq 0 }">
	 												<span>★</span>
													<span>★</span>
													<span>★</span>
													<span>★</span>
													<span>★</span>
	   											</c:when>
	   											<c:when test="${jungReivewList.review_star eq 1 }">
	 												<span class="fill">★</span>
													<span>★</span>
													<span>★</span>
													<span>★</span>
													<span>★</span>
	   											</c:when>
	   											<c:when test="${jungReivewList.review_star eq 2 }">
	 												<span class="fill">★</span>
													<span class="fill">★</span>
													<span>★</span>
													<span>★</span>
													<span>★</span>
	   											</c:when>
	   											<c:when test="${jungReivewList.review_star eq 3 }">
	 												<span class="fill">★</span>
													<span class="fill">★</span>
													<span class="fill">★</span>
													<span>★</span>
													<span>★</span>
	   											</c:when>
	   											<c:when test="${jungReivewList.review_star eq 4 }">
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
				              </p>
				              <p class="goods_shop">${jungReivewList.writer_mem_id}</p>
				            </div>
				          </div>
				            <div class="col-12 col-md-7">
				              <p class="goods_date" style=" width: 400px;" >${jungReivewList.review_content}</p>
				          	</div>
				            <div class="col-12 col-md-auto">
				                <div class="ml-auto">
				                    <div class="goods_date">
									    <time datetime="${jungReivewList.product_date}">${jungReivewList.review_date}</time>
									</div>
									<div>
<!-- 				                    	<button type="button" class="btn btn-light btn-half-height" style="width: 53px; height:30px; margin-top:40px;" onclick="location.href='myChatting'">수정</button> -->
<!-- 				                    	<button type="button" class="btn btn-light btn-half-height" style="width: 53px; height:30px; margin-top:40px;" onclick="location.href='myChatting'">삭제</button> -->
				                	</div>
				                </div>
				            </div>
				        </div>
				      </div>
				<%--     </c:if> --%> 
				  </c:forEach>
				</div>
			</div>
				<!-- 후기 끝 -->
		</div>
	</div>
		<!-- 하단 내역 부분 끝 -->
</div>
	<!-- main_content 영역 끝 -->
<script>
$(document).ready(function () {
    // 셀렉트 박스의 값을 변경할 때마다 실행되는 함수
    $('.form-dibselect').on('change', function () {
      const selectedValue = $(this).val();

      // 전체를 선택했을 경우 모든 찜 상품을 보여주고, 그렇지 않은 경우 필터링
      if (selectedValue === '전체') {
        $('.goods').show();
      } else {
        const dibTypeValue = selectedValue === 'junggo'
          ? '중고상품'
          : selectedValue === 'action'
          ? '경매상품'
          : '크림상품';

        $('.goods').each(function () {
          const dibType = $(this).data('dib-type');
          if (dibType === dibTypeValue) {
            $(this).show();
          } else {
            $(this).hide();
          }
        });
      }
    });
  });
  
//   시간
  function formatTimeAgo(date) {
      const now = new Date();
      const diffSeconds = Math.floor((now - date) / 1000);
      const diffMinutes = Math.floor(diffSeconds / 60);
      const diffHours = Math.floor(diffMinutes / 60);
      const diffDays = Math.floor(diffHours / 24);
      const diffMonths = Math.floor(diffDays / 30);
      const diffYears = Math.floor(diffDays / 365);

      if (diffYears > 0) return diffYears + '년 전';
      if (diffMonths > 0) return diffMonths + '달 전';
      if (diffDays > 0) return diffDays + '일 전';
      if (diffHours > 0) return diffHours + '시간 전';
      if (diffMinutes > 0) return diffMinutes + '분 전';
      return '방금 전';
  }

  const timeElements = document.querySelectorAll('.goods_date time');
  timeElements.forEach((timeElement) => {
      const originalDate = new Date(timeElement.getAttribute('datetime'));
      const formattedTime = formatTimeAgo(originalDate);
      timeElement.textContent = formattedTime;
  });

const aucDeleteConfirm = idx => {
	if(confirm("상품을 삭제하시겠습니까?")) {
		location.href='${pageContext.request.contextPath }/AuctionDelete?auction_idx='+idx;
	} else {
		return false;
	}
;}

const trackingInfo = (code,number) => {
	const apiKey = 'uIHsZSYtgUJ8qn8YkWBIkw';
	window.open('http://info.sweettracker.co.kr/tracking/4?t_key='+apiKey+'&t_code='+code+'&t_invoice='+number ,'trackingInfo', 'toolbar=no, width=540, height=800 left=700 top=100, directories=no, status=no, resizable=no');
};
  
const confirmAcquisition = idx => {
    if(confirm("택배 상품 확인이 완료되었다면, 확인을 눌러주세요.")) {
    	location.href='${pageContext.request.contextPath }/acquisitionComplete?auction_idx='+idx;
    } else {
    	return false;
    }
};
  
</script>

<script>
 	$('.tracker').click(function() {
		let apikey = "vmXicQZCzQaQetF3y0M0xg";
		
		$.ajax({
			type:"GET",
			url: "http://info.sweettracker.co.kr/api/v1/companylist?t_key=" + apikey,
			dataType: "JSON",
			success: function(data) {
				let t_key = $("#t_key").val();
				let t_code = $("#t_code").val();
				let t_invoice = $("#t_invoice").val();
				window.open("http://info.sweettracker.co.kr/tracking/4?t_key="+t_key+"&t_code="+t_code+"&t_invoice="+t_invoice ,"popForm", "toolbar=no, width=540, height=800 left=700 top=100, directories=no, status=no, resizable=no");
			}, error: function() {
				
			}
		});
	})
</script>

<script>
  document.querySelector('.form-auction').addEventListener('change', function() {
    var selectedValue = this.value;
    var auctionItems = document.querySelectorAll('.goods');

    auctionItems.forEach(function(item) {
      var aucState = item
                       .querySelector('.goods_image .goods_front')
                       .innerText
                       .trim();

      if ((selectedValue === '전체') ||
          (selectedValue === '대기' && aucState === '경매 대기 중') ||
          (selectedValue === '진행' && aucState === '경매 진행 중') ||
          (selectedValue === '마감' && aucState.includes('경매 마감'))) {
        item.style.display = '';
      } else {
        item.style.display = 'none';
      }
    });
  });
</script>

<script>
  document.querySelector('.form-selljunggo').addEventListener('change', function() {
    var selectedValue = this.value;
    var productItems = document.querySelectorAll('.goods');

    productItems.forEach(function(item) {
      var productStatus = item
                          .querySelector('.goods_image .goods_front')
                          .innerText
                          .trim();

      if ((selectedValue === '전체') ||
          (selectedValue === '대기중' && productStatus === '대기중') ||
          (selectedValue === '예약중' && productStatus === '예약중') ||
          (selectedValue === '거래대기중' && productStatus === '거래대기중') ||
          (selectedValue === '거래완료' && productStatus === '거래완료')) {
        item.style.display = '';
      } else {
        item.style.display = 'none';
      }
    });
  });
</script>

<script>
  document.querySelector('.form-buyjunggo.form-select-sm').addEventListener('change', function() {
    var selectedValue = this.value;
    var goodsItems = document.querySelectorAll('.goods');

    goodsItems.forEach(function(item) {
      var goodsState = item
                       .querySelector('.goods_image .goods_front')
                       .innerText
                       .trim();

      if ((selectedValue === '전체') ||
          (selectedValue === '결제완료' && goodsState === '결제완료') ||
          (selectedValue === '거래완료' && goodsState === '거래완료') ||
          (selectedValue === '결제취소' && goodsState === '결제취소') ||
          (selectedValue === '거래취소' && goodsState === '거래취소')) {
        item.style.display = '';
      } else {
        item.style.display = 'none';
      }
    });
  });
</script>

<script>
  document.querySelector('.form.buyAuction').addEventListener('change', function() {
    var selectedValue = this.value;
    var auctionItems = document.querySelectorAll('.goods');

    auctionItems.forEach(function(item) {
      var aucState = item
                       .querySelector('.goods_image .goods_front')
                       .innerText
					   .replace(/\n/g, '')
                       .trim();

      if ((selectedValue === '전체') ||
          (selectedValue === '입찰' && aucState === '입찰') ||
          (selectedValue === '낙찰' && aucState.includes('낙찰')) ||
          (selectedValue === '유찰' && aucState === '유찰') ||
          (selectedValue === '즉시구매' && aucState.includes('즉시구매'))) {
        item.style.display = '';
      } else {
        item.style.display = 'none';
      }
    });
  });
</script>

<script>
  document.querySelector('.form-custom.form-select.form-select-sm').addEventListener('change', function() {
    var selectedValue = this.value;
    var goodsItems = document.querySelectorAll('.goods');

    goodsItems.forEach(function(item) {
      var goodsState = item.querySelector('.goods_info .goods_price:last-child').innerText.trim();

      if ((selectedValue === '전체') ||
          (selectedValue === '배송중' && goodsState === '현재상태 : 배송중') ||
          (selectedValue === '배송완료' && goodsState === '현재상태 : 거래완료')) {
        item.style.display = '';
      } else {
        item.style.display = 'none';
      }
    });
  });
  
  // 경매 찜 취소
  $('.btn-dib-cancel').click(function () {
	  // 찜 취소 버튼의 data-product-idx 속성 값을 사용하여 product_idx 인자를 전달
	  let product_idx = $(this).data('product-idx');
	  dibsCheck(product_idx);
	});
  // 커스텀 찜 취소
  $('.btn-dib-cancel2').click(function () {
	  // 찜 취소 버튼의 data-product-idx 속성 값을 사용하여 product_idx 인자를 전달
	  let product_idx = $(this).data('product-idx');
	  dibsCheck2(product_idx);
	});
  
  
// 경매 찜 취소
const dibsCheck = (product_idx) => {
	let context = "${pageContext.request.contextPath}";
    $.ajax({
        type: "post"
        , url: context + "/dibsEvent"
        , data: {
            auction_idx: product_idx
        }
        , dataType: "json"
        , success: function(data) {
            location.reload(true);
        }
        ,error: function() {
            console.log("error");
        }
    })
}

// 커스텀 찜 취소
const dibsCheck2 = (product_idx) => {
	let context = "${pageContext.request.contextPath}";
    $.ajax({
        type: "post"
        , url: context + "/dibsEvent2"
        , data: {
        	cream_idx: product_idx
        }
        , dataType: "json"
        , success: function(data) {
            location.reload(true);
        }
        ,error: function() {
            console.log("error");
        }
    })
}
</script>

	<!-- 푸터 시작 -->
	<jsp:include page="../../inc_ex/footer.jsp" />
</body>
</html>