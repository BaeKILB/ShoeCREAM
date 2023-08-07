<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>  
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%--최신본 인증!--%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>해당 품목 상세보기</title>
	<link href="${pageContext.request.contextPath}/resources/css/junggo/common.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/resources/css/junggo/junggo_report_register.css" rel="stylesheet">
<%-- 	<link href="${pageContext.request.contextPath}/resources/css/inc/top.css" rel="styleSheet"> --%>
<%-- 	<link href="${pageContext.request.contextPath}/resources/css/inc/footer.css" rel="styleSheet"> --%>
	<link href="${pageContext.request.contextPath }/resources/css/etc/bootstrap.min.css" rel="stylesheet">
	<script	src="${pageContext.request.contextPath }/resources/js/etc/bootstrap.bundle.min.js"></script>
	<script	src="${pageContext.request.contextPath }/resources/js/common/product_register.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.0.js"></script>
<%--주소 관련 코드--%>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	
	<script type="text/javascript">
		function sellectBrand(selBrand){
     	   $(".brand").val(selBrand);
   		 }
	</script>
</head>
<body>
	<header>
	<%--top 탑 활성화시 css도 살려야함--%>
<%-- <jsp:include page="../../../inc/top1.jsp"></jsp:include> --%>
	</header>
	<%--입력하지 않은 자료 보낼 때--%>
<%-- 		<input type="hidden" name="car_model" value="${map.car_info.car_model}"/> --%>
	<main>
		<section id="sec_con" class="register_view inr">
			<form action="registReportPro" method="post" enctype="multipart/form-data">
	
	<div class="titleContainner">
		<p class="title_title">신고 등록 기본 정보</p>
	</div>
	
		
	<div class="secondContainner">
		<div class="second_title">신고 대상 글</div> <!-- 수정폼 이용해서 타이틀 가져오기(수정불가로) -->
		<div class="second_content">
			<input type="text" class="inputBox" name="product_title" value="${jungGoNohReport.product_title}" readonly/>
		</div>
	</div>
		<div class="secondContainner">
		<div class="second_title">신고 대상</div> <!-- 수정폼 이용해서 해당 멤버 닉네임 가져오기(수정불가로, 검색은 idx로 하되 노출은 닉네임) -->
		<div class="second_content">
			<input type="text" class="inputBox" name="mem_nickname" value="${jungGoNohReport.mem_nickname}" readonly/>
		</div>
	</div>
		<div class="secondContainner">
		<div class="second_title">신고 요청자</div> <!-- 수정폼 이용해서 해당 멤버 닉네임 가져오기(수정불가로, 검색은 idx로 하되 노출은 닉네임) -->
		<div class="second_content">
			<input type="text" class="inputBox" name="buyier_nickname" value="${jungGoNohReport.buyier_nickname}" readonly/>
		</div>
	</div>
	
	<div class="sixthContainner">
		<div class="sixth_title">신고 유형</div>
		<div class="sixth_content">
			<div class="brand_box">
				<label> 
					<span>행위 유형</span> 
					<input type="text" class="brand" name="report_div" required="required"/> 
					<select name="inputBrand" onchange="sellectBrand(this.value)">
						<option value="" selected="selected">기타(직접입력)</option>
						<option value="광고성 콘텐츠(판매) 입니다.">광고성 콘텐츠(판매) 입니다.</option>
						<option value="상품 관련 정보가 부정확합니다.">상품 관련 정보가 부정확합니다.</option>
						<option value="거래 금지 품목으로 판단됩니다.">거래 금지 품목으로 판단됩니다. ex> 신발 이외</option>							
						<option value="안전거래를 거부합니다.">안전거래를 거부합니다.</option>
						<option value="사기가 의심됩니다. (외부 프로그램 유도)">사기가 의심됩니다. (외부 프로그램 유도)</option>
						<option value="분쟁유도 행위가 의심됩니다.(채팅 중 비속어 사용 또는 험한 말 사용)">분쟁유도(채팅 중 비속어 사용 또는 험한 말 사용)</option>
						<option value="개인 정보 유출 위험이 있습니다.">개인 정보 유출 위험이 있습니다.</option>
					</select>
				</label>
			</div>
		</div>
	</div>
	
	<div class="eighthContainner">
		<div class="eighth_title">신고 상세 이유</div>
		<div class="eighth_content">
			<textarea class="product_detail" name="report_detail" rows="" cols="" placeholder="신고 당시 상황에 대한 자세한 설명을 적어주세요" required="required"
				onfocus="this.select()"></textarea>
				<input type="hidden" name="product_idx" id="product_idx" value="${jungGoNohReport.product_idx}"/>
				<input type="hidden" name="buyier_idx" id="buyier_idx" value="${jungGoNohReport.buyier_idx}"/>
				<input type="hidden" name="mem_idx" id="mem_idx" value="${jungGoNohReport.mem_idx}"/>
		</div>
	</div>
		

	<div class="lastContainner">
		<input type="submit" class="register_btn" value="등록" >
		<button type="button" class="back_btn" onclick="location.href='address'">돌아가기</button>
	</div>
</form>
	</section>
	</main>
	<footer>
	<%--footer 풋터 활성화 시 css도 살려야함--%>
<%-- 		<jsp:include page="../../../inc/footer.jsp"></jsp:include> --%>
	</footer>
</body>
</html>



