<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ include file="../layout/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>클레버 - 마이페이지</title>
<link rel="shortcut icon"href="${pageContext.request.contextPath }/resources/img/member/mem_mypage/shoecream-logo.png">

<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/main_ex/market/common.css">


<link href="${pageContext.request.contextPath }/resources/css/member/common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/resources/css/member/mem_page/mem_info_update.css" rel="stylesheet">
<!--아이콘-->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />

<!-- 부트스트랩 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css"
rel="stylesheet" integrity="sha384-gH2yIJqKdNHPEq0n4Mqa/HGKIhSkIHeL5AyhkYV8i59U5AR6csBvApHHNl/vI1Bx" crossorigin="anonymous">

<!-- 부트스트랩 icon -->
<link rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">

<!--css-->
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/member/market/common.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/member/market/index.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/member/goods/goods_comon.css">

<!-- 내 상점 페이지 CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/member/market/market_my_store.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/member/goods/goods_history.css">

<!-- js -->
<script	src="${pageContext.request.contextPath }/resources/js/market/jquery-3.6.0.min.js"></script>
<script	src="${pageContext.request.contextPath }/resources/js/market/menu_hover.js"></script>
<script	src="${pageContext.request.contextPath }/resources/js/market/market_intro_modify.js"></script>
<script	src="${pageContext.request.contextPath }/resources/js/goods/goods_history_common.js"></script>
<script	src="${pageContext.request.contextPath }/resources/js/goods/goods_buy_history.js"></script>

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
	<jsp:include page="../../inc_ex/header_social.jsp" />
	<!-- main_content 영역 -->
	<div id="main_content">
		<!-- 프로필 영역 -->
		<section class="profile">
		
		<div id="my_store_area">
			<div class="my_store_left">
				<div class="profile-left">
					<div class="profile-img-wrap story-border"
						onclick="popup('.modal-image')">
						<form id="userProfileImageForm">
							<input type="file" name="profileImageFile" style="display: none;"
								id="userProfileImageInput" />
						</form>
		
						<img class="profile-image" src="#"
							onerror="this.src='${pageContext.request.contextPath }/resources/img/member/social/person3.jpg'" id="userProfileImage"  
							style=" width: 130px; height: 130px;"/>
					</div>
				</div>
			</div>

			<div class="my_store_right">
				<div id="my_store_right_top">
					<div>
						<h2>${principal.member.mem_nickname}님</h2>
						<button onclick="location.href='${pageContext.request.contextPath }/mypage/update'">내 정보 수정</button>
						<button onclick="location.href='${pageContext.request.contextPath }/social/1'">소셜</button>
						<button onclick="location.href='${pageContext.request.contextPath }/mypage/account'">계좌관리</button>
					</div>
					<div>
						<c:choose>
							<c:when test="${principal.member.mem_account_auth eq 'Y' }">
								<p>
									<span>OK</span> 계좌 인증 완료
								</p>
							</c:when>
							<c:otherwise>
								<p>
									<span>NO</span> 계좌 미인증
								</p>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				<div id="my_store_right_mid">
				<div class='left-box'>
				
				
				</div>
				<div class='right-box'>
				
				
				</div>
				</div>
			</div>
		</div>
		</section>
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
					<div class="col my_store_menus secondhandLike_menu">
						중고거래 찜 
					</div>
					<div class="col my_store_menus auction_menu">
						내 경매 
					</div>
					<div class="col my_store_menus auctionbid_menu">
						경매 낙찰/즉시구매 내역  
					</div>
					<div class="col my_store_menus auctionLike_menu">
						경매 찜 
					</div>
					<div class="col my_store_menus auctiongoods_menu">
						크림 구매내역 
					</div>
				</div>
			</div>

			<div id="my_store_menu_content">
				<div id="sales_menu_area" class="common_menu">
					<div>
						<p>
							판매내역 
						</p>
						<ul class="goods_cate">
							<li>전체</li>
							<li class="hidden_menu">전체</li>
							<li class="hidden_menu">거래중</li>
							<li class="hidden_menu">거래완료</li>
							<li class="hidden_menu">숨김내역</li>
						</ul>
						<i class="bi bi-chevron-down under_direction under"></i>
					</div>
					<div>
						<!-- 판매 내역 시작 -->
						<div id="main_content">
							<nav class="filter_nav">
								<div class="status_filter">
									<button type="button" class="all_buy_status active">전체	상태</button>
<!-- 									<button type="button" class="buying_status">진행중</button> -->
<!-- 									<button type="button" class="bought_status">거래완료</button> -->
								</div>
								<div class="pay_filter">
									<button type="button" class="pay_filter">
										<svg width="20" height="20" fill="#000" viewBox="0 0 20 20">
					                     <path d="M0 3a1 1 0 011-1h3.185A2.995 2.995 0 017 0a2.995 2.995 0 012.815 2H19a1 1 0 010 2H9.815A2.995 2.995 0 017 6a2.995 2.995 0 01-2.815-2H1a1 1 0 01-1-1zm20 14a1 1 0 01-1 1H9.815A2.995 2.995 0 017 20a2.995 2.995 0 01-2.815-2H1a1 1 0 010-2h3.185A2.995 2.995 0 017 14a2.995 2.995 0 012.815 2H19a1 1 0 011 1zm0-7a1 1 0 01-1 1h-3.185A2.995 2.995 0 0113 13a2.995 2.995 0 01-2.815-2H1a1 1 0 010-2h9.185A2.995 2.995 0 0113 7a2.995 2.995 0 012.815 2H19a1 1 0 011 1zM6 3a1 1 0 102 0 1 1 0 00-2 0zm2 14a1 1 0 10-2 0 1 1 0 002 0zm6-7a1 1 0 10-2 0 1 1 0 002 0z"
											fill-rule="evenodd" fill="#000">
					                     </path>
	                 					</svg>
									</button>
								</div>
							</nav>
							<!--상품 내용-->
							<c:forEach items="${productSellList }" var="productSellList">
								<div class="goods">
									<div class="goods_one">
										<a href="product_detail?product_idx=${productSellList.product_idx }">
											<div class="goods_image">
												<c:forEach items="${fileList }" var="fileList">
													<c:set var="length" value="${fn:length(fileList.file_name) }" />
													<c:set var="index" value="${fn:indexOf(fileList.file_name, '_') }" />
													<c:set var="file_name" value="${fn:substring(fileList.file_name, index + 1, length) }" />
													<c:choose>
														<c:when test="${fileList.file_num eq productSellList.product_idx && productSellList.sale_status eq '판매중' }">
															<img src="${pageContext.request.contextPath }/resources/fileUpload/${file_name}" alt="상품 이미지">
														</c:when>
														<c:when
															test="${fileList.file_num eq productSellList.product_idx && productSellList.sale_status eq '판매완료' }">
															<img src="${pageContext.request.contextPath }/resources/fileUpload/${file_name}" alt="상품 이미지">
															<span class="goods_front"> <i class="far fa-check-circle"></i><br> 
															거래완료
															</span>
														</c:when>
													</c:choose>
												</c:forEach>
											</div>
											<div class="goods_info">
												<h2 class="goods_title">${productSellList.product_subject }</h2>
												<p class="goods_price">
													<span class="bold">${productSellList.product_price }</span>원
												</p>
												<p class="goods_shop">${productSellList.member_id }</p>
												<c:choose>
													<c:when test="${productSellList.sale_status eq '판매중'}">
														<p class="goods_date">${productSellList.product_date }</p>
													</c:when>
													<c:when test="${productSellList.sale_status eq '판매완료'}">
														<c:forEach items="${productSellDate }" var="productSellDate">
															<p class="goods_date">${productSellDate.sell_date }</p>
														</c:forEach>
													</c:when>
												</c:choose>
											</div>
										</a>
										<div class="btn_area">
											<button type="button" class="" onclick="location.href='myChatting'">채팅</button>
										</div>
									</div>
								</div>
							</c:forEach>
						</div>
					</div>
				</div>
				<!-- 판매 내역 끝 -->
				
				<!-- 구매 내역 시작  -->
				<div id="purchases_menu_area" class="common_menu">
					<div>
						<p>
							구매내역 
						</p>
						<ul class="goods_cate">
							<li>전체</li>
							<li class="hidden_menu">전체</li>
<!-- 							<li class="hidden_menu">거래중</li> -->
<!-- 							<li class="hidden_menu">거래완료</li> -->
<!-- 							<li class="hidden_menu">숨김내역</li> -->
						</ul>
						<i class="bi bi-chevron-down under_direction under"></i>
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
						<div id="main_content">
							<!--필터-->
							<nav class="filter_nav">
								<div class="status_filter">
									<button type="button" class="all_buy_status active">전체상태</button>
<!-- 									<button type="button" class="buying_status">진행중</button> -->
<!-- 									<button type="button" class="bought_status">완료</button> -->
<!-- 									<button type="button" class="cancle_status">취소/환불</button> -->
								</div>
								<div class="pay_filter">
									<button type="button" class="pay_filter">
										<svg width="20" height="20" fill="#000" viewBox="0 0 20 20">
				                           <path d="M0 3a1 1 0 011-1h3.185A2.995 2.995 0 017 0a2.995 2.995 0 012.815 2H19a1 1 0 010 2H9.815A2.995 2.995 0 017 6a2.995 2.995 0 01-2.815-2H1a1 1 0 01-1-1zm20 14a1 1 0 01-1 1H9.815A2.995 2.995 0 017 20a2.995 2.995 0 01-2.815-2H1a1 1 0 010-2h3.185A2.995 2.995 0 017 14a2.995 2.995 0 012.815 2H19a1 1 0 011 1zm0-7a1 1 0 01-1 1h-3.185A2.995 2.995 0 0113 13a2.995 2.995 0 01-2.815-2H1a1 1 0 010-2h9.185A2.995 2.995 0 0113 7a2.995 2.995 0 012.815 2H19a1 1 0 011 1zM6 3a1 1 0 102 0 1 1 0 00-2 0zm2 14a1 1 0 10-2 0 1 1 0 002 0zm6-7a1 1 0 10-2 0 1 1 0 002 0z"
											fill-rule="evenodd" fill="#000">
				                           </path>
				                       </svg>
									</button>
								</div>
							</nav>
							<!--상품 내용-->
							<c:forEach items="${productBuyList }" var="productBuyList">
								<div class="goods">
									<div class="goods_one">
										<a href="product_detail?product_idx=${productBuyList.product_idx }">
											<div class="goods_image">
												<c:forEach items="${fileList }" var="fileList">
													<c:set var="length" value="${fn:length(fileList.file_name) }" />
													<c:set var="index" value="${fn:indexOf(fileList.file_name, '_') }" />
													<c:set var="file_name" value="${fn:substring(fileList.file_name, index + 1, length) }" />
													<c:choose>
														<c:when test="${fileList.file_num eq productBuyList.product_idx && productBuyList.buy_status eq '결제완료' }">
															<img src="${pageContext.request.contextPath }/resources/fileUpload/${file_name}" alt="상품 이미지">
														</c:when>
														<c:when test="${fileList.file_num eq productBuyList.product_idx && productBuyList.buy_status eq '구매확정' }">
															<img src="${pageContext.request.contextPath }/resources/fileUpload/${file_name}" alt="상품 이미지">
															<span class="goods_front"> <i class="far fa-check-circle"></i><br> 
															거래완료
															</span>
														</c:when>
													</c:choose>
												</c:forEach>
											</div>
											<div class="goods_info">
												<h2 class="goods_title">${productBuyList.buy_title }</h2>
												<p class="goods_price">
													<span class="bold">${productBuyList.buy_price }</span>원
												</p>
												<p class="goods_shop">${productBuyList.buy_sellr }</p>
												<p class="goods_date">${productBuyList.buy_date }</p>
											</div>
										</a>
										<c:choose>
											<c:when test="${productBuyList.buy_status eq '결제완료' }">
												<div class="btn_area">
<%-- 													<button type="button" class="btn_buy_decide" value="${param.buy_price }">구매확정</button> <!-- 0613배하나 --> --%>
<%-- 													<button type="button" value="${productBuyList.buy_price }" id="buyConfirm" >구매확정</button> <!-- 0613배하나 --> --%>
<%-- 													<a href="buyConfirm?buy_price=${productBuyList.buy_price }&buy_seller=${productBuyList.buy_seller}&product_idx=${productBuyList.product_idx}">구매확정</a> --%>
<%-- 													<input type="button" class="btn_confirm" value="구매확정" onclick="location.href='buyConfirm?buy_price=${productBuyList.buy_price }&buy_seller=${productBuyList.buy_seller}&product_idx=${productBuyList.product_idx}'"> --%>
													<button type="button" onclick="location.href='buyConfirm?buy_price=${productBuyList.buy_price }&buy_seller=${productBuyList.buy_seller}&product_idx=${productBuyList.product_idx}'">구매확정</button>
												</div>
											</c:when>
											<c:when test="${productBuyList.buy_status eq '구매확정' }">
												<button type="button" onclick="location.href='review.me?review_seller=${productBuyList.buy_seller}'">후기작성</button>
											</c:when>
										</c:choose>
									</div>
								</div>
							</c:forEach>
						</div>
					</div>
				</div>
				<!-- 구매 내역 끝 -->

				<!-- 찜 내역 시작 -->
				<div id="secondhandLike_menu_area" class="common_menu">
					<div>
						<p>
							중고거래 찜 
						</p>
					</div>
					<div>
						<!--찜 상풍-->
						<c:forEach items="${productdibsList }" var="productdibsList">
							<div class="goods">
								<div class="goods_one">
									<a href="product_detail?product_idx=${productdibsList.product_idx }">
										<div class="goods_image">
											<c:forEach items="${fileList }" var="fileList">
												<c:set var="length" value="${fn:length(fileList.file_name) }" />
												<c:set var="index" value="${fn:indexOf(fileList.file_name, '_') }" />
												<c:set var="file_name" value="${fn:substring(fileList.file_name, index + 1, length) }" />
												<c:choose>
													<c:when	test="${fileList.file_num eq productdibsList.product_idx }">
														<img src="${pageContext.request.contextPath }/resources/fileUpload/${file_name}" alt="상품 이미지">
													</c:when>
													<c:when	test="${fileList.file_num eq productdibsList.product_idx }">
														<img src="${pageContext.request.contextPath }/resources/fileUpload/${file_name}" alt="상품 이미지">
														<span class="goods_front"> <i class="far fa-check-circle"></i><br> 
														거래완료
														</span>
													</c:when>
												</c:choose>
											</c:forEach>
										</div>
										<div class="goods_info">
											<h2 class="goods_title">${productdibsList.product_subject }</h2>
											<p class="goods_price">
												<span class="bold">${productdibsList.product_price }</span>원
											</p>
											<p class="goods_shop">${productdibsList.member_id }</p>
											<p class="goods_date">${productdibsList.product_date }</p>
										</div>
									</a>
									<button type="button" name="product" onclick="location.href='P_DibsCancel?type_num=${productdibsList.product_idx}'">찜 취소</button>
								</div>
							</div>
						</c:forEach>
					</div>
				</div>
				<!-- 찜 내역 끝 -->
				
				<!-- 내 경매 시작 -->
				<div id="auction_menu_area" class="common_menu">
					<div>
						<p>
							내가 올린 경매 목록 
						</p>
						<ul class="goods_cate">
							<li>전체</li>
							<li class="hidden_menu">전체</li>
<!-- 							<li class="hidden_menu">참여중</li> -->
<!-- 							<li class="hidden_menu">경매완료</li> -->
<!-- 							<li class="hidden_menu">숨김내역</li> -->
						</ul>
						<i class="bi bi-chevron-down under_direction under"></i>
					</div>
					<div>
						<div id="main_content">
							<!--필터-->
							<nav class="filter_nav">
								<div class="status_filter">
									<button type="button" class="all_buy_status active">전체 상태</button>
<!-- 									<button type="button" class="buying_status">진행중</button> -->
<!-- 									<button type="button" class="bought_status">완료</button> -->
<!-- 									<button type="button" class="cancle_status">취소/환불</button> -->
								</div>
								<div class="pay_filter">
									<button type="button" class="pay_filter">
										<svg width="20" height="20" fill="#000" viewBox="0 0 20 20">
				                           <path d="M0 3a1 1 0 011-1h3.185A2.995 2.995 0 017 0a2.995 2.995 0 012.815 2H19a1 1 0 010 2H9.815A2.995 2.995 0 017 6a2.995 2.995 0 01-2.815-2H1a1 1 0 01-1-1zm20 14a1 1 0 01-1 1H9.815A2.995 2.995 0 017 20a2.995 2.995 0 01-2.815-2H1a1 1 0 010-2h3.185A2.995 2.995 0 017 14a2.995 2.995 0 012.815 2H19a1 1 0 011 1zm0-7a1 1 0 01-1 1h-3.185A2.995 2.995 0 0113 13a2.995 2.995 0 01-2.815-2H1a1 1 0 010-2h9.185A2.995 2.995 0 0113 7a2.995 2.995 0 012.815 2H19a1 1 0 011 1zM6 3a1 1 0 102 0 1 1 0 00-2 0zm2 14a1 1 0 10-2 0 1 1 0 002 0zm6-7a1 1 0 10-2 0 1 1 0 002 0z"
											fill-rule="evenodd" fill="#000">
				                           </path>
				                       </svg>
									</button>
								</div>
							</nav>
							<!--상품 내용-->
							<c:forEach items="${auctionList }" var="auctionList">
								<div class="goods">
									<div class="goods_one">
										<a href="auction_detail?auction_idx=${auctionList.auction_idx }&param=${auctionList.auction_Scategory }">
											<div class="goods_image">
												<c:forEach items="${auctionfileList }" var="file">
													<c:choose>
														<c:when	test="${file.file_num eq auctionList.auction_idx && auctionList.auction_status eq '경매중' }">
															<img src="${pageContext.request.contextPath }/resources/fileUpload${file.file_path}/${file.file_name}" alt="상품 이미지">
															<span class="goods_front"> 경매 진행 중 </span>
														</c:when>
														<c:when test="${file.file_num eq auctionList.auction_idx && auctionList.auction_status eq '경매마감' }">
															<img src="${pageContext.request.contextPath }/resources/fileUpload${file.file_path}/${file.file_name}" alt="상품 이미지">
															<span class="goods_front"> <i class="far fa-check-circle"></i><br> 
															경매 마감
															</span>
														</c:when>
													</c:choose>
												</c:forEach>
											</div>
											<div class="goods_info">
												<h2 class="goods_title">${auctionList.auction_title }</h2>
												<p class="goods_price">
													<span class="bold">최종 낙찰가 : ${auctionList.auction_final_price }</span>원
												</p>
												<p class="goods_shop">${auctionList.member_id }</p>
												<p class="goods_date">경매 시작 시간 : ${auctionList.auction_date }</p>
											</div>
										</a>
											<div class="btn_area">
												<button type="button" class="" onclick="location.href='myChatting'">채팅</button>
											</div>
									</div>
								</div>
							</c:forEach>
						</div>
					</div>
				</div>
				<!-- 내 경매 끝 -->

				<!-- 경매낙찰내역 시작 -->
					<div id="auctionbid_menu_area" class="common_menu">
					<div>
						<p>
							경매 낙찰 내역 
						</p>
					</div>
					<div>
						<c:forEach items="${auctionBidList }" var="auctionBidList">
							<div class="goods">
								<div class="goods_one">
									<a href="auction_detail?auction_idx=${auctionBidList.auction_idx }&param=${auctionBidList.auction_Scategory }">
										<div class="goods_image">
											<c:forEach items="${auctionfileList }" var="file">
												<c:choose>
													<c:when test="${file.file_num eq auctionBidList.auction_idx }">
														<img src="${pageContext.request.contextPath }/resources/fileUpload${file.file_path}/${file.file_name}" alt="상품 이미지">
													</c:when>
													<c:when	test="${file.file_num eq auctionBidList.auction_idx }">
														<img src="${pageContext.request.contextPath }/resources/fileUpload${file.file_path}/${file.file_name}" alt="상품 이미지">
														<span class="goods_front"> <i class="far fa-check-circle"></i><br> 
														경매 낙찰
														</span>
													</c:when>
												</c:choose>
											</c:forEach>
										</div>
										<div class="goods_info">
											<h2 class="goods_title">${auctionBidList.auction_title }</h2>
											<p class="goods_price">
												<span class="bold">낙찰가 : ${auctionBidList.auction_final_price }</span>원
											</p>
											<p class="goods_shop">${auctionBidList.member_id }</p>
											<p class="goods_date">${auctionBidList.auction_date }</p>
										</div>
									</a>
									
									<c:choose>
											<c:when test="${auctionBidList.auction_status eq '경매마감' }">
												<div class="btn_area">
<%-- 													<button type="button" class="payAuction" value="${auctionBidList.auction_final_price }" title="${auctionBidList.auction_idx }">결제하기</button> --%>
													<button type="button" onclick="payAuction('${auctionBidList.auction_idx}','${auctionBidList.auction_final_price}','${auctionBidList.member_id}','${auctionBidList.auction_title}')">결제하기</button>
													<button type="button" class="" onclick="location.href='myChatting'">채팅</button>
												</div>
											</c:when>
											<c:when test="${auctionBidList.auction_status eq '판매완료' }">
												<div class="btn_area">
<%-- 												<a href="product_bank_userInfo?auction_final_price=${auctionBidList.auction_final_price }&member_id=${auctionBidList.member_id }&auction_idx=${auctionBidList.auction_idx}">구매확정</a> --%>
												<button type="button" onclick="location.href='auctionBuyConfirm?buy_price=${auctionBidList.auction_final_price }&buy_seller=${auctionBidList.member_id}&auction_idx=${auctionBidList.auction_idx}'">구매확정</button>
												<button type="button" onclick="location.href='myChatting'">채팅</button>
												</div>
											</c:when>
											<c:when test="${auctionBidList.auction_status eq '구매확정' }">
												<div class="btn_area">
												<button type="button" onclick="location.href='review.me?review_seller=${auctionBidList.member_id}'">후기작성</button>
												<button type="button" class="" onclick="location.href='myChatting'">채팅</button>
												</div>
											</c:when>
										</c:choose>
								</div>
							</div>
						</c:forEach>
					</div>
				</div>				
				<!-- 경매낙찰내역 시작 -->
			
				
				<!-- 경매 찜 시작 -->
				<div id="auctionLike_menu_area" class="common_menu">
					<div>
						<p>
							경매 찜 
						</p>
					</div>
					<div>
						<c:forEach items="${auctionDibsList }" var="auctionDibsList">
							<div class="goods">
								<div class="goods_one">
									<a href="product_detail?product_idx=${auctionDibsList.auction_idx }">
										<div class="goods_image">
											<c:forEach items="${auctionfileList }" var="file">
												<c:choose>
													<c:when test="${file.file_num eq auctionDibsList.auction_idx }">
														<img src="${pageContext.request.contextPath }/resources/fileUpload${file.file_path}/${file.file_name}" alt="상품 이미지">
													</c:when>
													<c:when	test="${file.file_num eq auctionDibsList.auction_idx }">
														<img src="${pageContext.request.contextPath }/resources/fileUpload${file.file_path}/${file.file_name}" alt="상품 이미지">
														<span class="goods_front"> <i class="far fa-check-circle"></i><br> 
														거래완료
														</span>
													</c:when>
												</c:choose>
											</c:forEach>
										</div>
										<div class="goods_info">
											<h2 class="goods_title">${auctionDibsList.auction_title }</h2>
											<p class="goods_price">
												<span class="bold">${auctionDibsList.auction_final_price }</span>원
											</p>
											<p class="goods_shop">${auctionDibsList.member_id }</p>
											<p class="goods_date">${auctionDibsList.auction_date }</p>
										</div>
									</a>
									<button type="button" name="auction" onclick="location.href='A_DibsCancel?type_num=${auctionDibsList.auction_idx}'">찜 취소</button>
								</div>
							</div>
						</c:forEach>
					</div>
				</div>
				<!-- 경매 찜 끝 -->
				
				<!-- 굿즈 구매 내역 시작 -->
				<div id="auctiongoods_menu_area" class="common_menu">
					<div>
						<p>
							크림 구매내역 
						</p>
					</div>
					<div>
						<!--찜 상풍-->
						<c:forEach items="${goodsList }" var="goodsList">
							<div class="goods">
								<div class="goods_one">
									<a href="goodsDetail.ad?goods_idx=${goodsList.goods_idx }">
										<div class="goods_image">
											<c:forEach items="${goodsFile }" var="file">
												<c:choose>
													<c:when	test="${file.file_num eq goodsList.goods_idx }">
														<img src="${pageContext.request.contextPath }/resources/fileUpload${file.file_path}/${file.file_name}" alt="상품 이미지">
													</c:when>
												</c:choose>
											</c:forEach>
										</div>
										<div class="goods_info">
											<h2 class="goods_title">${goodsList.buy_title }</h2>
											<p class="goods_price">
												<span class="bold">${goodsList.buy_price }</span>원
											</p>
											<p class="goods_shop"></p>
											<p class="goods_date">${goodsList.buy_date }</p>
										</div>
									</a>
									<button type="button" name="goods" onclick="location.href='DeleteGoods?buy_idx=${goodsList.buy_idx}'">굿즈 삭제</button>
								</div>
							</div>
						</c:forEach>
					</div>
				</div>
				<!-- 굿즈 구매 내역 끝 -->
				
			</div>
		</div>
		<!-- 하단 내역 부분 끝 -->
	</div>
	<!-- main_content 영역 끝 -->

	<!-- 푸터 시작 -->
	<jsp:include page="../../inc_ex/footer.jsp" />
</body>
</html>