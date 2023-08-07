<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<head>
<link href="${pageContext.request.contextPath }/resources/css/common/auction_register.css" rel="stylesheet">

</head>
<form action="CreamRegister" method="post" enctype="multipart/form-data">
	<h1>크림 상품등록</h1>
	<div class="titleContainner">
		<p class="title_title">기본 정보</p>
	</div>
	<div class="firstContainner">
		<div class="first_title">상품 이미지	
			<div class="image_box">
			    <div>
			        이미지 등록
			        <input type="file" id="image1" name="image1" accept="image/*" onchange="setImages(event)">
			        <input type="file" id="image2" name="image2" accept="image/*" onchange="setImages(event)">
			        <input type="file" id="image3" name="image3" accept="image/*" onchange="setImages(event)">
			        <input type="file" id="image4" name="image4" accept="image/*" onchange="setImages(event)">
			    </div>
			</div>
		</div>
		<div class="first_content">
		    <div class="ivBox"></div>
			<div class="warning_text">
				* 상품 이미지는 640x640에 최적화 되어 있습니다.<br> - 상품 이미지는 PC에서는 1:1, 모바일에서는
				1:1.23 비율로 보여집니다.<br> - 이미지는 상품 등록 시 정사각형으로 잘려서 등록됩니다.<br>
				- 큰 이미지일 경우 이미지가 깨지는 경우가 발생할 수 있습니다.<br> 최대 지원 사이즈인 640 X 640으로
				리사이즈 해서 올려주세요.(개당 이미지 최대 10M)<br>
			</div>
		</div>
	</div>
	<div class="secondContainner">
		<div class="second_title">제목</div>
		<div class="second_content">
			<input type="text" class="product_name" name="ci_name" placeholder="품목을 입력해주세요."/>
		</div>
	</div>



	<div class="sixthContainner">
		<div class="sixth_title">사이즈/가격</div>
		<div class="sixth_content">
			<div class="size_box">
					    <c:forEach begin="220" end="310" step="5" varStatus="status">
				        <input type="hidden"value="${status.index}">
				        <label><span>${status.index}</span></label>
				        <input type="number" name="size${status.index}" >
				        <br>
				       
				    </c:forEach>
			</div>
		</div>
	</div>

	
	<div class="ninthContainner">
		<div class="ninth_title">상품설명</div>
		<div class="ninth_content">
			<textarea class="product_detail" name="ci_content" placeholder="상품에 대한 설명을 작성해주세요" ></textarea>
		</div>
	</div>

	<div class="lastContainner">
		<button type="submit" class="register_btn">등록하기</button>
		<button type="button" class="back_btn" onclick="location.href='./'">돌아가기</button>
	</div>
</form>