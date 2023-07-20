<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>chat rooms</title>
<link
	href="${pageContext.request.contextPath }/resources/css/etc/bootstrap.min.css"
	rel="stylesheet">
<script
	src="${pageContext.request.contextPath }/resources/js/etc/bootstrap.bundle.min.js"></script>
<script
	src="${pageContext.request.contextPath }/resources/js/etc/jquery-3.7.0.js"></script>
<script>
            $(document).ready(function(){

                var createRoomMsg = "${createRoomMsg}";

                if(createRoomMsg != null && createRoomMsg != "")
                    alert(createRoomMsg );

                $(".btn-create").on("click", function (e){
                    e.preventDefault();

                    var name = $("input[name='name']").val();

                    if(name == "")
                        alert("Please write the name.")
                    else
                        $("form").submit();
                });

            });
        </script>
</head>
<body>
	<h1>Chat rooms</h1>
    <form action="room" method="post">
        <input type="text" name="name" class="form-control">
        <button class="btn btn-secondary">개설하기</button>
    </form>
    

	<ul>
	<c:if test="${!empty list}">
		<c:forEach var="chatRoom" items="${list }">	
			<li>
				<a href="room?chat_room_idx=${chatRoom.chat_room_idx }">${chatRoom.room_title }</a>
			</li>
		</c:forEach>
	</c:if>
	</ul>
</body>
</html>