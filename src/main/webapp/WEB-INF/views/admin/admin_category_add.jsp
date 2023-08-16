 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>categorySetup</title>
    
	<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/common/common.css">
   	<script	src="${pageContext.request.contextPath }/resources/js/common/product_register.js"></script>
    
	<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.0.js"></script>
  </head>
  <body>
<div id="main_cont">
<div class="total_container col-sm-12 col-lg-12">
<form action="adminCategoryAddPro" method="post" enctype="multipart/form-data">
	<input type="radio" class="btn-check" name="categoryCheck" id="option1" value="0"  checked="checked">
	<label class="btn btn-outline-light" for="option1">대분류</label>
	
	<input type="radio" class="btn-check" name="categoryCheck" id="option2" value="1" >
	<label class="btn btn-outline-light" for="option2">중분류</label>
	

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
				<span>선택한 대분류 :</span>
				<span id="selectCategory">
					<span id="selectLcn"></span>
<!-- 					<span id="selectScn"></span> -->
				</span>
			</p>
		</div>
	</div>	
	<input type="hidden" name="lc_code">
	<input type="text" name="categoryName" placeholder="카테고리 명을 입력해주세요">

	<div class="lastContainner">
		<input type="submit" class="register_btn" value="등록">
	</div>
</form>
</div>
</div>
  
  <script type="text/javascript">

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

	           });            
	       })
	       .fail(function() {
	           
	       });
	   });
	});
  </script>
  </body>
</html>
