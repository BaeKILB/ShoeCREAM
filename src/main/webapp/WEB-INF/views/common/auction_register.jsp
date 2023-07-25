<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<form action="registProductPro" method="post">
	<h1>경매 상품등록</h1>
	<div class="titleContainner">
		<p class="title_title">기본 정보</p>
	</div>
	<div class="firstContainner">
		<div class="first_title">상품 이미지
			<input type="file" name="image">
		</div>
		<div class="first_content">
			<div class=image_box>
				<div class="image_content" name="file1"></div>
				<div class="image_content" name="file2"></div>
				<div class="image_content" name="file3"></div>
				<div class="image_content" name="file4"></div>
			</div>
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
			<input type="text" class="product_name" name="product_title" placeholder="품목을 입력해주세요."/>
		</div>
	</div>
	<div class="thirdContainner">
		<div class="third_title">카테고리</div>
		<div class="third_content">
			<div class="category_box">
				<div class="category_content_l">제1분류</div>
				<div class="category_content_m">제2분류</div>
				<div class="category_content_s">제3분류</div>
			</div>
			<p class="selected_category">선택한 카테고리 :</p>
		</div>
	</div>
<!-- 	<div class="fourthContainner"> -->
<!-- 		<div class="fourth_title">거래지역</div> -->
<!-- 		<div class="fourth_content"> -->
<!-- 			<!-- 					<input type="hidden" id="sample4_postcode" placeholder="우편번호"> -->
<!-- 			<button type="button" class="location_btn" -->
<!-- 				onclick="sample4_execDaumPostcode();">주소검색</button> -->
<!-- 			<!-- 					<input type="hidden" id="sample4_roadAddress" placeholder="지번주소"> -->
<!-- 			<input type="text" id="sample4_jibunAddress" name="product_location" -->
<!-- 				placeholder="주소검색을 통해 주소를 입력해주세요." disabled="disabled" /> -->
<!-- 			<!-- 					<span id="guide" style="color:#999;display:none"</span> -->
<!-- 			<!-- 					<input type="hidden" id="sample4_detailAddress" placeholder="상세주소"> -->
<!-- 			<!-- 					<input type="hidden" id="sample4_extraAddress" placeholder="참고항목"> -->
<!-- 		</div> -->
<!-- 	</div> -->
	<div class="fifthContainner">
		<div class="fifth_title">브랜드</div>
		<div class="fifth_content">
			<div class="brand_box">
				<label> 
					<span>브랜드</span> 
					<input type="text" class="brand" name="product_brand" />
					<select name="inputBrand" onchange="sellectBrand(this.value)">
						<option value="">기타(직접입력)</option>
						<option value="ADIDAS">ADIDAS</option>
						<option value="ASICS">ASICS</option>
						<option value="BALENCIAGA">BALENCIAGA</option>
						<option value="CROCS">CROCS</option>
						<option value="DISCOVERY">DISCOVERY</option>
						<option value="NASSAU">NASSAU</option>
						<option value="NEW BALANCE">NEW BALANCE</option>
						<option value="NIKE">NIKE</option>
						<option value="NUOVO">NUOVO</option>
						<option value="PRO-SPECS">PRO-SPECS</option>
						<option value="PUMA">PUMA</option>
						<option value="REEBOK">REEBOK</option>
						<option value="VANS">VANS</option>
					</select>
				</label>
			</div>
		</div>
	</div>
	<div class="sixthContainner">
		<div class="sixth_title">사이즈</div>
		<div class="sixth_content">
			<div class="size_box">
				<label class="size_label"> 
					<span>사이즈</span> 
					<input type="text" class="size" name="product_size" />
					<select name="inputSize" onchange="selectSize(this.value)">
						<option value="" selected="selected">직접 입력</option>
						<c:forEach begin="220" step="5" end="310" varStatus="status">
							<option value="${status.index }" >${status.index }</option>
						</c:forEach>
					</select>
				</label>
<%-- 				<button type="button" class="sizeTableBtn" onclick="window.open('${pageContext.request.contextPath}/resources/img/junggo/sizeTable.png','사이즈 표','width=502,height=500,location=no,status=no,scrollbars=yes');">사이즈표</button> --%>
			</div>
		</div>
	</div>
	<div class="seventhContainner">
		<div class="seventh_title">경매시작가</div>
		<div class="seventh_content">
			<input type="text" class="total_fee" name="auc_start_price" placeholder="금액을 입력해주세요." />&nbsp;원
		</div>
		<div class="seventh_title">입찰단위</div>
		<div class="seventh_content">
			<input type="text" class="total_fee" name="auc_bid_unit" placeholder="금액을 입력해주세요." />&nbsp;원
		</div>
		<div class="seventh_title">즉시구매가</div>
		<div class="seventh_content">
			<input type="text" class="total_fee" name="auc_buy_instantly" placeholder="금액을 입력해주세요." />&nbsp;원
		</div>
	</div>
	<div class="eighthContainner">
		<div class="eighth_title">경매시작일</div>	
		<div class="eighth_content">
			<input type="date"> 
		</div>
		<div class="eighth_title">경매마감일</div>	
		<div class="eighth_content">
			<input type="date"> 
		</div>
	</div>
	<div class="ninthContainner">ninthContainner
		<div class="ninth_title">상품설명</div>eighthContainner
		<div class="ninth_content">
			<textarea class="product_detail" name="product_info" placeholder="상품에 대한 설명을 작성해주세요" ></textarea>
		</div>
	</div>
<!-- 	<div class="tenthContainner"> -->
<!-- 		<div class="tenth_title">결제수단</div> -->
<!-- 		<div class="tenth_content"> -->
<!-- 			<div class="check_box"> -->
<!-- 				<label>  -->
<!-- 					<input type="checkbox" name="product_payment" checked="checked" value="안전페이" /> 안전페이 가능  -->
<!-- 					<input type="checkbox" name="product_payment" checked="checked" value="직거래" /> 직거래 가능 -->
<!-- 				</label> -->
<!-- 			</div> -->
<!-- 			<p class="duplication_Ok">중복 선택 가능</p> -->
<!-- 		</div> -->
<!-- 	</div> -->
	<div class="lastContainner">
		<button type="submit" class="register_btn">등록하기</button>
		<button type="button" class="back_btn" onclick="location.href='./'">돌아가기</button>
	</div>
</form>