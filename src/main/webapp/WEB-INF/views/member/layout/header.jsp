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
	<link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@100;200;300;400;500;600;700&display=swap" rel="stylesheet">
</head>

<body>
	
	<header class="header">
		<div class="container">
			<a href="/" class="logo">
				<img src="${pageContext.request.contextPath }/resources/images/member/social/logo2.png" alt="">
			</a>
			<nav class="navi">
				<ul class="navi-list">
					<li class="navi-item"><a href="${pageContext.request.contextPath }/">
							<i class="fas fa-home"></i>
						</a></li>
					<li class="navi-item"><a href="/image/popular">
							<i class="far fa-compass"></i>
						</a></li>
					<li class="navi-item"><a href="${pageContext.request.contextPath }/social/1">
							<i class="far fa-user"></i>
						</a></li>
				</ul>
			</nav>
		</div>
	</header>
