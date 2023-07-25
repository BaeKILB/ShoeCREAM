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
   	
   	<main class="side_chatroom_wrap">
	    <section class="chatroom_list d-flex flex-column align-items-stretch flex-shrink-0 bg-white" >
		    <a href="/" class="d-flex align-items-center flex-shrink-0 p-3 link-dark text-decoration-none border-bottom">
		      <svg class="bi me-2" width="30" height="24"><use xlink:href="#bootstrap"></use></svg>
		      <span class="fs-5 fw-semibold">chat group</span>
		    </a>
		    <div class="list-group list-group-flush border-bottom scrollarea">
		      <a href="#" class="list-group-item list-group-item-action active py-3 lh-tight" aria-current="true">
		        <div class="d-flex w-100 align-items-center justify-content-between">
		          <strong class="mb-1">List group item heading</strong>
		          <small>Wed</small>
		        </div>
		        <div class="col-10 mb-1 small">Some placeholder content in a paragraph below the heading and date.</div>
		      </a>
		      <a href="#" class="list-group-item list-group-item-action py-3 lh-tight">
		        <div class="d-flex w-100 align-items-center justify-content-between">
		          <strong class="mb-1">List group item heading</strong>
		          <small class="text-muted">Tues</small>
		        </div>
		        <div class="col-10 mb-1 small">Some placeholder content in a paragraph below the heading and date.</div>
		      </a>
		      <a href="#" class="list-group-item list-group-item-action py-3 lh-tight">
		        <div class="d-flex w-100 align-items-center justify-content-between">
		          <strong class="mb-1">List group item heading</strong>
		          <small class="text-muted">Mon</small>
		        </div>
		        <div class="col-10 mb-1 small">Some placeholder content in a paragraph below the heading and date.</div>
		      </a>
		
		      <a href="#" class="list-group-item list-group-item-action py-3 lh-tight" aria-current="true">
		        <div class="d-flex w-100 align-items-center justify-content-between">
		          <strong class="mb-1">List group item heading</strong>
		          <small class="text-muted">Wed</small>
		        </div>
		        <div class="col-10 mb-1 small">Some placeholder content in a paragraph below the heading and date.</div>
		      </a>
		      <a href="#" class="list-group-item list-group-item-action py-3 lh-tight">
		        <div class="d-flex w-100 align-items-center justify-content-between">
		          <strong class="mb-1">List group item heading</strong>
		          <small class="text-muted">Tues</small>
		        </div>
		        <div class="col-10 mb-1 small">Some placeholder content in a paragraph below the heading and date.</div>
		      </a>
		      <a href="#" class="list-group-item list-group-item-action py-3 lh-tight">
		        <div class="d-flex w-100 align-items-center justify-content-between">
		          <strong class="mb-1">List group item heading</strong>
		          <small class="text-muted">Mon</small>
		        </div>
		        <div class="col-10 mb-1 small">Some placeholder content in a paragraph below the heading and date.</div>
		      </a>
		      <a href="#" class="list-group-item list-group-item-action py-3 lh-tight" aria-current="true">
		        <div class="d-flex w-100 align-items-center justify-content-between">
		          <strong class="mb-1">List group item heading</strong>
		          <small class="text-muted">Wed</small>
		        </div>
		        <div class="col-10 mb-1 small">Some placeholder content in a paragraph below the heading and date.</div>
		      </a>
		      <a href="#" class="list-group-item list-group-item-action py-3 lh-tight">
		        <div class="d-flex w-100 align-items-center justify-content-between">
		          <strong class="mb-1">List group item heading</strong>
		          <small class="text-muted">Tues</small>
		        </div>
		        <div class="col-10 mb-1 small">Some placeholder content in a paragraph below the heading and date.</div>
		      </a>
		      <a href="#" class="list-group-item list-group-item-action py-3 lh-tight">
		        <div class="d-flex w-100 align-items-center justify-content-between">
		          <strong class="mb-1">List group item heading</strong>
		          <small class="text-muted">Mon</small>
		        </div>
		        <div class="col-10 mb-1 small">Some placeholder content in a paragraph below the heading and date.</div>
		      </a>
		      <a href="#" class="list-group-item list-group-item-action py-3 lh-tight" aria-current="true">
		        <div class="d-flex w-100 align-items-center justify-content-between">
		          <strong class="mb-1">List group item heading</strong>
		          <small class="text-muted">Wed</small>
		        </div>
		        <div class="col-10 mb-1 small">Some placeholder content in a paragraph below the heading and date.</div>
		      </a>
		      <a href="#" class="list-group-item list-group-item-action py-3 lh-tight">
		        <div class="d-flex w-100 align-items-center justify-content-between">
		          <strong class="mb-1">List group item heading</strong>
		          <small class="text-muted">Tues</small>
		        </div>
		        <div class="col-10 mb-1 small">Some placeholder content in a paragraph below the heading and date.</div>
		      </a>
		      <a href="#" class="list-group-item list-group-item-action py-3 lh-tight">
		        <div class="d-flex w-100 align-items-center justify-content-between">
		          <strong class="mb-1">List group item heading</strong>
		          <small class="text-muted">Mon</small>
		        </div>
		        <div class="col-10 mb-1 small">Some placeholder content in a paragraph below the heading and date.</div>
		      </a>
		    </div>
	  	</section>

   	</main>
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