<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ChatRoom : ${room.chat_room_idx}</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM"
	crossorigin="anonymous">
<style type="text/css">
#msgArea {
	width: 500px;
	height: 700px;
	overflow: auto;
}
</style>
<script src="https://code.jquery.com/jquery-3.7.0.js"
	integrity="sha256-JlqSTELeR4TLqP0OG9dxM7yDPqX1ox/HfgiSLBj8+kM="
	crossorigin="anonymous"></script>
	<script src="${pageContext.request.contextPath }/resources/js/inc/chat/sockjs.min.js"></script>
	<script src="${pageContext.request.contextPath }/resources/js/inc/chat/stomp.min.js"></script>

</head>
<body>
	<div class="container">
		<div class="col-6">
			<h1>${room.chat_room_idx}</h1>
		</div>
		<div>
			<div id="msgArea" class="col">
				<c:if test="${!empty chatList }">
					<c:forEach var="chat" items="${chatList }">
						<c:choose>
							<c:when test="${chat.chat_msg_writer eq sessionScope.sId}">
								<div class='col-6'>
									<div class='alert alert-secondary'>
										<b>${chat.chat_writer} : ${chat.chat_content}</b>
									</div>
								</div>
							</c:when>
							<c:otherwise>
								<div class='col-6'>
									<div class='alert alert-warning'>
										<b>${chat.mem_idx} : ${chat.chat_content}</b>
									</div>
								</div>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</c:if>
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
			//스크롤 자동 내리기
			function scrolDown() {
				let msgArea = document.querySelector("#msgArea");
				if(msgArea.scrollTop >
					msgArea.scrollHeight - msgArea.clientHeight - 200
					|| myLoad){					
					msgArea.scrollTop = msgArea.scrollHeight;
				}
			}
        	
			// 내가 메시지를 보내거나 해서 생기는 경우일때 체크
        	// 스크롤을 맨 아래로 내림
			let myLoad = true;
        	
            $(document).ready(function(){

            	
                let roomName = "${room.chat_room_idx}";
                let room_id = "${room.chat_room_idx}";
				let username = "${sessionScope.sId}";
				let idx = "${idx}";
                console.log("test" + roomName + ", " + room_id + ", " + username);

                let sockJs = new SockJS("stomp_chat");
                //1. SockJS를 내부에 들고있는 stomp를 내어줌
                let stomp = Stomp.over(sockJs);

                //2. connection이 맺어지면 실행
                stomp.connect({}, function (){

                   //4. subscribe(path, callback)으로 메세지를 받을 수 있음
                   stomp.subscribe("/topic/room" + room_id, function (chat) {
                	   
					console.log("STOMP Connection On")
					   let content = JSON.parse(chat.body);
					
					   let chat_writer = content.mem_idx;
					   let str = '';
					
					   if(chat_writer === idx){
					       str = "<div class='col-6'>";
					       str += "<div class='alert alert-secondary'>";
					       str += "<b>" + chat_writer + " : " + content.chat_msg_content + "</b>";
					       str += "</div></div>";
					       $("#msgArea").append(str);
					   }
					   else{
					       str = "<div class='col-6'>";
					       str += "<div class='alert alert-warning'>";
					       str += "<b>" + chat_writer + " : " + content.chat_msg_content + "</b>";
					       str += "</div></div>";
					       $("#msgArea").append(str);
					   }
						
						scrolDown();
						myLoad = false;
						
                   },
                   function(){console.log("연결 실패!")});

                   //3. send(path, header, chat_content)로 메세지를 보낼 수 있음
                   stomp.send('/pub/enter', {}, JSON.stringify({chat_room_idx: room_id, chat_msg_writer: idx ,sId: username}))
					
                });

                $("#button-send").on("click", function(e){
                    let msg = document.getElementById("msg");

                    console.log(username + ":" + msg.value);
                    stomp.send('/pub/message', {}, JSON.stringify({chat_room_idx: room_id, chat_msg_content: msg.value, chat_msg_writer: idx, sId: username}));
                    msg.value = '';
                    myLoad = true;
                });
                
            });
            
            scrolDown();
        </script>
</body>
</html>