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
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/common/common.css">
<link href="${pageContext.request.contextPath }/resources/css/inc/chat/chat_sidebars.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/resources/css/inc/chat/rooms.css" rel="stylesheet">
	

<script src="${pageContext.request.contextPath }/resources/js/etc/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/etc/jquery-3.7.0.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/inc/chat/sockjs.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/inc/chat/stomp.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/inc/chat/chat_sidebars.js"></script>

</head>
<body>
	<nav>
		<jsp:include page="../../inc_ex/header.jsp" />
	</nav>
	<main id="main_cont">
	   	<section class="side_chatroom_wrap container">
		    <article class="chatroom_list row d-flex flex-column align-items-stretch flex-shrink-0 bg-white" >
			    <!-- 채팅방 항목 -->
			    <div class="col-md-4 col-lg-5 d-none d-md-block">
				    <div class="d-flex align-items-center flex-shrink-0 p-3 link-dark text-decoration-none border-bottom">
	<!-- 			      <svg class="bi me-2" width="30" height="24"><use xlink:href="#bootstrap"></use></svg> -->
				      <span class="fs-5 fw-semibold">1:1 대화</span>
				    </div>
				    <div class="list-group list-group-flush border-bottom scrollarea">
			    	<c:if test="${!empty list}">
						<c:forEach var="chatRoom" items="${list }" varStatus="i">		
	
	
					      <a href="chatRooms?chat_area=0&chat_room_idx=${chatRoom.chat_room_idx }" 
					      id="chat_room_${chatRoom.chat_room_idx }" class="list-group-item list-group-item-action py-3 lh-tight" aria-current="true">
					        <div class="d-flex align-items-center justify-content-between">
					       	<c:choose>
					          	<c:when test="${chatRoom.mem_seller_idx eq myIdx }">
					          		<div class="chatSeller">판매</div>
					          	</c:when>
					          	<c:when test="${chatRoom.mem_buyer_idx eq myIdx }">
					          		<div class="chatBuyer">구매</div>
					          	</c:when>	
					          	<c:otherwise>
					          		<div class="">일반</div>
					          	</c:otherwise>
				          	</c:choose>		
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
			    <div class="col-sm-12 col-md-8 col-lg-7 chat_msg_warp">
			    	<c:if test="${!empty room}">
			    		<article class="chat_msg_info_wrap ">
	
			    		</article>
			    	</c:if>
			    	<c:choose>
			    		<c:when test="${!empty room}">
			    			<div class="chatArea">		
								<div id="msgArea" >
									<c:if test="${!empty chatList }">
										<c:forEach var="chat" items="${chatList }">
											<c:choose>
												<c:when test="${chat.chat_msg_writer eq myIdx}">
													<div class='chat_msg_l'>
														<div class='alert alert-primary'>
															<b>${chat.mem_nickname} : ${chat.chat_msg_content}</b>
														</div>
													</div>
												</c:when>
												<c:otherwise>
													<div class='chat_msg_r'>
														<div class='alert alert-warning'>
															<b>${chat.mem_nickname} : ${chat.chat_msg_content}</b>
														</div>
													</div>
												</c:otherwise>
											</c:choose>
										</c:forEach>
									</c:if>
								</div>
								<div class="input-group mb-3">
									<input type="text" id="msg_input" class="form-control">
									<div class="input-group-append">
										<button class="btn btn-outline-secondary" type="button"
											id="button-send">전송</button>
									</div>
									<button id="chatHiddenBtn"></button>
									<input type="hidden" id="msghidden" >
								</div>
							</div>
			    		</c:when>
			    		<c:otherwise>
			    			<p>현재 참여하고있는 채팅방이 없습니다</p>
			    		</c:otherwise>
			    	</c:choose>
	
				</div>
			</article>
	   	</section>
   	</main>
   	<script type="text/javascript">
		let localURL = "${pageContext.request.contextPath}";
	</script>
   	
   	<%-- 채팅창 관련 js --%>
	<script src="${pageContext.request.contextPath }/resources/js/inc/chat/chatMsgArea.js"></script>
   	
	<c:if test="${!empty room}">
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
            let chat_room_idx = "${room.chat_room_idx}";
			let userId = "${sId}"
			let idx = "${idx}";
            console.log(roomName + ", " + chat_room_idx + ", " );

            let sockJs = new SockJS("stomp_chat");
            //1. SockJS를 내부에 들고있는 stomp를 내어줌
            let stomp = Stomp.over(sockJs);
			
            //2. connection이 맺어지면 실행
            stomp.connect({}, function (){
				
               //4. subscribe(path, callback)으로 메세지를 받을 수 있음
               stomp.subscribe("/topic/room" + chat_room_idx, function (chat) {
            	   
				console.log("STOMP Connection On")
				   let content = JSON.parse(chat.body);
					
				   let chat_writer = content.sId;
				   let chat_nicname = content.nickname;
				   let str = '';
				   
				   
				   
				   if(chat_writer === userId){
				       str = "<div class='chat_msg_l'>";
				       str += "<div class='alert alert-primary'>";
				       str += "<b>" + chat_nicname + " : " + content.chat_msg_content + "</b>";
				       str += "</div></div>";
				       $("#msgArea").append(str);
				   }
				   else{
				       str = "<div class='chat_msg_r'>";
				       str += "<div class='alert alert-warning'>";
				       str += "<b>" + chat_nicname + " : " + content.chat_msg_content + "</b>";
				       str += "</div></div>";
				       $("#msgArea").append(str);
				   }
					
					scrolDown();
					myLoad = false;
					
					
					// 만약 product_sell_status 가 담겨져서 오는지 확인하기
					if(content.product_sell_status != null
							|| content.product_sell_status != undefined){
						if(chat_writer != userId &&
								(content.isCancel != null
								|| content.isCancel != undefined)){
							
							window.open("payCancel?product_idx=${room.product_idx}&chat_area=" + getParams.get("chat_area")  + "&chat_room_idx=" + getParams.get("chat_room_idx")
									, "취소 상세", "width=500, height=6500, left=100, top=50");
						}				
						loadChatMsgBar();
					}
               },
               function(){console.log("연결 실패!")});

               //3. send(path, header, chat_msg_content)로 메세지를 보낼 수 있음
//                stomp.send('/pub/enter', {}, JSON.stringify({chat_room_idx: chat_room_idx, sId: userId}))
				
            });
			
            // 메시지 전송 stomp 함수
            const sendMsg = () => {
                let msg = document.getElementById("msg_input");

                console.log(userId + ":" + msg.value);
                stomp.send('/pub/message', {}, JSON.stringify({chat_room_idx: chat_room_idx, chat_msg_content: msg.value, chat_msg_writer : idx, sId: userId}));
                msg.value = '';
                myLoad = true;
            }
            
            // 메시지 전송 stomp 함수 (msghidden 으로 msg받기)
            const sendMsg2 = () => {

                let msg = document.getElementById("msghidden");
                
                console.log(userId + ":" + msg.value);
                stomp.send('/pub/message', {}, JSON.stringify({chat_room_idx: chat_room_idx, chat_msg_content: msg.value, chat_msg_writer : idx, sId: userId}));
                msg.value = '';
                myLoad = true;
            }
            
            $("#button-send").on("click", function(e){
            	sendMsg();
            });
            
            $("#chatHiddenBtn").on("click", function(e){
            	sendMsg2();
            });
            
            //엔터키 입력
            $("#msg_input").keyup(function(key){
            	if(key.keyCode == 13){
            		sendMsg();
            	}
            });
            
        });
        
        scrolDown();
        
		</script>
	</c:if>
		<!-- 풋터 시작 -->
	<footer>
		<jsp:include page="../../inc_ex/footer.jsp" />
	</footer>
</body>
</html>