<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../layout/header.jsp"%>
<!DOCTYPE html>
<html lang="en">
<!-- 원본 파일 이름 member_update -->
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>마이페이지</title>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/member/social/update.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/member/social/upload.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/member/mem_page/profile.css">

<link href="${pageContext.request.contextPath }/resources/css/member/common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/resources/css/member/mem_page/mem_info_update.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/resources/css/inc/top.css" rel="styleSheet">
<link href="${pageContext.request.contextPath }/resources/css/inc/footer.css" rel="styleSheet">

<!--    <script src="http://code.jquery.com/jquery-latest.min.js"></script> -->

<script src="${pageContext.request.contextPath }/resources/js/member/login/signup.js"></script>

<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<!-- Fontawesome -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
<!-- Fonts -->
<link
	href="https://fonts.googleapis.com/css2?family=Montserrat:wght@100;200;300;400;500;600;700&display=swap"
	rel="stylesheet">

</head>
<body>
	<!--    <header> -->
	<jsp:include page="../../inc_ex/header.jsp" />
	<!--    </header> -->

<%-- 	<form action="${pageContext.request.contextPath }/ProfileUpdatePro" method="post" name="fr" enctype="multipart/form-data" onsubmit='return signUpCheck();'> --%>
		<!--    <form id="memberUpdate" name="fr"> -->
		<section id="sec_con">
			<!--       <h1 class="con_title">내 정보 수정</h1> -->
			<div class="inq_container">
				<jsp:include page="../../inc_ex/mem_sidebar.jsp"></jsp:include>

				<div class="member-update-cont">
					<!--프로필 섹션-->
					<section class="profile">
						<!--유저정보 컨테이너-->
						<div class="profileContainer">

							<!--유저이미지-->
							<div class="profile-left">
								<div class="profile-img-wrap story-border"
									onclick="popup('.modal-image')">
									
<!-- 									<form id="userProfileImageForm"> -->
<!-- 										<input type="file" name="profileImageFile" -->
<!-- 											style="display: none;" id="userProfileImageInput" /> -->
<!-- 									</form> -->

									<img class="profile-image" src="#"
										onerror="this.src='${pageContext.request.contextPath }/resources/img/member/social/person3.jpg'"
										id="userProfileImage" />
								</div>
							</div>
							<!--유저이미지end-->

							<!--유저정보 및 사진등록 구독하기-->
							<div class="profile-right">
								<div class="name-group">
									<%-- 									<h2>${dto.member.mem_nickname}</h2> --%>
									<h4>${member.mem_nickname }</h4>
								</div>

								<div class="subscribe">
									<ul>
<!-- 									<form id="userProfileImageForm"> -->
<!-- 										<input type="file" name="profileImageFile" -->
<!-- 											style="display: none;" id="userProfileImageInput" /> -->
<!-- 									</form> -->
<!-- 										<button type="file" name="file" class="cta" onclick="popup('.modal-image')">이미지 변경</button> -->
										<button type="file" name="profileImageFile" class="cta" id="userProfileImageInput" onclick="popup('.modal-image')">이미지 변경</button>
										<button class="cta" onclick="location.href='${pageContext.request.contextPath }/image/upload'">삭제</button>
									</ul>
								</div>

<!-- 								<div class="state"> -->
<%-- 									<h4>${member.mem_bio }</h4> --%>
<!-- 								</div> -->
							</div>
							<!--유저정보 및 사진등록 구독하기-->

						</div>
					</section>
<%-- 				<form action="${pageContext.request.contextPath }/ProfileUpdatePro" method="post" name="fr" enctype="multipart/form-data" onsubmit='return signUpCheck();'> --%>
					<ul>
						<li><label for="name">프로필 이름</label>
							<div class="form-input">
								<input type="text" name="mem_nickname" class="form-control"
									value="${member.mem_nickname }">
							</div></li>
						<li><label for="name">소개</label>
							<div class="form-input">
								<input type="text" name="mem_bio" id="name"
									class="form-control" value="${member.mem_bio }"
									>
							</div></li>
					</ul>
					<div class="btn_info_update cr">
						<!--                <input type="submit" alt="회원정보수정" value="수정하기" class="upd_btn" > -->
						<button class="upd_btn">수정하기</button>
						<%-- 			<button type="button" onclick="update('${member.mem_idx}')" alt="회원정보수정" class="upd_btn">수정하기</button> --%>
					</div>
				</div>
			</div>
		</section>
	</form>
	<!--    <footer> -->
	<%--       <jsp:include page="../../../inc/footer.jsp"></jsp:include> --%>
	<!--    </footer> -->
	<!-- 	<script type="text/javascript"> -->

	<!-- // 	function signUpCheck() { -->

	<!-- // 		let password = document.getElementById("mem_passwd").value -->
	<!-- // 	    let passwordCheck = document.getElementById("passwordCheck").value -->

	<!-- // 	    if(password != null && passwordCheck != null && password != "" && passwordCheck != "" ){ -->
	<!-- // 		    if (!validatePassword(password) || !validatePassword(passwordCheck) ) { -->
	<!-- // 		      alert('영문,숫자,특수문자 포함 8~20글자 이상 입력 해주세요.'); -->
	<!-- // 		      return false; -->
	<!-- // 		    }	    	 -->
	<!-- // 	    } -->
	<!-- // 		return true; -->
	<!-- // 	}   -->
	<!-- 	</script> -->
<!--프로필사진 바꾸기 모달-->
<div class="modal-image" onclick="modalImage()">
	<div class="modal">
		<p>프로필 사진 바꾸기</p>
		<button onclick="profileImageUpload()">사진 업로드</button>
		<button onclick="closePopup('.modal-image')">취소</button>
	</div>
</div>

<!--프로필사진 바꾸기 모달end-->
<script src="${pageContext.request.contextPath }/resources/js/member/social/profile.js"></script>
</body>

</html>
