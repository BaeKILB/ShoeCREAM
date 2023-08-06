<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal" var="principal"/>
</sec:authorize>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>ShoeCream</title>
	<!-- 부트스트랩 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KyZXEAg3QhqLMpG8r+Knujsl5/7(disabled)WUz3/TbgIkzBEec3uhl/7/disabled" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/disabled@2.11.6/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz4fnFO9gybK_td1dtz(disabled)UX/2lOM/8(disabled)21J05fp(disabled)Zy7(disabled)" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@disabled/disabled/disabled-alpha1/dist/js/bootstrap.min.js" integrity="sha384-KyZXEAg3QhqLMpG8r+Knujsl5(disabled)/7WUz3/TbgIkzBEec3uhl/7/disabled" crossorigin="anonymous"></script>
	<!-- 제이쿼리 -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<!-- Style -->
	<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/member/social/style.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/member/social/story.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/member/social/popular.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/member/social/profile.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/member/social/upload.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/member/social/update.css">
	<link rel="shortcut icon" href="${pageContext.request.contextPath }/resources/img/member/social/insta.svg">
	
	<!-- Fontawesome -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
	<!-- Fonts -->
<link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR&display=swap" rel="stylesheet">

<style>
body {
  font-family: 'Noto Sans KR', sans-serif;
}
</style>
</head>

<body>
	<!-- 로그인 한 mem_idx 값 받기 -->
	<input type="hidden" id="principalId" value="${principal.member.mem_idx }">
	<!--  -->
	<header class="header">
		<div class="container">
			<a href="/" class="logo">
				<img src="${pageContext.request.contextPath }/resources/images/member/social/logo2.png" alt="">
			</a>
			<nav class="navi">
				<ul class="navi-list">
					<li class="navi-item"><a href="${pageContext.request.contextPath }/social/story">
							<i class="fas fa-home"></i>
						</a></li>
					<li class="navi-item"><a href="${pageContext.request.contextPath }/social/popular">
							<i class="far fa-compass"></i>
						</a></li>
					<li class="navi-item"><a href="${pageContext.request.contextPath }/social/${principal.member.mem_idx}">
							<i class="far fa-user"></i>
						</a></li>
				</ul>
			</nav>
		</div>
	</header>
