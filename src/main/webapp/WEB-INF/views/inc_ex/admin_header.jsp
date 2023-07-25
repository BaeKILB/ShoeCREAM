<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>      
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>admin header</title>
</head>
<script type="text/javascript">
	function confirmLogout(){
		let result = confirm("로그아웃 하시겠습니까?");	
		return result;
	}
</script>
<body>

        <!--**********************************
            Header start
        ***********************************-->
        <div class="header">
            <div class="header-content">
                <nav class="navbar navbar-expand">
                    <div class="collapse navbar-collapse justify-content-between">
                        <div class="header-left">
						<!-- 검색 창 있던 자리 -->
	                        <a href="adminMain.ad" class="dropdown-item">
	                            <i class="icon-user"></i>
	                            <span class="ml-2">홈</span>
	                        </a>
                        </div>
                        	<c:choose>
                        		<c:when test="">
						           <a href="./page-login.html" class="dropdown-item">
                                      <i class="icon-key"></i>
                                      <span class="ml-2">로그인</span>
		                           </a>  
                        		</c:when>
                        		<c:otherwise>
						           <a href="adminLogout.ad" class="dropdown-item" onclick="return confirmLogout()">
                                      <i class="icon-key"></i>
                                      <span class="ml-2">로그아웃</span>
		                           </a>
                        		</c:otherwise>
                        	</c:choose>
                        <ul class="navbar-nav header-right">
                            <li class="nav-item dropdown notification_dropdown">
                                <a class="nav-link" href="#" role="button" data-toggle="dropdown">
                                    <i class="mdi mdi-bell"></i>
                                    <div class="pulse-css"></div>
                                </a>
                                <div class="dropdown-menu dropdown-menu-right">
                                    <ul class="list-unstyled">
                                 	<!-- 알람 내용 있던 자리 -->
                                    </ul>
                                    <a class="all-notification" href="#">알람 목록<i
                                            class="ti-arrow-right"></i></a>
                                </div>
                            </li>
                            <li class="nav-item dropdown header-profile">
                                <a class="nav-link" href="#" role="button" data-toggle="dropdown">
                                    <i class="mdi mdi-account"></i>
                                </a>
                                <div class="dropdown-menu dropdown-menu-right">
                                    <a href="./app-profile.html" class="dropdown-item">
                                        <i class="icon-user"></i>
                                        <span class="ml-2">Profile </span>
                                    </a>
                                    <a href="./email-inbox.html" class="dropdown-item">
                                        <i class="icon-envelope-open"></i>
                                        <span class="ml-2">Inbox </span>
                                    </a>
                                    <a href="./page-login.html" class="dropdown-item">
                                        <i class="icon-key"></i>
                                        <span class="ml-2">Logout </span>
                                    </a>
                                </div>
                            </li>
                        </ul>
                    </div>
                </nav>
            </div>
        </div>
        <!--**********************************
            Header end ti-comment-alt
        ***********************************-->
</body>
</html>