<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>



<form action="registProductPro" method="post" enctype="multipart/form-data">
	<div class="titleContainner">
		<p class="title_title">기본 정보</p>
	</div>
	<div class="firstContainner">
		<div class="first_title">상품 이미지()</div>
		<div class="first_content">
			<div class=image_box>
				<input type="file" name="file1" /><br>
				<input type="file" name="file2" /><br>
				<input type="file" name="file3" /><br>
				<input type="file" name="file4" /><br>
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
			<input type="text" class="product_name" name="product_title"
				placeholder="품목을 입력해주세요." required="required" onfocus="this.select()" />
		</div>
	</div>
	
	<!-- <div class="thirdContainner">
		<div class="third_title">카테고리</div>
		<div class="third_content">
			<div class="category_box">
				
				제1분류 : <select name="lc_code" id="lc_code" style="width:200px">
			        <option value="">전체</option>
			    </select>
			    제2분류 : <select name="mc_code" id="mc_code" style="width:200px" onchange="changeHtml();">
			       	<option value="">전체</option>
			    </select>
				
			</div>
			<p class="selected_category">선택한 카테고리 :<div id="selected_category" name="selected_category"></div></p>
		</div>
	</div>
	

	<script type="text/javascript">
	 
	$(document).ready(function() {
	    
	    //Main 카테고리를 선택 할때 마다 AJAX를 호출할 수 있지만 DB접속을 매번 해야 하기 때문에 main, sub카테고리 전체을 들고온다.
	    
	    //****************이부분은 DB로 셋팅하세요.
	    //Main 카테고리 셋팅 (DB에서 값을 가져와 셋팅 하세요.)
	    var lc_codeArray = new Array();
	    var lc_codeObject = new Object();
	    
	    lc_codeObject = new Object();
	    lc_codeObject.lc_code_id = "1";
	    lc_codeObject.lc_code_name = "남성";
	    lc_codeArray.push(lc_codeObject);
	    
	    lc_codeObject = new Object();
	    lc_codeObject.lc_code_id = "2";
	    lc_codeObject.lc_code_name = "여성";
	    lc_codeArray.push(lc_codeObject);
	    
	    //Sub 카테고리 셋팅 (DB에서 값을 가져와 셋팅 하세요.)
	    var mc_codeArray = new Array();
	    var mc_codeObject = new Object();
	    
	    //스포츠에 해당하는 sub category 리스트
	    mc_codeObject = new Object();
	    mc_codeObject.lc_code_id = "1";
	    mc_codeObject.mc_code_id = "1"
	    mc_codeObject.mc_code_name = "운동화"    
	    mc_codeArray.push(mc_codeObject);
	    
	    mc_codeObject = new Object();
	    mc_codeObject.lc_code_id = "1";
	    mc_codeObject.mc_code_id = "2"
	    mc_codeObject.mc_code_name = "구두"    
	    mc_codeArray.push(mc_codeObject);
	   
	    //공연에 해당하는 sub category 리스트
	    mc_codeObject = new Object();
	    mc_codeObject.lc_code_id = "2";
	    mc_codeObject.mc_code_id = "1"
	    mc_codeObject.mc_code_name = "운동화"    
	    mc_codeArray.push(mc_codeObject);
	    
	    mc_codeObject = new Object();
	    mc_codeObject.lc_code_id = "2";
	    mc_codeObject.mc_code_id = "2"
	    mc_codeObject.mc_code_name = "구두"    
	    mc_codeArray.push(mc_codeObject);
	    
	    
	    //****************이부분은 DB로 셋팅하세요.
	    
	    
	    //메인 카테고리 셋팅
	    var lc_codeSelectBox = $("select[name='lc_code']");
	    
	    for(var i=0;i<lc_codeArray.length;i++){
	        lc_codeSelectBox.append("<option value='"+lc_codeArray[i].lc_code_id+"'>"+lc_codeArray[i].lc_code_name+"</option>");
	    }
	    
	    //*********** 1depth카테고리 선택 후 2depth 생성 START ***********
	    $(document).on("change","select[name='lc_code']",function(){
	        
	        //두번째 셀렉트 박스를 삭제 시킨다.
	        var mc_codeSelectBox = $("select[name='mc_code']");
	        mc_codeSelectBox.children().remove(); //기존 리스트 삭제
	        
	        //선택한 첫번째 박스의 값을 가져와 일치하는 값을 두번째 셀렉트 박스에 넣는다.
	        $("option:selected", this).each(function(){
	            var selectValue = $(this).val(); //main category 에서 선택한 값
	            mc_codeSelectBox.append("<option value=''>전체</option>");
	            for(var i=0;i<mc_codeArray.length;i++){
	                if(selectValue == mc_codeArray[i].lc_code_id){
	                    
	                    mc_codeSelectBox.append("<option value='"+mc_codeArray[i].mc_code_id+"'>"+mc_codeArray[i].mc_code_name+"</option>");
	                    
	                }
	            }
	        });
	        
	    });
	    //*********** 1depth카테고리 선택 후 2depth 생성 END ***********
	        
	});
	
	function changeHtml()
	{
		var lc_code = document.getElementById("lc_code").value;
		var mc_code = document.getElementById("mc_code").value;
		if(lc_code == 1 && mc_code == 1){document.getElementById('selected_category').innerHTML="남성 > 운동화"}
		if(lc_code == 1 && mc_code == 2){document.getElementById('selected_category').innerHTML="남성 > 구두"}
		if(lc_code == 2 && mc_code == 1){document.getElementById('selected_category').innerHTML="여성 > 운동화"}
		if(lc_code == 2 && mc_code == 2){document.getElementById('selected_category').innerHTML="여성 > 구두"}
	}
	</script>
	-->

	<div class="thirdContainner">
		<div class="third_title">카테고리</div>
		<div class="third_content">
			<div class="category_box">
				<div class="category_content_l">
					<input type="hidden" name="lc_code">
				    <div>제1분류</div>
				    <div>
				        <ul id="lcList">
				            <c:forEach var="lc" items="${lc_category }" >
				                <li class="lcRecord" value="${lc.lc_code }">${lc.lc_name }</li>
				            </c:forEach>
				        </ul>
				    </div>
				</div>
				<div class="category_content_m">
					<input type="hidden" name="mc_code">
				    <div>제2분류</div>
				    <div>
				        <ul id="mcList"></ul>
				    </div>
				</div>
<!-- 				<div class="category_content_s"> -->
<!-- 					<input type="hidden" name="sc_code"> -->
<!-- 				    <div>제3분류</div> -->
<!-- 				    <div> -->
<!-- 				        <ul id="scList"></ul> -->
<!-- 				    </div> -->
<!-- 				</div> -->
			</div>
			<p class="selected_category">
				<span>선택한 카테고리 :</span>
				<span id="selectCategory">
					<span id="selectLcn"></span>
					<span id="selectMcn"></span>
<!-- 					<span id="selectScn"></span> -->
				</span>
			</p>
		</div>
	</div>	
	
	<div class="fourthContainner">
		<div class="fourth_title">거래지역</div>
		<div class="fourth_content">
			<!-- 					<input type="hidden" id="sample4_postcode" placeholder="우편번호"> -->
			<button type="button" class="location_btn"
				onclick="sample4_execDaumPostcode();">주소검색</button>
			<!-- 					<input type="hidden" id="sample4_roadAddress" placeholder="지번주소"> -->
			<input type="text" id="sample4_jibunAddress" name="product_location"
				placeholder="주소검색을 통해 주소를 입력해주세요."  required="required" readonly/><!-- disabled="disabled" -->
			<!-- 					<span id="guide" style="color:#999;display:none"</span> -->
			<!-- 					<input type="hidden" id="sample4_detailAddress" placeholder="상세주소"> -->
			<!-- 					<input type="hidden" id="sample4_extraAddress" placeholder="참고항목"> -->
		</div>
	</div>
	<div class="fifthContainner">
		<div class="fifth_title">상품품질상태</div>
		<div class="fifth_content">
			<div class="radio_box">
				<label> <input type="radio" name="product_status"
					value="중고(상급)" /> <span>중고(상급)</span>
				</label> <label> <input type="radio" name="product_status"
					value="중고(하급)" /> <span>중고(하급)</span>
				</label> <label> <input type="radio" name="product_status"
					value="미개봉" /> <span>미개봉</span>
				</label>
			</div>
			<p class="duplication_warning">중복 선택 불가</p>
		</div>
	</div>
	<div class="sixthContainner">
		<div class="sixth_title">사이즈, 브랜드</div>
		<div class="sixth_content">
			<div class="size_box">
				<label class="size_label"> <span>사이즈</span> 
				<input type="text" class="size" name="product_size" placeholder="사이즈표를 참고해주세요" required="required" onfocus="this.select()" />
				</label>
				<button type="button" class="sizeTableBtn"
					onclick="window.open('${pageContext.request.contextPath}/resources/img/junggo/sizeTable.png','사이즈 표','width=502,height=500,location=no,status=no,scrollbars=yes');">사이즈표</button>
			</div>
			<div class="brand_box">
				<label> <span>브랜드</span> 
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

	<div class="seventhContainner">
		<div class="seventh_title">가격</div>
		<div class="seventh_content">
			<!-- 					<label>  -->
			<!-- 					 	<input type="checkbox" class="delivery_fee" checked="checked">&nbsp; 배송비 포함 -->
			<!-- 					</label>  -->
			<input type="text" class="total_fee" name="product_price" placeholder="금액을 입력해주세요." required="required" onfocus="this.select()" />&nbsp;원(₩)

		</div>
	</div>

	<div class="eighthContainner">
		<div class="eighth_title">상품설명</div>
		<div class="eighth_content">
			<textarea class="product_detail" name="product_info" rows="" cols="" placeholder="상품에 대한 설명을 작성해주세요" required="required" onfocus="this.select()"></textarea>
		</div>
	</div>

	<!-- 			<div class="ninthContainner"> -->
	<!-- 				<div class="ninth_title">태그첨부</div>	 -->
	<!-- 				<div class="ninth_content"> -->
	<!-- 					<input type="text" class="product_tag" value="#을 붙여서 태그를 작성해주세요. EX) #신발 #나이키 #한정" onfocus="this.select()">  -->
	<!-- 				</div> -->
	<!-- 			</div> -->

	<div class="tenthContainner">
		<div class="tenth_title">결제수단</div>
		<div class="tenth_content">
			<div class="check_box">
				<label> <input type="checkbox" name="product_payment"
					checked="checked" value="안전페이" />&nbsp; 안전페이 가능
					&nbsp;&nbsp;&nbsp;&nbsp; <input type="checkbox"
					name="product_payment" checked="checked" value="직거래" />&nbsp; 직거래
					가능
				</label>

			</div>
			<p class="duplication_Ok">중복 선택 가능</p>
		</div>
	</div>


	<div class="lastContainner">
		<input type="submit" class="register_btn" value="등록">
		<button type="button" class="back_btn" onclick="location.href='address'">돌아가기</button>
	</div>
</form>