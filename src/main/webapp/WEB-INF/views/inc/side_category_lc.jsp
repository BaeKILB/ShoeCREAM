<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- <!DOCTYPE html> -->
<!-- <html> -->
<!-- <head> -->
<!-- <meta charset="UTF-8"> -->
<!-- <title>Insert title here</title> -->
<!-- 	<style type="text/css"> -->
		
<!-- 	</style> -->
<!-- </head> -->
<!-- <body> -->
			<%-- include 로 param 사용시 map을 가져오는 방법 --%>
<%-- 			object's name = ${param.objName} --%>
<%-- 			object itself = ${requestScope[param.objName]} --%>
			${lc }
			<c:set var="lc" value="${requestScope[param.lc]}" scope="page" ></c:set>
			<c:set var="mc" value="${requestScope[param.mc]}" scope="page" ></c:set>
			<li class="ct_lc_item" >
			${lc }
			${mc }
			
<!-- 				<div class="ct_lc_item_btn"> -->
<%-- 					<a href=""  >${param.lc.lc_name }</a> --%>
<%-- 					<button id="ct_lc_${param.lc.lc_code }" class="ct_up_down_btn" onclick="allMcListHidden(this); categoryBtnDrop(this);"></button> --%>
<!-- 				</div> -->
				
<%-- 				<div class="ct_mc_list ct_lc_${param.lc.lc_code } categoryList" > --%>
<%-- 				<c:forEach var="mc_item" items="${param.mc }" varStatus="i">				 --%>
<%-- 					<jsp:include page="../inc/side_category_mc.jsp"> --%>
<%-- 						<jsp:param value="${param.lc.lc_code }" name="i"/> --%>
<%-- 						<jsp:param value="${mc_item }" name="mc"/> --%>
<%-- 					</jsp:include> --%>
<%-- 				</c:forEach> --%>
				</div>
			</li>
<!-- 			<li class="ct_lc_item"> -->
<!-- 				<div class="ct_lc_item_btn"> -->
<!-- 					<a href=""  id="ct_lc_2">운동화</a> -->
<!-- 					<button id="ct_lc_2" class="ct_up_down_btn" onclick="allMcListHidden(this); categoryBtnDrop(this);"></button> -->
<!-- 				</div> -->
<%-- 				<jsp:include page="../inc/side_category_mc.jsp"> --%>
<%-- 					<jsp:param value="2" name="lc_id"/> --%>
<%-- 				</jsp:include> --%>
<!-- 			</li> -->
<!-- 			<li class="ct_lc_item"> -->
<!-- 				<div class="ct_lc_item_btn"> -->
<!-- 					<a href=""  id="ct_lc_3">캐주얼</a> -->
<!-- 					<button id="ct_lc_3" class="ct_up_down_btn" onclick="allMcListHidden(this); categoryBtnDrop(this);"></button> -->
<!-- 				</div> -->
<%-- 				<jsp:include page="../inc/side_category_mc.jsp"> --%>
<%-- 					<jsp:param value="3" name="lc_id"/> --%>
<%-- 				</jsp:include> --%>
<!-- 			</li> -->
<!-- 			<li class="ct_lc_item"> -->
<!-- 				<div class="ct_lc_item_btn"> -->
<!-- 					<a href=""  id="ct_lc_4">남성단화</a> -->
<!-- 					<button id="ct_lc_4" class="ct_up_down_btn" onclick="allMcListHidden(this); categoryBtnDrop(this);"></button> -->
<!-- 				</div>	 -->
<%-- 				<jsp:include page="../inc/side_category_mc.jsp"> --%>
<%-- 					<jsp:param value="4" name="lc_id"/> --%>
<%-- 				</jsp:include> --%>
<!-- 			</li> -->
<!-- 			<li class="ct_lc_item"> -->
<!-- 				<div class="ct_lc_item_btn"> -->
<!-- 					<a href=""  id="ct_lc_5">여성단화</a> -->
<!-- 					<button id="ct_lc_5" class="ct_up_down_btn" onclick="allMcListHidden(this); categoryBtnDrop(this);"></button> -->
<!-- 				</div>	 -->
<%-- 				<jsp:include page="../inc/side_category_mc.jsp"> --%>
<%-- 					<jsp:param value="5" name="lc_id"/> --%>
<%-- 				</jsp:include> --%>
<!-- 			</li> -->
	
<!-- </body> -->
<!-- </html> -->