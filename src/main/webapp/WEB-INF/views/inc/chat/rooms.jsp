<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
   <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
   	
   	<main class="side_chatroom_wrap container">
	    <section class="chatroom_list row d-flex flex-column align-items-stretch flex-shrink-0 bg-white" >
		    <!-- 채팅방 항목 -->
		    <div class="col-6">
			    <div class="d-flex align-items-center flex-shrink-0 p-3 link-dark text-decoration-none border-bottom">
<!-- 			      <svg class="bi me-2" width="30" height="24"><use xlink:href="#bootstrap"></use></svg> -->
			      <span class="fs-5 fw-semibold">chat group</span>
			    </div>
			    <div class="list-group list-group-flush border-bottom scrollarea">
		    	<c:if test="${!empty list}">
					<c:forEach var="chatRoom" items="${list }" varStatus="i">		


				      <a href="javaScript:getRoomAjax('${chatRoom.chat_room_idx }')" 
				      id="chat_room_${chatRoom.chat_room_idx }" 
				      
				      
    			       	<c:choose>
				          	<c:when test="${chatRoom.mem_seller_idx eq myIdx }">
				          		class="list-group-item list-group-item-action py-3 lh-tight chatSeller" 
				          	</c:when>
				          	<c:when test="${chatRoom.mem_buyer_idx eq myIdx }">
				          		class="list-group-item list-group-item-action py-3 lh-tight chatBuyer" 
				          	</c:when>	
				          	<c:otherwise>
				          		class="list-group-item list-group-item-action py-3 lh-tight" 
				          	</c:otherwise>
			          	</c:choose>				      
				      
				      aria-current="true">
				        <div class="d-flex w-100 align-items-center justify-content-between">
				        
				          <strong id="chat_room_title_${chatRoom.chat_room_idx }" 
				          class="mb-1">${chatRoom.product_title }</strong>
				          <small>
				          	${chatRoom.product_price } 원
				          </small> <!-- 오른쪽 아래 날짜  -->
				        </div>
				        <div class="col-10 mb-1 small">
				        <c:choose>
						        <c:when test="${fn:length(chatRoom.product_info) gt 26}">
							        <c:out value="${fn:substring(chatRoom.product_info, 0, 25)}">...
							        </c:out>
						        </c:when>
						        <c:otherwise>
							        <c:out value="${chatRoom.product_info}">
							        </c:out>
						        </c:otherwise>
						</c:choose>
				        </div>
				      </a>	
				      		
					</c:forEach>
				</c:if>
					
			    </div><!-- list-group 끝 -->
		    </div> <!-- 채팅방 항목 끝 -->
		    
		    
		    <!-- 채팅 메시지 항목 -->
		    <div class="col-6 chat_msg_warp">
		    	<div class="product_info_wrap">
		    	</div>
		    	<div class="chat_member">
		    	</div>
		    	
		    	<div id="msgArea">
		    	
		    	</div>
		    </div>
	  	</section>
   	</main>
	<script src="${pageContext.request.contextPath }/resources/js/inc/chat/sockjs.min.js"></script>
	<script src="${pageContext.request.contextPath }/resources/js/inc/chat/stomp.min.js"></script>
	<script src="${pageContext.request.contextPath }/resources/js/inc/chat/chatMsgArea.js"></script>
</body>
</html>