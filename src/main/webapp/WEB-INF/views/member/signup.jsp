<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<!DOCTYPE html>
<html lang="ko">
<head>
	<title>회원가입</title>

	<%-- css --%>
	<link href="${pageContext.request.contextPath }/resources/css/member/common.css" rel="styleSheet">
	<link href="${pageContext.request.contextPath }/resources/css/member/login/signup.css" rel="styleSheet">
<%-- 	<link href="${pageContext.request.contextPath }/resources/css/inc/top.css" rel="styleSheet"> --%>
<%-- 	<link href="${pageContext.request.contextPath }/resources/css/inc/footer.css" rel="styleSheet"> --%>
	
	<%-- js --%>
	<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.0.js"></script>
	<script src="${pageContext.request.contextPath }/resources/js/member/login/signup.js"></script>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

</head>

<body>
	<div id="contents">
		<form action="MemberJoinPro" method="post" name="fr" id="fr">
			<section id="sec_con" class="inr signup_wrap">
			 	<h1 class="con_title">슈크림 회원가입</h1>
			 	<div class="signup_cont">
				    <div class="sign_wrapper">  

						<div class="id">
						    <p>아이디</p>
						    <span class="sign_mark">*</span><br>
						    <input id="mem_id" name="mem_id" type="text" placeholder="아이디를 입력해 주세요.." required="required">
						    <div id="idError" class="error"></div>
						</div>

				        <div class="name">
				        	<p>이름</p>
				        	<span class="sign_mark">*</span><br>
				            <input id="mem_name"  name="mem_name" type="text"  placeholder="이름을 입력해 주세요." >
				            <div id="nameError" class="error"></div>
				        </div>
				        
				        <div class="password">
				        	<p>비밀번호</p>
				        	<span class="sign_mark">*</span><br>
				            <input id="mem_passwd" name="mem_passwd" type="password" placeholder="영문,숫자,특수문자 포함 8~20글자 이상." >
				            <div id="passwordError" class="error"></div>
				        </div>
				        
				        <div class="email">
				        	<p>이메일</p>
				        	<span class="sign_mark">*</span><br>
				            <input id="mem_email" name="mem_email" type="text" placeholder="이메일을 입력해 주세요." >
				            <div id="emailError" class="error"></div> 
				            <div id="emailError" class="error"><span class="id_already"></span></div> 
				        </div>
				        
				        <div class="birthDate">
				        	<p>생년월일</p>
				        	<span class="sign_mark">*</span><br>
				            <input id="mem_birthday" name="mem_birthday" type="date"  min="1990-01-01" onblur='validateBirth()' >
				            <div id="birthError" class="error"></div>
				        </div>
				        
				        <div class="addr">
				        	<p>주소</p>
				        	<span class="sign_mark">*</span><br>
				            <input id="sample6_postcode" name="sample6_postcode" type="text" placeholder="우편번호">
				            <input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
				            <input type="text" id="sample6_address" name="sample6_address" placeholder="주소"><br>
							<input type="text" id="sample6_detailAddress" name="sample6_detailAddress" placeholder="상세주소">
							<input type="text" id="sample6_extraAddress" name="sample6_extraAddress" placeholder="참고항목">
				            <div id="addrError" class="error"></div>
				        </div>
				        
				       <div class ="phoneAuth">
     				        <p>휴대폰번호</p>
				        	<span class="sign_mark">*</span><br>
				        
				        <div class="phone" >
				            <input id="phone1"  name="phone1" type="text" size="1" maxlength="3" oninput="changePhone1()" > -
				            <input id="phone2" name="phone2" type="text" size="3" maxlength="4" oninput="changePhone2()" > -
				            <input id="phone3" name="phone3" type="text" size="3" maxlength="4" oninput="changePhone3()" >
				            <button type="button" disabled id="sendMessage" onclick="sendMsg()">인증번호 전송</button>
				       			        
				       </div>
						<div class="confirm">
				            <input type="text" id="cert" name="memberPhoneCertify" maxlength="4"  required disabled placeholder="인증번호를 입력 해주세요">
				            <button type="button" disabled id="certifyCheck" onclick="verifyCode()" >인증확인</button>
				        </div>
				        
				        
				        <div class="signUp">
				           <button>가입하기</button>
				        </div>
						
						
<!-- 				        <div class="email"> -->
<!-- 				        	<p>아이디</p> -->
<!-- 				        	<span class="sign_mark">*</span><br> -->
<!-- 				            <input id="mem_id" name="mem_id" type="text" onchange='checkId()' oninput='checkEmail()' placeholder="이메일을 입력해 주세요." required="required"> -->
<!-- 				            <div id="emailError" class="error"></div>  -->
<!-- 				            <div id="emailError" class="error"><span class="id_already"></span></div>  -->
<!-- 				        </div> -->
				        
<!-- 				        <div class="password"> -->
<!-- 				        	<p>비밀번호</p> -->
<!-- 				        	<span class="sign_mark">*</span><br> -->
<!-- 				            <input id="mem_passwd" name="mem_passwd" type="password" placeholder="영문,숫자,특수문자 포함 8~20글자 이상." required="required" autoComplete="off" oninput='validatePw()'> -->
<!-- 				            <div id="passwordError" class="error"></div> -->
<!-- 				        </div> -->
<!-- 				        <div class="passwordCheck"> -->
<!-- 				        	<p>비밀번호 확인</p> -->
<!-- 				        	<span class="sign_mark">*</span><br> -->
<!-- 				            <input id="passwordCheck" oninput='passwordConfirm()' type="password" placeholder="비밀번호를 다시 입력해 주세요."  required="required" onchange="validatePassword()" autoComplete="off"> -->
<!-- 				            <div id="passwordCheckError" class="error"></div> -->
<!-- 				        </div> -->
				        
				        
				        
<!-- 				        	<p>휴대폰번호</p> -->
<!-- 				        	<span class="sign_mark">*</span><br> -->
<!-- 				       <div class ="phoneAuth"> -->
				        
<!-- 				        <div class="phone" > -->
<!-- 				            <input id="phone1"  name="phone1" type="text" size="1" maxlength="3" oninput="changePhone1()" required="required"> - -->
<!-- 				            <input id="phone2" name="phone2" type="text" size="3" maxlength="4" oninput="changePhone2()" required="required"> - -->
<!-- 				            <input id="phone3" name="phone3" type="text" size="3" maxlength="4" oninput="changePhone3()" required="required"> -->
<!-- 				            <button type="button" disabled id="sendMessage" onclick="sendMsg()">인증번호 전송</button> -->
				       			        
<!-- 				       </div> -->
<!-- 						<div class="confirm"> -->
<!-- 				            <input type="text" id="cert" name="memberPhoneCertify" maxlength="4"  required disabled placeholder="인증번호를 입력 해주세요"> -->
<!-- 				            <button type="button" disabled id="certifyCheck" onclick="verifyCode()" >인증확인</button> -->
<!-- 				        </div> -->
				        
<!-- 				        </div> -->
				        
<!-- 				        <div class="line"> -->
<!-- 				            <hr> -->
<!-- 				        </div> -->
<!-- 				        <div class="signUp"> -->
<!-- 				           <button type="button" id="signUpButton" onclick='signUpCheck()'>가입하기</button> -->
<!-- 				        </div> -->
            <div class="join">
                <span>계정이 있으신가요?</span>
                <a href="login">로그인</a>
            </div>
			 	</div>
			 	</div>
			</section>
		</form>
				    </div>

</body>
</html>