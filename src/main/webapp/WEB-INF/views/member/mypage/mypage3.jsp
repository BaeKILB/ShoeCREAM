<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
   <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
   <%@ include file="../layout/header.jsp"%>
<!DOCTYPE html>
<html lang="en">
<!-- 원본 파일 이름 member_update -->
<head>
   <meta charset="UTF-8">
   <meta http-equiv="X-UA-Compatible" content="IE=edge">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <title>마이페이지</title>
   <link href="${pageContext.request.contextPath }/resources/css/member/common.css" rel="stylesheet">
   <link href="${pageContext.request.contextPath }/resources/css/member/mem_page/mem_info_update.css" rel="stylesheet">
   <link href="${pageContext.request.contextPath }/resources/css/inc/top.css" rel="styleSheet">
   <link href="${pageContext.request.contextPath }/resources/css/inc/footer.css" rel="styleSheet">
   <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/main_ex/market/common.css">
   
<!--    <script src="http://code.jquery.com/jquery-latest.min.js"></script> -->
   <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
   <script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>
<script type="text/javascript">
// $(function(){
//      const passWd = document.getElementById("mem_passwd");
//      const validateMessage = document.getElementById('passwordError');

//      passWd.addEventListener("input", function() {
//        const pass = passWd.value;
//        if (validateEmail(pass)) {
//          validateMessage.textContent = '';
//        } else {
//          validateMessage.textContent = '영문,숫자,특수문자 포함 8~20글자 이상 입력 해주세요.';
//        }
//      });
     
//      function validateEmail(pass) {
//        const re = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,20}$/;
//        return re.test(pass);
//      }
//    });
   
// //비밀번호 중복 확인검사 
// function validatePassword() {
//   var passwd = document.getElementById("mem_passwd").value;
//   var repeatPasswd = document.getElementById("passwordCheck").value;
//   var span = document.querySelector("#passwordCheckError");

//   if (passwd != repeatPasswd) {
//    span.innerHTML= '패스워드가 일치하지 않습니다.' 
   
//     return false;
//   }else{
//    span.innerHTML= '' 
   
//   return true;
// }

// }



</script>
<%-- <script src="${pageContext.request.contextPath }/resources/js/member/login/signup.js"></script> --%>
   
</head>


<body>
<!--    <header> -->
<%--       <jsp:include page="../../../inc/top1.jsp"></jsp:include> --%>
	<jsp:include page="../../inc_ex/header_social.jsp" />
<!--    </header> -->

   <form action="${pageContext.request.contextPath }/MemberUpdatePro" method="post" name="fr" onsubmit='return signUpCheck();'>
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
				<form id="userProfileImageForm">
					<input type="file" name="profileImageFile" style="display: none;"
						id="userProfileImageInput" />
				</form>

				<img class="profile-image" src="#"
					onerror="this.src='${pageContext.request.contextPath }/resources/img/member/social/person3.jpg'" id="userProfileImage" />
			</div>
		</div>
		<!--유저이미지end-->

		<!--유저정보 및 사진등록 구독하기-->
		<div class="profile-right">
			<div class="name-group">
				<h2>TeaSic</h2>

				<button class="cta" onclick="location.href='/image/upload'">사진등록</button>
				<button class="cta" onclick="toggleSubscribe(this)">구독하기</button>
				<button class="modi" onclick="popup('.modal-info')">
					<i class="fas fa-cog"></i>
				</button>
			</div>

			<div class="subscribe">
				<ul>
					<li><a href=""> 게시물<span>3</span>
					</a></li>
					<li><a href="javascript:subscribeInfoModalOpen();"> 구독정보<span>2</span>
					</a></li>
				</ul>
			</div>
<!-- 			<div class="state"> -->
<!-- 				<h4>소셜 프로필입니다.</h4> -->
<!-- 				<h4>죽겠습니다.</h4> -->
<!-- 			</div> -->
		</div>
		<!--유저정보 및 사진등록 구독하기-->

	</div>
</section>
         </div>
      </div>
   </section>
   </form>
<!--    <footer> -->
<%--       <jsp:include page="../../../inc/footer.jsp"></jsp:include> --%>
<!--    </footer> -->
	<script src="${pageContext.request.contextPath }/resources/js/member/mypage/update.js"></script>
	<script src="${pageContext.request.contextPath }/resources/js/member/social/profile.js"></script>
	
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
</body>

</html>