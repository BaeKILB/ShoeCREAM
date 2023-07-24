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
	<h1>경매기록 페이지</h1>
	<!-- 보여주기만 하면 된다 -->
	<table border="1">
			<tr>
				<th>입찰자 ID</th>
				<th>입찰일자</th>
				<th>입찰가격</th>
				<th>수량</th>
			</tr>
		<!-- DB에서 정보 불러와서 테이블에 쌓는거  -->
<%-- 		<c:forEach var="member" items="${memberList }"> --%>
<!-- 			<tr> -->
<%-- 				<td>${member.idx }</td> --%>
<%-- 				<td>${member.name }</td> --%>
<%-- 				<td>${member.id }</td> --%>
<%-- 				<td>${member.email }</td> --%>
<!-- 			</tr> -->
<%-- 		</c:forEach> --%>
		
	</table>
</body>
</html>