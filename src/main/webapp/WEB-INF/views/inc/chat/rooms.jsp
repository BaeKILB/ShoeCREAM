<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>chat rooms</title>
<link href="${pageContext.request.contextPath }/resources/css/etc/bootstrap.min.css" rel="stylesheet">
<script src="${pageContext.request.contextPath }/resources/js/etc/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/etc/jquery-3.7.0.js"></script>
<link href="${pageContext.request.contextPath }/resources/css/inc/chat/chat_sidebars.css" rel="stylesheet">
<script src="${pageContext.request.contextPath }/resources/js/inc/chat/chat_sidebars.js"></script>
<link href="${pageContext.request.contextPath }/resources/css/inc/chat/rooms.css" rel="stylesheet">
<script>
            $(document).ready(function(){
				
                var createRoomMsg = "${createRoomMsg}";

                if(createRoomMsg != null && createRoomMsg != "")
                    alert(createRoomMsg );

//                 $(".btn-create").on("click", function (e){
//                     e.preventDefault();
//                     var name = $("input[name='name']").val();
//                     if(name == "")
//                         alert("Please write the name.")
//                     else
//                         $("form").submit();
//                 });

				
            });
            
            // 방 선택시 ajax 로 채팅 리스트 불러오기
            
            
</script>
</head>
<body>
	<h1>Chat rooms</h1>
<!--     <form action="room" method="post"> -->
<!--         <input type="text" name="name" class="form-control"> -->
<!--         <button class="btn btn-secondary">개설하기</button> -->
<!--     </form> -->
   	
   	<main class="side_chatroom_wrap">
	    <section class="chatroom_list d-flex flex-column align-items-stretch flex-shrink-0 bg-white" >
		    <a href="/" class="d-flex align-items-center flex-shrink-0 p-3 link-dark text-decoration-none border-bottom">
		      <svg class="bi me-2" width="30" height="24"><use xlink:href="#bootstrap"></use></svg>
		      <span class="fs-5 fw-semibold">chat group</span>
		    </a>
		    <div class="list-group list-group-flush border-bottom scrollarea">
	    	<c:if test="${!empty list}">
				<c:forEach var="chatRoom" items="${list }" varStatus="i">	
			      <a href="javaScript:getRoomAjax('${chatRoom.chat_room_idx }')" 
			      id="chat_room_${chatRoom.chat_room_idx }" 
			      class="list-group-item list-group-item-action py-3 lh-tight" aria-current="true">
			        <div class="d-flex w-100 align-items-center justify-content-between">
			          <strong class="mb-1">chat product idx : ${chatRoom.product_idx }</strong>
			          <small>
			          <c:choose>
			          	<c:when test="${chatRoom.mem_seller_idx eq myIdx }">
			          		
			          	</c:when>
			          	<c:when test="${chatRoom.mem_buyer_idx eq myIdx }">
			          	</c:when>
			          </c:choose>
			          </small> <!-- 오른쪽 아래 날짜  -->
			        </div>
			        <div class="col-10 mb-1 small">Some placeholder content in a paragraph below the heading and date.</div>
			      </a>			
				</c:forEach>
			</c:if>

		    </div><!-- list-group 끝 -->
	  	</section>

   	</main>
	<ul>
<%-- 	<c:if test="${!empty list}"> --%>
<%-- 		<c:forEach var="chatRoom" items="${list }">	 --%>
<!-- 			<li> -->
<%-- 				<a href="room?chat_room_idx=${chatRoom.chat_room_idx }">${chatRoom.room_title }</a> --%>
<!-- 			</li> -->
<%-- 		</c:forEach> --%>
<%-- 	</c:if> --%>
	</ul>
</body>
</html>