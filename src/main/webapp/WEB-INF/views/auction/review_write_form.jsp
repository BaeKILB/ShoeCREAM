<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>  
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<link href="${pageContext.request.contextPath}/resources/css/common.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/resources/css/junggo/review_write_form.css" rel="stylesheet">
<%-- 	<link href="${pageContext.request.contextPath}/resources/css/inc/top.css" rel="styleSheet"> --%>
<%-- 	<link href="${pageContext.request.contextPath}/resources/css/inc/footer.css" rel="styleSheet"> --%>
	<script src="${pageContext.request.contextPath}/resources/js/inc/jquery-3.7.0.js"></script>
<title>리뷰 게시글 작성</title>

</head>
<body>
	<header>
<%-- 		<jsp:include page="../../../inc/top1.jsp"></jsp:include> --%>
	</header>
	<div id="notice_cont">
		<section id="sec_con" class="inr">
			<form action="${pageContext.request.contextPath}/AucRegistReviewPro" method="post" enctype="multipart/form-data">
				<section id="board_wrap">
					<section id="board_list" class="notice">
						<div class="wrapper">
							<div class="list_wrap">
								<ul class="list">
									<li>
										<div class="subject">
											<img src="${pageContext.request.contextPath }${auction.image_path }/${auction.image1}" alt="사진나온나">
												상품명 :${auction.auction_title }<br>
												판매자 :${seller.mem_nickname }
										</div>
									</li>
									<li>
										<div class="subject">
											평가점수와 리뷰를 작성해주세요<br>
											거래완료 후 3일동안만 수정가능합니다.
										</div>
									</li>

									<li class="write_scope">
										<div id="myform">
											<fieldset>
													<input type="radio" name="review_star" value="5" id="rate1" selected="selected">
													<label for="rate1">⭐</label>
													<input type="radio" name="review_star" value="4" id="rate2">
													<label for="rate2">⭐</label>
													<input type="radio" name="review_star" value="3" id="rate3">
													<label for="rate3">⭐</label>
													<input type="radio" name="review_star" value="2" id="rate4">
													<label for="rate4">⭐</label>
													<input type="radio" name="review_star" value="1" id="rate5">
													<label for="rate5">⭐</label>
											</fieldset>
										</div>
									</li>
								</ul>

								<div class="write_cont">

									<p>
										<textarea rows="" cols="" class="inputBox" name="review_content" placeholder="내용을 100자 이내로 입력해주세요. 남을 비방하는 말, 비속어, 음란성 글, 광고성이 포함된 글은 관리자 임의로 삭제될 수 있습니다." required="required" style="word-break:break-all;"></textarea>
									</p>
									<input type="hidden" name="product_idx" id="product_idx" value="${auction.product_idx }"/>
									<input type="hidden" name="buyier_idx" id="buyer_idx" value="${buyer_idx }"/>
									<input type="hidden" name="mem_idx" id="mem_idx" value="${seller.mem_idx }"/>
								</div>
								<div class="mod_box">
										<input type="submit" class="delete_btn" value="등록">
								</div>
							</div>
						</div>
					</section>
				</section>
			</form>
		</section>
	</div>
	<footer>
<%-- 		<jsp:include page="../../../inc/footer.jsp"></jsp:include> --%>
	</footer>
	
</body>
</html>