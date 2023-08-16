<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../../inc_ex/header.jsp"%>
<%-- <%@ include file="../layout/header.jsp"%> --%>
<!DOCTYPE html>
<html lang="en">
<!-- 원본 파일 이름 member_update -->
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>마이페이지</title>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/member/mem_page/profile.css">

<link href="${pageContext.request.contextPath }/resources/css/member/common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/resources/css/member/mem_page/mem_info_update.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/resources/css/inc/top.css" rel="styleSheet">
<link href="${pageContext.request.contextPath }/resources/css/inc/footer.css" rel="styleSheet">

<link href="${pageContext.request.contextPath }/resources/css/etc/bootstrap.min.css" rel="stylesheet">

<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<!-- Fontawesome -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
<!-- Fonts -->
<link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@100;200;300;400;500;600;700&display=swap" rel="stylesheet">
<style>
.profile_thumb img.thumb_img {
  border-radius: 50%;
  object-fit: cover;
  width: 100px;
  height: 100px;
}
</style>
<script>
     function handleImageChange(e) {
    	 const imageFile = e.target.files[0];
         if (imageFile) {
           const reader = new FileReader();
           reader.onload = function(event) {
             const imgElement = document.querySelector(".thumb_img");
             imgElement.src = event.target.result;
           }
           reader.readAsDataURL(imageFile);
         }
     }
 </script>
</head>
<body>
	<nav>
		<jsp:include page="../../inc_ex/header.jsp" />
	</nav>
	<section id="main_cont">
		<form action="${pageContext.request.contextPath }/ProfileUpdatePro" method="post" name="fr" enctype="multipart/form-data" >
			<!--    <form id="memberUpdate" name="fr"> -->
			<section id="sec_con">
				<!--       <h1 class="con_title">내 정보 수정</h1> -->
				<div class="inq_container">
					<jsp:include page="../../inc_ex/mem_sidebar.jsp"></jsp:include>
	
					<div class="member-update-cont">
						<!--프로필 섹션-->
						<ul>
	<!-- <form action="ProfileImgePro" method="post" id="ProfileImage" name="ProfileImage" enctype="multipart/form-data"> -->
							    <div class="container">
							        <div class="row">
							            <div class="col-md-12">
							                <div class="d-flex my-3" >
							                    <div class="col-md-2">
							                        <div class="profile_thumb">
	<!-- 						                        <input type="file" id="profileImageFile" onchange="submitForm()" hidden> -->
							                
							                            <input type="file" id="profileImageFile" name="file" accept="image/jpeg,image/png" hidden="hidden" onchange="handleImageChange(event)">
	<%-- 						                            <img src="${pageContext.request.contextPath }/social//upload/profile/${member.mem_profileImageUrl }"  alt="사용자 이미지" class="thumb_img rounded-circle" onerror="this.src='https://kream.co.kr/_nuxt/img/blank_profile.4347742.png'" style="object-fit: cover; width: 100px; height: 100px;"> --%>
							                        		<img src="${pageContext.request.contextPath}/resources/upload/profile/${member.mem_profileImageUrl}" alt="사용자 이미지" class="thumb_img rounded-circle" onerror="this.src='https://kream.co.kr/_nuxt/img/blank_profile.4347742.png'" style="object-fit: cover; width: 100px; height: 100px;">
							                        	</div>
							                    </div>
							                    <div class="col-md-10 d-flex flex-column">
							                        <div class="profile_detail">
							                            <strong class="name">${member.mem_nickname }</strong>
							                        </div>
							                        <div class="profile_btn_box mt-auto">
							                            <button type="button" class="btn btn-outline-secondary btn-sm" onclick="document.getElementById('profileImageFile').click()">이미지 변경</button>
							                            <button type="button" class="btn btn-outline-secondary btn-sm">삭제</button>
							                        </div>
							                    </div>
							                </div>
							            </div>
							        </div>
							    </div>
	<!-- 						</form> -->
						</ul>
	<%-- 				<form action="${pageContext.request.contextPath }/ProfileUpdatePro" method="post" name="fr" enctype="multipart/form-data" onsubmit='return signUpCheck();'> --%>
						<ul>
							<li><label for="name">프로필 이름</label>
								<div class="form-input border-bottom">
									<input type="text" name="mem_nickname" class="form-control"
										value="${member.mem_nickname }">
								</div></li>
							<li><label for="name">소개</label>
								<div class="form-input border-bottom">
									<input type="text" name="mem_bio" id="name"
										class="form-control" value="${member.mem_bio }"
										>
								</div></li>
						</ul>
						<div class="btn_info_update cr">
							<!--                <input type="submit" alt="회원정보수정" value="수정하기" class="upd_btn" > -->
							<button type="submit" class="upd_btn">수정하기</button>
							<%-- 			<button type="button" onclick="update('${member.mem_idx}')" alt="회원정보수정" class="upd_btn">수정하기</button> --%>
						</div>
					</div>
				</div>
			</section>
		</form>
	</section>
	<footer>
		<jsp:include page="../../inc_ex/footer.jsp" />
	</footer>
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
<script>
    function submitForm() {
        const form = document.createElement("form");
        form.method = "POST";
        form.enctype = "multipart/form-data";
        form.action = "${pageContext.request.contextPath}/ProfileImgePro";

        const profileImageFile = document.getElementById("profileImageFile");
        form.appendChild(profileImageFile.cloneNode());

        document.body.appendChild(form);
        form.submit();
    }
</script>
<script src="${pageContext.request.contextPath }/resources/js/member/social/profile.js"></script>
</body>

</html>
