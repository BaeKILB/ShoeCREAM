<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

환불할거니?
제품명
결제금액
환불예정금액

컨펌창 예스 -환불
	노 - 창꺼짐 어디로보냄? 몰라
	
	${map }
<form action="creamRefundPro" method="post">

<input type="submit" value="환불하기">
</form>
</body>
</html>