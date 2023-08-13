<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath }/resources/css/admin/common.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/admin/adminBoard.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/admin/adminCream.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<style>
	.image_box {
    display: flex;
    flex-wrap: wrap;
}
.image_box > div:first-child {
    width: 150px;
    height: 150px;
    position: relative;
    border: 1px solid rgb(230, 229, 239);
    background: rgb(250, 250, 253);
    display: flex;
    -webkit-box-align: center;
    align-items: center;
    -webkit-box-pack: center;
    justify-content: center;
    flex-direction: column;
    color: rgb(155, 153, 169);
    font-size: 1rem;
    margin-right: 1rem;
}
.image_box > div:first-child::before {
    content: "";
    background-position: center center;
    background-repeat: no-repeat;
    background-size: cover;
    width: 2rem;
    height: 2rem;
    background-image: url("../../img/common/thunder_emptyImage.svg");
    margin-bottom: 1rem;
}
.image_box > div > input {
    width: 100%;
    height: 100%;
    position: absolute;
    top: 0px;
    left: 0px;
    opacity: 0;
    cursor: pointer;
    font-size: 0px;
}

.imageView {
	width: 175px;
	height: 175px; 
}

.hidden {
	display: none;
}
</style>
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
//추가된 이미지 삭제
const imgDelete = (currentId) => {
	$("button[value="+currentId+"]").remove();
	$("#"+currentId).removeClass("hidden").val('');	
	count--;
	if(count < 4) {
		$(".image_box").removeClass("hidden");
	};
};
//이미지 등록시 사진출력
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
</script>
</head>
<body>
	<aside>
		<jsp:include page="inc/sidebar.jsp" ></jsp:include>
	</aside>
	<section id="admin_cont">
		<h1 class="admin_tit">크림 상품 수정</h1>
		<hr class="tit_line">
		<div class="board_cont">	
			<div class="board_list_wrap">
				<form action="CreamModifyPro" method="post" enctype="multipart/form-data">
					<input type="hidden" name="cream_idx" value=${cream.cream_idx }>
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
						    	<c:if test="${cream.image1 != '' }">
							    	<button type="button" onclick='imgDelete(this.value)' value="image1">
							    		<img class="imageView" src="${pageContext.request.contextPath }${auction.image_path }/${auction.image1 }">
							    	</button>
						    	</c:if>
						    	<c:if test="${cream.image2 != '' }">
							    	<button type="button" onclick='imgDelete(this.value)' value="image2">
							    		<img class="imageView" src="${pageContext.request.contextPath }${auction.image_path }/${auction.image2 }">
							    	</button>
						    	</c:if>
						    	<c:if test="${cream.image3 != '' }">
							    	<button type="button" onclick='imgDelete(this.value)' value="image3">
							    		<img class="imageView" src="${pageContext.request.contextPath }${auction.image_path }/${auction.image3 }">
							    	</button>
						    	</c:if>
						    	<c:if test="${cream.image4 != '' }">
							    	<button type="button" onclick='imgDelete(this.value)' value="image4">
							    		<img class="imageView" src="${pageContext.request.contextPath }${auction.image_path }/${auction.image4 }">
							    	</button>
						    	</c:if>
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
							<input type="text" class="product_name" name="cream_title" placeholder="품목을 입력해주세요." value="${cream.cream_title }"/>
						</div>
					</div>
					
					<table border="1">
				    <thead>
				        <tr>
				            <th>사이즈</th>
				            <th>가격</th>
				        </tr>
				    </thead>
				    <tbody>
				        <c:forEach begin="220" end="310" step="5" varStatus="status">
				          <tr>
				              <td>${status.index}</td>
				              <td><input type="number" name="size${status.index}" ></td>
				           </tr>
				        </c:forEach>
				        	
				    </tbody>
				</table>
				
					
					<div class="ninthContainner">
						<div class="ninth_title">상품설명</div>
						<div class="ninth_content">
							<textarea class="product_detail" name="cream_content"  >${cream.cream_content }</textarea>
						</div>
					</div>
				
					<div class="lastContainner">
						<button type="submit" class="register_btn">등록하기</button>
						<button type="button" class="back_btn" onclick="location.href='./'">돌아가기</button>
					</div>
				</form>
				
				
				
			</div>
		</div>
	</section>
	<script type="text/javascript">
		$(document).ready(function() {
			$('.cont_li_wrap.creamList').show();
			$('.cont_item_list.creamIns').addClass('active');
		});
	    $(document).on('click', '.toggle_wrap', function() {
	    	if($('#admin_cont').css('margin-left') === '0px') {
	    		$('#admin_cont').show().animate({
					marginLeft : '15.625rem'
				}, 200);
	    	} else {
	    		$('#admin_cont').show().animate({
					marginLeft : '0px'
				}, 200);
	    	}
	    });
	</script>
</body>
</html>