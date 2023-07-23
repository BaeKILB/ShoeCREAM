<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<c:set var="i" value="${param.mc_id }"></c:set>
	<div class="ct_sc_list ct_mc_${i } categoryList">
		<ul>
			<li>
				<a href="" class="ct_sc_item ct_mc_${i }" id="ct_sc_${1 + (5 * (i-1)) }">브랜드 상세1 ${1 + (5 * (i)) }</a>
			</li>
			<li>
				<a href="" class="ct_sc_item  ct_mc_${i }" id="ct_sc_${2 + (5 * (i-1)) }">브랜드 상세2 ${2 + (5 * (i)) }</a>
			</li>
			<li>
				<a href="" class="ct_sc_item  ct_mc_${i }" id="ct_sc_${3 + (5 * (i-1)) }">브랜드 상세3 ${3 + (5 * (i)) }</a>
			</li>
			<li>
				<a href="" class="ct_sc_item  ct_mc_${i }" id="ct_sc_${4 + (5 * (i-1)) }">브랜드 상세4 ${4 + (5 * (i)) }</a>
			</li>
			<li>
				<a href="" class="ct_sc_item  ct_mc_${i }" id="ct_sc_${5 + (5 * (i-1)) }">브랜드 상세5 ${5 + (5 * (i)) }</a>
			</li>
		</ul>
	</div>
</body>
</html>