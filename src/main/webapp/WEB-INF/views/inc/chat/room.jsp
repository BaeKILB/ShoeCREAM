<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ChatRoom : ${room.room_title}</title>

<style type="text/css">
#msgArea {
	width: 500px;
	height: 700px;
	overflow: auto;
}
</style>
<link
	href="${pageContext.request.contextPath }/resources/css/etc/bootstrap.min.css"
	rel="stylesheet">
<script
	src="${pageContext.request.contextPath }/resources/js/etc/bootstrap.bundle.min.js"></script>
<script
	src="${pageContext.request.contextPath }/resources/js/etc/jquery-3.7.0.js"></script>
<script
	src="${pageContext.request.contextPath }/resources/js/inc/chat/sockjs.min.js"></script>
<script
	src="${pageContext.request.contextPath }/resources/js/inc/chat/stomp.min.js"></script>

</head>
<body>
	<div class="container">
		<div class="col-6">
			<h1></h1>
		</div>
		<div>
			<div id="msgArea" class="col">
<%-- 				<c:if test="${!empty chatList }"> --%>
<%-- 					<c:forEach var="chat" items="${chatList }"> --%>
<%-- 						<c:choose> --%>
<%-- 							<c:when test="${chat.chat_writer eq sessionScope.sId}"> --%>
<!-- 								<div class='col-6'> -->
<!-- 									<div class='alert alert-secondary'> -->
<%-- 										<b>${chat.chat_writer} : ${chat.chat_content}</b> --%>
<!-- 									</div> -->
<!-- 								</div> -->
<%-- 							</c:when> --%>
<%-- 							<c:otherwise> --%>
<!-- 								<div class='col-6'> -->
<!-- 									<div class='alert alert-warning'> -->
<%-- 										<b>${chat.chat_writer} : ${chat.chat_content}</b> --%>
<!-- 									</div> -->
<!-- 								</div> -->
<%-- 							</c:otherwise> --%>
<%-- 						</c:choose> --%>
<%-- 					</c:forEach> --%>
<%-- 				</c:if> --%>
			</div>
			<div class="col-6">
				<div class="input-group mb-3">
					<input type="text" id="msg" class="form-control">
					<div class="input-group-append">
						<button class="btn btn-outline-secondary" type="button"
							id="button-send">전송</button>
					</div>
				</div>
			</div>
		</div>
		<div class="col-6"></div>
	</div>
	<script>
        </script>
</body>
</html>