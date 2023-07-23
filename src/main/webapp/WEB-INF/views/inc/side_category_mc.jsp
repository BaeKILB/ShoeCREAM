<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- <!DOCTYPE html> -->
<!-- <html> -->
<!-- <head> -->
<!-- <meta charset="UTF-8"> -->
<!-- <title>Insert title here</title> -->
<!-- </head> -->
<!-- <body> -->
	<c:set var="i" value="${param.lc_id }"></c:set>
	<div class="ct_mc_list ct_lc_${i} categoryList" >
		<ul>
			<li class="ct_mc_item">
				<a href="" class="ct_lc_${i }" id="ct_mc_${1 + (5 * (i-1)) }">브랜드1 ${1 + (5 * (i-1)) }</a>
			
				<jsp:include page="../inc/side_category_sc.jsp">
					<jsp:param value="1" name="mc_id"/>
				</jsp:include>
			</li>
			<li class="ct_mc_item">
				<a href="" class="ct_lc_${i }" id="ct_mc_${2 + (5 * (i-1)) }">브랜드2 ${2 + (5 * (i-1)) }</a>
				<jsp:include page="../inc/side_category_sc.jsp">
					<jsp:param value="2" name="mc_id"/>
				</jsp:include>
			</li>
			<li class="ct_mc_item">
				<a href="" class="ct_lc_${i }" id="ct_mc_${3 + (5 * (i-1)) }">브랜드3 ${3 + (5 * (i-1)) }</a>
				<jsp:include page="../inc/side_category_sc.jsp">
					<jsp:param value="3" name="mc_id"/>
				</jsp:include>
			</li>
			<li class="ct_mc_item">
				<a href="" class="ct_lc_${i }" id="ct_mc_${4 + (5 * (i-1)) }">브랜드4 ${4 + (5 * (i-1)) }</a>
				<jsp:include page="../inc/side_category_sc.jsp">
					<jsp:param value="4" name="mc_id"/>
				</jsp:include>
			</li>
			<li class="ct_mc_item">
				<a href="" class="ct_lc_${i }" id="ct_mc_${5 + (5 * (i-1)) }">브랜드5 ${5 + (5 * (i-1)) }</a>
				<jsp:include page="../inc/side_category_sc.jsp">
					<jsp:param value="5" name="mc_id"/>
				</jsp:include>
			</li>
		</ul>
	</div>
<!-- </body> -->
<!-- </html> -->