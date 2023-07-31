<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath }/resources/css/member/common.css"  rel="stylesheet">
<link href="${pageContext.request.contextPath }/resources/css/member/login/find_id_pw.css"  rel="stylesheet">
<link href="${pageContext.request.contextPath }/resources/css/inc/top.css" rel="styleSheet">
<link href="${pageContext.request.contextPath }/resources/css/inc/footer.css" rel="styleSheet">

<script src="${pageContext.request.contextPath }/resources/js/inc/jquery-3.7.0.js"></script>
</head>
<body>
<jsp:include page="../../inc_ex/header.jsp" />	
	
		<div  id="sec_con" class="w3-container-main inr">
			<div class="mem_wrap">			
				<h1 class="con_title">아이디 비밀번호 찾기</h1>
					<div class="find_wrap">
	
						<div class="fisrt_box">
							<h4>비밀번호 찾기 결과</h4>
						</div>
						<div class="id_result">
							<p id="result">회원님의 임시 비밀번호가<br><span class="result_c">${mem_id }</span><br>
							로 전송되었습니다.</p>
						</div>
						<div class="btn-wrap">
							<input type="button" class="move_main" value="로그인 페이지로 이동" onclick="location.href='${pageContext.request.contextPath }/login'">
						</div>
		
					</div>
			</div>
		</div>
</body>
</html>