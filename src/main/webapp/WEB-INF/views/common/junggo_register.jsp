<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<form action="registProductPro" method="post" enctype="multipart/form-data">
	<div class="titleContainner">
		<p class="title_title">기본 정보</p>
	</div>
	<div class="firstContainner">
		<div class="first_title">상품 이미지()</div>
		<div class="first_content">
			<div class=image_box>
				<div class="image_content" name="file1"></div>
				<div class="image_content" name="file2"></div>
				<div class="image_content" name="file3"></div>
				<div class="image_content" name="file4"></div>

<!-- <input type="file" id="image" accept="image/*" onchange="setThumbnail(event);" multiple/>
    <div id="image_container"></div>

    <script>
      function setThumbnail(event) {
        for (var image of event.target.files) {
          var reader = new FileReader();

          reader.onload = function(event) {
            var img = document.createElement("img");
            img.setAttribute("src", event.target.result);
            document.querySelector("div#image_container").appendChild(img);
          };

          console.log(image);
          reader.readAsDataURL(image);
        }
      }
    </script>
	 -->	
	
				
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
				value="품목을 입력해주세요." onfocus="this.select()" />
		</div>
	</div>
	<div class="thirdContainner">
		<div class="third_title">카테고리</div>
		<div class="third_content">
			<div class="category_box">
				<div class="category_content_l">제1분류<div>a</div><div>a</div></div>
				<div class="category_content_m">제2분류</div>
				<div class="category_content_s">제3분류</div>
			</div>
			<p class="selected_category">선택한 카테고리 :</p>
		</div>
	</div>
	

<!-- <select id="region" name="region">
  <option value="">-- 본부 --</option>
  <option value="A">강북본부</option>
  <option value="B">강남본부</option>
  <option value="C">서부본부</option>
</select>
<select id="maker" name="maker">
  <option value="">-- 제조사 --</option>
  <option class="A" value="hyundai">현대</option>
  <option class="A" value="kia">기아</option>
  <option class="B" value="benz">벤츠</option>
  <option class="B" value="bmw">BMW</option>
</select>
<select id="size" name="size">
  <option value="">-- 크기 --</option>
  <option value="large" class="hyundai kia benz bmw">대형</option>
  <option value="medium" class="hyundai kia benz">중형</option>
  <option value="small" class="hyundai kia bmw">소형</option>
</select>

<script src="//code.jquery.com/jquery.min.js"></script>
<script src='//cdnjs.cloudflare.com/ajax/libs/jquery-chained/1.0.1/jquery.chained.min.js'></script>
<script>
  $("#maker").chained("#region");
  $("#size").chained("#maker");
</script>
 -->	
	
	
	

<!--<script type="text/javascript">
 
$(document).ready(function() {
    
    //Main 카테고리를 선택 할때 마다 AJAX를 호출할 수 있지만 DB접속을 매번 해야 하기 때문에 main, sub카테고리 전체을 들고온다.
    
    //****************이부분은 DB로 셋팅하세요.
    //Main 카테고리 셋팅 (DB에서 값을 가져와 셋팅 하세요.)
    var mainCategoryArray = new Array();
    var mainCategoryObject = new Object();
    
    mainCategoryObject = new Object();
    mainCategoryObject.main_category_id = "1";
    mainCategoryObject.main_category_name = "스포츠";
    mainCategoryArray.push(mainCategoryObject);
    
    mainCategoryObject = new Object();
    mainCategoryObject.main_category_id = "2";
    mainCategoryObject.main_category_name = "공연";
    mainCategoryArray.push(mainCategoryObject);
    
    //Sub 카테고리 셋팅 (DB에서 값을 가져와 셋팅 하세요.)
    var subCategoryArray = new Array();
    var subCategoryObject = new Object();
    
    //스포츠에 해당하는 sub category 리스트
    subCategoryObject = new Object();
    subCategoryObject.main_category_id = "1";
    subCategoryObject.sub_category_id = "1"
    subCategoryObject.sub_category_name = "야구"    
    subCategoryArray.push(subCategoryObject);
    
    subCategoryObject = new Object();
    subCategoryObject.main_category_id = "1";
    subCategoryObject.sub_category_id = "2"
    subCategoryObject.sub_category_name = "농구"    
    subCategoryArray.push(subCategoryObject);
   
    //공연에 해당하는 sub category 리스트
    subCategoryObject = new Object();
    subCategoryObject.main_category_id = "2";
    subCategoryObject.sub_category_id = "1"
    subCategoryObject.sub_category_name = "연극"    
    subCategoryArray.push(subCategoryObject);
    
    subCategoryObject = new Object();
    subCategoryObject.main_category_id = "2";
    subCategoryObject.sub_category_id = "2"
    subCategoryObject.sub_category_name = "뮤지컬"    
    subCategoryArray.push(subCategoryObject);
    
    
    //****************이부분은 DB로 셋팅하세요.
    
    
    //메인 카테고리 셋팅
    var mainCategorySelectBox = $("select[name='mainCategory']");
    
    for(var i=0;i<mainCategoryArray.length;i++){
        mainCategorySelectBox.append("<option value='"+mainCategoryArray[i].main_category_id+"'>"+mainCategoryArray[i].main_category_name+"</option>");
    }
    
    //*********** 1depth카테고리 선택 후 2depth 생성 START ***********
    $(document).on("change","select[name='mainCategory']",function(){
        
        //두번째 셀렉트 박스를 삭제 시킨다.
        var subCategorySelectBox = $("select[name='subCategory']");
        subCategorySelectBox.children().remove(); //기존 리스트 삭제
        
        //선택한 첫번째 박스의 값을 가져와 일치하는 값을 두번째 셀렉트 박스에 넣는다.
        $("option:selected", this).each(function(){
            var selectValue = $(this).val(); //main category 에서 선택한 값
            subCategorySelectBox.append("<option value=''>전체</option>");
            for(var i=0;i<subCategoryArray.length;i++){
                if(selectValue == subCategoryArray[i].main_category_id){
                    
                    subCategorySelectBox.append("<option value='"+subCategoryArray[i].sub_category_id+"'>"+subCategoryArray[i].sub_category_name+"</option>");
                    
                }
            }
        });
        
    });
    //*********** 1depth카테고리 선택 후 2depth 생성 END ***********
        
});

function changeHtml()
{
	var mainCategory = document.getElementById("mainCategory").value;
	var subCategory = document.getElementById("subCategory").value;
	if(mainCategory == 1 && subCategory == 1){document.getElementById('selected_category').innerHTML="스포츠 > 야구"}
	if(mainCategory == 1 && subCategory == 2){document.getElementById('selected_category').innerHTML="스포츠 > 농구"}
	if(mainCategory == 2 && subCategory == 1){document.getElementById('selected_category').innerHTML="공연 > 연극"}
	if(mainCategory == 2 && subCategory == 2){document.getElementById('selected_category').innerHTML="공연 > 뮤지컬"}
}
</script>-->




	
	
	
	
	<div class="fourthContainner">
		<div class="fourth_title">거래지역</div>
		<div class="fourth_content">
			<!-- 					<input type="hidden" id="sample4_postcode" placeholder="우편번호"> -->
			<button type="button" class="location_btn"
				onclick="sample4_execDaumPostcode();">주소검색</button>
			<!-- 					<input type="hidden" id="sample4_roadAddress" placeholder="지번주소"> -->
			<input type="text" id="sample4_jibunAddress" name="product_location"
				placeholder="주소검색을 통해 주소를 입력해주세요."  readonly/><!-- disabled="disabled" -->
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
				<label class="size_label"> <span>사이즈</span> <input
					type="text" class="size" name="product_size"
					onfocus="this.select()" />
				</label>
				<button type="button" class="sizeTableBtn"
					onclick="window.open('${pageContext.request.contextPath}/resources/img/junggo/sizeTable.png','사이즈 표','width=502,height=500,location=no,status=no,scrollbars=yes');">사이즈표</button>
			</div>
			<div class="brand_box">
				<label> <span>브랜드</span> <input type="text" class="brand"
					name="product_brand" /> <select name="inputBrand"
					onchange="sellectBrand(this.value)">
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
			<input type="text" class="total_fee" name="product_price"
				placeholder="금액을 입력해주세요." onfocus="this.select()" />&nbsp;원(₩)

		</div>
	</div>

	<div class="eighthContainner">
		<div class="eighth_title">상품설명</div>
		<div class="eighth_content">
			<textarea class="product_detail" name="product_info" rows="" cols=""
				onfocus="this.select()">상품에 대한 설명을 작성해주세요</textarea>
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
		<button type="button" class="back_btn"
			onclick="location.href='address'">돌아가기</button>
	</div>
</form>