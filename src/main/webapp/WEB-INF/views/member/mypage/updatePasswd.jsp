<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
   
<!DOCTYPE html>
<html lang="en">
<!-- 원본 파일 이름 member_update -->
<head>
   <meta charset="UTF-8">
   <meta http-equiv="X-UA-Compatible" content="IE=edge">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <title>마이페이지-비밀번호번경</title>
   <link href="${pageContext.request.contextPath }/resources/css/member/common.css" rel="stylesheet">
   <link href="${pageContext.request.contextPath }/resources/css/member/mem_page/mem_info_update.css" rel="stylesheet">
   <link href="${pageContext.request.contextPath }/resources/css/inc/top.css" rel="styleSheet">
   <link href="${pageContext.request.contextPath }/resources/css/inc/footer.css" rel="styleSheet">
<!--    <script src="http://code.jquery.com/jquery-latest.min.js"></script> -->
	<script src="${pageContext.request.contextPath }/resources/js/member/login/signup.js"></script>
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
   
</head>
<body>
<!--    <header> -->
		<jsp:include page="../../inc_ex/header.jsp" />
<!--    </header> -->

<form action="${pageContext.request.contextPath }/MemberPasswdUpdatePro" method="post" name="fr" onsubmit='return signUpCheck();'>
	<input type="hidden" id="mem_id" name="mem_id" value="${member.mem_id }">
<!--    <form id="memberUpdate" name="fr"> -->
   <section id="sec_con">
<!--       <h1 class="con_title">내 정보 수정</h1> -->
      <div class="inq_container">
      <!-- Sidebar -->
         <jsp:include page="../../inc_ex/mem_sidebar.jsp"></jsp:include>

         <div class="member-update-cont">
            <ul>
               <li>
                  <label for="name">현재 비밀번호</label>
                  <div class="form-input border-bottom">
                     <input type="password" name="mem_passwd"  class="form-control" >
                  </div>
               </li>
               <li>
                  <label for="name">비밀번호 변경</label>
                  <div class="form-input border-bottom">
                     <input type="password"  name="newPasswd" id="mem_passwd"  autoComplete="off" class="form-control"  placeholder="비밀변호 변경 시 입력하세요" oninput="checkPassword()">
                    <div id="passwordError" class="error"></div>
                  </div>
               </li>
               <li>
                  <label for="name">비밀번호 변경 확인</label>
                  <div class="form-input border-bottom">
                     <input type="password" name="newPasswd1" oninput='validatePassword()'  id="passwordCheck" class="form-control" placeholder="비밀변호 변경 시 입력하세요">
                      <div id="passwordCheckError" class="error"></div>
                  </div>
               </li> 
            </ul>
            <div class="btn_info_update cr">
<!--                <input type="submit" alt="회원정보수정" value="수정하기" class="upd_btn" > -->
				           <button class="upd_btn" >수정하기</button>
<%-- 			<button type="button" onclick="update('${member.mem_idx}')" alt="회원정보수정" class="upd_btn">수정하기</button> --%>
            </div>
         </div>
      </div>
   </section>
   </form>
<!--    <footer> -->
<%--       <jsp:include page="../../../inc/footer.jsp"></jsp:include> --%>
<!--    </footer> -->
<script type="text/javascript">
	   
// function signUpCheck(){
// 	let password = document.getElementById("mem_passwd").value 
// 	let passwordCheck = document.getElementById("passwordCheck").value
// 	if(password != null && passwordCheck != null && password != "" && passwordCheck != "" ){
// 		if (!validatePassword(password) || !validatePassword(passwordCheck) ) {
// 		alert('영문,숫자,특수문자 포함 8~20글자 이상 입력 해주세요.'); 
// 		return false; 
// 		}	    	 
// 	} 
// 	return true; 
// }  
</script> 

<!-- =============================== -->

</body>

</html>