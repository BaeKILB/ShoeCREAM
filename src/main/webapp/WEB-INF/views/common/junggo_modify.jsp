<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<head>
<link href="${pageContext.request.contextPath }/resources/css/common/auction_register.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/resources/css/common/product_register.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/common/common.css">


<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.0.js"></script>
<script	src="${pageContext.request.contextPath}/resources/js/etc/jquery.datetimepicker.full.min.js"></script>
<%-- <script src="${pageContext.request.contextPath}/resources/js/common/product_register.js"></script>--%>
<%-- <script	src="${pageContext.request.contextPath }/resources/js/auction/auction_modify_form.js"></script> --%>

<%--주소 관련 코드--%>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script type="text/javascript">
//이미지 관련
let count = 0;
$(function() {
	// 숨김 처리
	$(".imageView").each(function(index) {
		count = index + 1;
	})
	
	$("input[type=file]").each(function(index) {
		if (index+1 <= count) {
		$(this).addClass("hidden");
		return;
		}
	});
	
	if(count < 4) {
		$(".image_box").removeClass("hidden");
	} else {
		$(".image_box").addClass("hidden");
	}
});
// 추가된 이미지 삭제
const imgDelete = (currentId) => {
	$("button[value="+currentId+"]").remove();
	$("#"+currentId).removeClass("hidden").val('');	
	count--;
	if(count < 4) {
		$(".image_box").removeClass("hidden");
	};
};
// 이미지 등록시 사진출력
const setImages = (e) => {
	let currentId = e.target.name;
	$("#"+currentId).next().removeClass("hidden");
	$("#"+currentId).addClass("hidden");
	
	let reader = new FileReader();
	for(let image of e.target.files) {
		reader.onload = function (event) {
			let result = (
				"<button type='button' onclick='imgDelete(this.value)' value='"+currentId+"'>"
				+"<img class='imageView' src='"+event.target.result+"'>"
				+"</button>"
			);
			$(".ivBox").append(result);
		};
		reader.readAsDataURL(image);
	}; 
	count ++;
	if(count >= 4) {
		$(".image_box").addClass("hidden");
	};
};

function sample4_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            /*팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.*/

            /*도로명 주소의 노출 규칙에 따라 주소를 표시한다.
            내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.*/
            var roadAddr = data.roadAddress; // 도로명 주소 변수
            var extraRoadAddr = ''; // 참고 항목 변수

            /*법정동명이 있을 경우 추가한다. (법정리는 제외)
            법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.*/
            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                extraRoadAddr += data.bname;
            }
            /*건물명이 있고, 공동주택일 경우 추가한다.*/
            if(data.buildingName !== '' && data.apartment === 'Y'){
               extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
            }
            /*표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.*/
            if(extraRoadAddr !== ''){
                extraRoadAddr = ' (' + extraRoadAddr + ')';
            }

          /*우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('sample4_postcode').value = data.zonecode;
            document.getElementById("sample4_roadAddress").value = roadAddr;*/
         	document.getElementById("sample4_jibunAddress").value = data.jibunAddress;
            
          /*참고항목 문자열이 있을 경우 해당 필드에 넣는다.
            if(roadAddr !== ''){
                document.getElementById("sample4_extraAddress").value = extraRoadAddr;
            } else {
                document.getElementById("sample4_extraAddress").value = '';
            }

            var guideTextBox = document.getElementById("guide");
             사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
            if(data.autoRoadAddress) {
                var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                guideTextBox.style.display = 'block';

            } else if(data.autoJibunAddress) {
                var expJibunAddr = data.autoJibunAddress;
                guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                guideTextBox.style.display = 'block';
            } else {
                guideTextBox.innerHTML = '';
                guideTextBox.style.display = 'none';
            }*/
        }
    }).open();
}

$(document).ready(function() {
	$("#inputBrand").val("${jungGoNoh.product_brand}").prop("selected", true);
}); 


//카테고리 선택
$(function() {
    // 중분류 추가
    const mrAdd = (data) => {
        $(".mcRecord").remove();
        $(".scRecord").remove();
        for(let item of data) {
            let result = (
              "<li class='mcRecord' value='"+item.mc_code+"'>"+item.mc_name+"</li>"  
            );
            $("#mcList").append(result);
        };
    };
    // 소분류 추가
//    const srAdd = (data) => {
//        $(".scRecord").remove();
//        for(let item of data) {
//            let result = (
//              "<li class='scRecord' value='"+item.sc_code+"'>"+item.sc_name+"</li>"  
//            );
//            $("#scList").append(result);
//        };     
//    };
    // 카테고리 클릭 이벤트
    $(".lcRecord").on("click",function() {
		let lc_code = $(this).val();
		$("input[name=lc_code]").val(lc_code);
		$("input[name=mc_code]").val('');
//		$("input[name=sc_code]").val('');
		let lc_name = $(this).text();
		$("#selectLcn").text(lc_name);
		$("#selectMcn").text('');
//		$("#selectScn").text('');
        $.ajax({
            type: "get",
            url: "getMcList",
            data: {
                lc_code : lc_code
            },
            dataType: "json"
        })
        .done(function(data) {
            mrAdd(data);
            $(".mcRecord").on("click",function() {
				let mc_code = $(this).val();
				$("input[name=mc_code]").val(mc_code);
				$("input[name=sc_code]").val('');
				let mc_name = $(this).text();
				$("#selectMcn").text(" > " + mc_name);
//				$("#selectScn").text('');
//                $.ajax({
//                    type: "get",
//                    url: "getScList",
//                    data: {
//                        mc_code : mc_code
//                    },
//                    dataType: "json"
//                })
//                .done(function(data) {
//                    srAdd(data);
//                    $(".scRecord").on("click",function() {
//						let sc_code = $(this).val();
//						$("input[name=sc_code]").val(sc_code);
//						let sc_name = $(this).text();
//						$("#selectScn").text(" > "+sc_name);
//		            }); 
//                })
//                .fail(function() {
                    
//                });
            });            
        })
        .fail(function() {
            
        });
    });
});


</script>



</head>
<div id="main_cont">
<form action="junggoModifyPro" method="post" enctype="multipart/form-data">
	<input type="hidden" name="product_idx" id="product_idx" value="${jungGoNoh.product_idx}"/>
	<input type="hidden" name="mem_idx" id="mem_idx" value="${jungGoNoh.mem_idx}"/>
	<input type="hidden" name="buyier_idx" id="buyier_idx" value="${jungGoNoh.buyier_idx}"/>
	<h1>중고상품수정</h1>
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
		    <div class="ivBox">
		    	<c:if test="${jungGoNoh.image1_name != '' }">
			    	<button type="button" onclick='imgDelete(this.value)' value="image1_name" disabled >
			    		<img class="imageView" src="${pageContext.request.contextPath}/resources/upload/${jungGoNoh.image1_name }">
			    	</button>
		    	</c:if>
		    	<c:if test="${jungGoNoh.image2_name != '' }">
			    	<button type="button" onclick='imgDelete(this.value)' value="image2_name" disabled >
			    		<img class="imageView" src="${pageContext.request.contextPath}/resources/upload/${jungGoNoh.image2_name }">
			    	</button>
		    	</c:if>
		    	<c:if test="${jungGoNoh.image3_name != '' }">
			    	<button type="button" onclick='imgDelete(this.value)' value="image3_name" disabled>
			    		<img class="imageView" src="${pageContext.request.contextPath}/resources/upload/${jungGoNoh.image3_name }">
			    	</button>
		    	</c:if>
		    	<c:if test="${jungGoNoh.image4_name != '' }">
			    	<button type="button" onclick='imgDelete(this.value)' value="image4_name" disabled>
			    		<img class="imageView" src="${pageContext.request.contextPath}/resources/upload/${jungGoNoh.image4_name }">
			    	</button>
		    	</c:if>
		    </div>
			<div class="warning_text">
				* 이미지 변경은 불가능하니 이점 유의해주시기 바랍니다.
			</div>
 		</div>
	</div>
	<div class="secondContainner">
		<div class="second_title">제목</div>
		<div class="second_content">
			<input type="text" class="product_name" name="product_title"
				value="${jungGoNoh.product_title}" required="required" onfocus="this.select()" />
		</div>
	</div>
	

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
			<!-- 					<input type="hidden " id="sample4_roadAddress" placeholder="지번주소"> -->
			<input type="text" id="sample4_jibunAddress" name="product_location"
				value="${jungGoNoh.product_location}" required="required" readonly/><!-- disabled="disabled" -->
			<!-- 					<span id="guide" style="color:#999;display:none"</span> -->
			<!-- 					<input type="hidden" id="sample4_detailAddress" placeholder="상세주소"> -->
			<!-- 					<input type="hidden" id="sample4_extraAddress" placeholder="참고항목"> -->
		</div>
	</div>
	<div class="fifthContainner">
		<div class="fifth_title">상품품질상태</div>
		<div class="fifth_content">
			<div class="radio_box">
				<c:choose>
					<c:when test="${jungGoNoh.product_status == '중고(상급)'}">
				<label> <input type="radio" name="product_status"
					value="중고(상급)" checked/> <span>중고(상급)&nbsp;&nbsp;  </span>
				</label> <label> <input type="radio" name="product_status"
					value="중고(하급)" /> <span>중고(하급)&nbsp;&nbsp;  </span>
				</label> <label> <input type="radio" name="product_status"
					value="미개봉" /> <span>미개봉</span>
				</label>
				</c:when>
				<c:otherwise>
					<c:choose>
						<c:when test="${jungGoNoh.product_status == '중고(하급)'}">
							<label> <input type="radio" name="product_status"
								value="중고(상급)"/> <span>중고(상급)&nbsp;&nbsp;  </span>
							</label> <label> <input type="radio" name="product_status"
								value="중고(하급)" checked/> <span>중고(하급)&nbsp;&nbsp;  </span>
							</label> <label> <input type="radio" name="product_status"
								value="미개봉" /> <span>미개봉</span>
							</label>
						</c:when>
						<c:otherwise>
							<label> <input type="radio" name="product_status"
								value="중고(상급)" /> <span>중고(상급)&nbsp;&nbsp;  </span>
							</label> <label> <input type="radio" name="product_status"
								value="중고(하급)" /> <span>중고(하급)&nbsp;&nbsp;  </span>
							</label> <label> <input type="radio" name="product_status"
								value="미개봉" checked/> <span>미개봉</span>
							</label>
						</c:otherwise>
					</c:choose>
				</c:otherwise>
			</c:choose>
			</div>
			<p class="duplication_warning">중복 선택 불가</p>
		</div>
	</div>
	<div class="sixthContainner">
		<div class="sixth_title">사이즈, 브랜드</div>
		<div class="sixth_content">
			<div class="size_box">
				<label class="size_label"> <span>사이즈</span> 
				<input type="text" class="size" name="product_size" value="${jungGoNoh.product_size}" required="required" onfocus="this.select()" />
				</label>
				<button type="button" class="sizeTableBtn"
					onclick="window.open('${pageContext.request.contextPath}/resources/img/junggo/sizeTable.png','사이즈 표','width=502,height=500,location=no,status=no,scrollbars=yes');">사이즈표</button>
			</div>
			<div class="brand_box">
				<label class="brand_label"> <span>브랜드</span> 
				<input type="text" class="brand" name="product_brand" value="${jungGoNoh.product_brand}"/> 
<script type="text/javascript">
// 브랜드 선택
function sellectBrand(selBrand){
   $(".brand").val(selBrand);
}
</script>				
				<select name="inputBrand" id="inputBrand" onchange="sellectBrand(this.value)">
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
			<input type="text" class="total_fee" name="product_price" value="${jungGoNoh.product_price}" required="required" onfocus="this.select()" />&nbsp;원(₩)

		</div>
	</div>

	<div class="eighthContainner">
		<div class="eighth_title">상품설명</div>
		<div class="eighth_content">
			<textarea class="product_detail" name="product_info" rows="" cols="" required="required" onfocus="this.select()">${jungGoNoh.product_info}</textarea>
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
			
				<c:choose>
					<c:when test="${jungGoNoh.product_payment == '안전페이'}">
						<input type="checkbox" name="product_payment" checked="checked" value="안전페이" />&nbsp; 안전페이 가능
								&nbsp;&nbsp;&nbsp;&nbsp; 
						<input type="checkbox" name="product_payment"  value="직거래" />&nbsp; 직거래 가능
					</c:when>
					<c:when test="${jungGoNoh.product_payment == '직거래'}">
						<input type="checkbox" name="product_payment" value="안전페이" />&nbsp; 안전페이 가능
								&nbsp;&nbsp;&nbsp;&nbsp; 
						<input type="checkbox" name="product_payment" checked="checked" value="직거래" />&nbsp; 직거래 가능
					</c:when>
					<c:when test="${jungGoNoh.product_payment == '안전페이,직거래'}">
						<input type="checkbox" name="product_payment" checked="checked" value="안전페이" />&nbsp; 안전페이 가능
								&nbsp;&nbsp;&nbsp;&nbsp; 
						<input type="checkbox" name="product_payment" checked="checked" value="직거래" />&nbsp; 직거래 가능
					</c:when>
					<c:otherwise>
						<input type="checkbox" name="product_payment" value="안전페이" />&nbsp; 안전페이 가능
								&nbsp;&nbsp;&nbsp;&nbsp; 
						<input type="checkbox" name="product_payment" value="직거래" />&nbsp; 직거래 가능
					</c:otherwise>
				</c:choose>
			
			</div>
			<p class="duplication_Ok">중복 선택 가능</p>
		</div>
	</div>


	<div class="lastContainner">
		<input type="submit" class="register_btn" value="수정하기">
		<button type="button" class="back_btn" onclick="history.back()">돌아가기</button>
	</div>
</form>
</div>