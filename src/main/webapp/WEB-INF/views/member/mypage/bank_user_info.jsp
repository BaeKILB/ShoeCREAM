<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- 외부 CSS 파일 연결하기 -->
<link href="${pageContext.request.contextPath }/resources/css/default.css" rel="stylesheet" type="text/css">
</head>
<body>
	<%-- 세션 아이디가 없을 경우 "로그인 후 사용 가능합니다" 출력 후 로그인 페이지로 이동 --%>
	<%-- 아니면, 엑세스토큰이 없을 경우 "계좌 인증 후 사용 가능합니다" 출력 후 회원정보 페이지로 이동 --%>
	<c:choose>
		<c:when test="${empty sessionScope.sId }">
			<script>
				alert("로그인 후 사용 가능합니다");
				location.href = "./";
			</script>
		</c:when>
		<c:when test="${empty sessionScope.access_token }">
			<script>
				alert("계좌 인증 후 사용 가능합니다");
				location.href = "MemberInfo";
			</script>
		</c:when>
	</c:choose>
	<header>
	<!-- 헤더 시작 -->
	<jsp:include page="../../inc_ex/header.jsp" />
	</header>
	<article>
		<h1>핀테크 사용자 정보</h1>
		<h3>
			${userInfo.user_name } 고객님의 계좌목록 (일련번호 : ${userInfo.user_seq_no })
		</h3>
		<table border="1">
			<tr>
				<th>계좌별칭</th>
				<th>계좌번호</th> <%-- 일반 계좌번호 대신 마스킹 된 계좌번호(account_num_masked)만 사용 가능 --%>
				<th>은행명</th>
				<th>예금주명</th>
				<th>핀테크이용번호</th>
				<th></th>
			</tr>
			<%-- userInfo 객체의 res_list 객체 반복하여 BankAccountVO 객체에 접근하여 각 데이터 꺼내서 테이블 출력 --%>
			<c:forEach var="account" items="${userInfo.res_list }">
				<tr>
					<td>${account.account_alias }</td>
					<td>${account.account_num_masked }</td>
					<td>${account.bank_name }(${account.bank_code_std })</td>
					<td>${account.account_holder_name }</td>
					<td>${account.fintech_use_num }</td>
					<td>
						<%-- 2.3.1. 잔액조회 API 요청을 위한 폼 생성 --%>
						<form action="bankAccountDetail" method="post">
							<%-- hidden 타입으로 예금주명, 계좌번호(마스킹), 핀테크이용번호 전달 --%>
							<input type="hidden" name="user_name" value="${userInfo.user_name }">
							<input type="hidden" name="account_num_masked" value="${account.account_num_masked }">
							<input type="hidden" name="fintech_use_num" value="${account.fintech_use_num }">
							<input type="submit" value="상세조회">
						</form>
					</td>
				</tr>
			</c:forEach>
		</table>
	</article>
	
		<!-- 푸터 시작 -->
	<jsp:include page="../../inc_ex/footer.jsp" />
</body>
</html>















