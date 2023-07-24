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
	<div class="categoryTop ct_lc_list categoryList">
		<ul>
			<li class="ct_lc_item" >
				<div class="ct_lc_item_btn">
					<a href=""  >브랜드</a>
					<button id="ct_lc_1" class="ct_up_down_btn" onclick="allMcListHidden(this); categoryBtnDrop(this);"></button>
				</div>
			
				<jsp:include page="../inc/side_category_mc.jsp">
					<jsp:param value="1" name="lc_id"/>
				</jsp:include>
			</li>
			<li class="ct_lc_item">
				<div class="ct_lc_item_btn">
					<a href=""  id="ct_lc_2">운동화</a>
					<button id="ct_lc_2" class="ct_up_down_btn" onclick="allMcListHidden(this); categoryBtnDrop(this);"></button>
				</div>
				<jsp:include page="../inc/side_category_mc.jsp">
					<jsp:param value="2" name="lc_id"/>
				</jsp:include>
			</li>
			<li class="ct_lc_item">
				<div class="ct_lc_item_btn">
					<a href=""  id="ct_lc_3">캐주얼</a>
					<button id="ct_lc_3" class="ct_up_down_btn" onclick="allMcListHidden(this); categoryBtnDrop(this);"></button>
				</div>
				<jsp:include page="../inc/side_category_mc.jsp">
					<jsp:param value="3" name="lc_id"/>
				</jsp:include>
			</li>
			<li class="ct_lc_item">
				<div class="ct_lc_item_btn">
					<a href=""  id="ct_lc_4">남성단화</a>
					<button id="ct_lc_4" class="ct_up_down_btn" onclick="allMcListHidden(this); categoryBtnDrop(this);"></button>
				</div>	
				<jsp:include page="../inc/side_category_mc.jsp">
					<jsp:param value="4" name="lc_id"/>
				</jsp:include>
			</li>
			<li class="ct_lc_item">
				<div class="ct_lc_item_btn">
					<a href=""  id="ct_lc_5">여성단화</a>
					<button id="ct_lc_5" class="ct_up_down_btn" onclick="allMcListHidden(this); categoryBtnDrop(this);"></button>
				</div>	
				<jsp:include page="../inc/side_category_mc.jsp">
					<jsp:param value="5" name="lc_id"/>
				</jsp:include>
			</li>
		</ul>
	</div>
	
<!-- </body> -->
<!-- </html> -->