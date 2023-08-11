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
<%-- <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/member/social/update.css"> --%>
<%-- <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/member/social/upload.css"> --%>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/member/mem_page/profile.css">

<link href="${pageContext.request.contextPath }/resources/css/member/common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/resources/css/member/mem_page/account.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/resources/css/inc/top.css" rel="styleSheet">
<link href="${pageContext.request.contextPath }/resources/css/inc/footer.css" rel="styleSheet">

<!--    <script src="http://code.jquery.com/jquery-latest.min.js"></script> -->

<%-- <script src="${pageContext.request.contextPath }/resources/js/member/login/signup.js"></script> --%>

<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<!-- Fontawesome -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
<!-- Fonts -->
<link
	href="https://fonts.googleapis.com/css2?family=Montserrat:wght@100;200;300;400;500;600;700&display=swap"
	rel="stylesheet">
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
	<!--    <header> -->
<%-- 	<jsp:include page="../../inc_ex/header.jsp" /> --%>
	<!--    </header> -->

<%-- 	<form action="${pageContext.request.contextPath }/ProfileUpdatePro" method="post" name="fr" enctype="multipart/form-data" > --%>
		<!--    <form id="memberUpdate" name="fr"> -->
		<section id="sec_con">
	      <h1 class="con_title">계좌 및 포인트</h1>
			<div class="inq_container">
				<jsp:include page="../../inc_ex/mem_sidebar.jsp"></jsp:include>
				
				<div class="member-update-cont">
					
					<!-- 계좌 정보 -->
					<div class="registered_account_box border rounded-4">
						<h4 class="box_title">등록된 계좌 정보</h4>
						<p class="box_account_info">
							<span class="account">${bank_name } ${account.account_num }</span>
							<span class="account_devider">/</span>
							<span class="name">${member.mem_name }</span>
						</p>
					</div>
					<%-- 				<form action="${pageContext.request.contextPath }/ProfileUpdatePro" method="post" name="fr" enctype="multipart/form-data" onsubmit='return signUpCheck();'> --%>
					<div>
					<ul>
						<li><label for="name">은행명</label>
							<div class="form-input border-bottom">
								<input type="text" name="mem_nickname" class="form-control"
									value="${bank_name }">
							</div></li>
						<li><label for="name">예금주</label>
							<div class="form-input border-bottom">
								<input type="text" name="mem_nickname" class="form-control"
									value="${member.mem_name }">
							</div></li>
						<li>
							<label for="name">계좌 번호</label>
							<div class="form-input border-bottom">
								<input type="text" name="mem_bio" id="name"
									class="form-control" value="${account.account_num }"
									>
							</div>
						</li>
					</ul>
					</div>
					
					<!-- ======================== -->
					<!-- 포인트 정보 -->
					
					<div class="registered_account_box border rounded-4">
						<h4 class="box_title">포인트 현황</h4>
					</div>
					<%-- 				<form action="${pageContext.request.contextPath }/ProfileUpdatePro" method="post" name="fr" enctype="multipart/form-data" onsubmit='return signUpCheck();'> --%>
					<div>
					<ul>
						<li>
							<label for="name">현재 포인트 잔액</label>
							<div class="form-input border-bottom">
								<input type="text" name="mem_bio" id="name"
									class="form-control" value="${member.charge_point }"
									>
							</div>
						</li>
					</ul>
					</div>
					<div class="btn_info_update cr">
						<!--                <input type="submit" alt="회원정보수정" value="수정하기" class="upd_btn" > -->
						<button class="upd_btn" 
						onclick='window.open("${pageContext.request.contextPath }/chargePointForm", "포인트충전", "width=500, height=650, left=100, top=50"); '>
						포인트 충전하기
						</button>
						<button class="upd_btn">포인트 계좌로 출금하기</button>
<!-- 						<button type="submit" class="upd_btn">수정하기</button> -->
						<%-- 			<button type="button" onclick="update('${member.mem_idx}')" alt="회원정보수정" class="upd_btn">수정하기</button> --%>
					</div>
				</div>
			</div>
		</section>
<!-- 	</form> -->
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
