<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인</title>
	<link href="${pageContext.request.contextPath }/resources/css/member/common.css"  rel="stylesheet">
    <link href="${pageContext.request.contextPath }/resources/css/member/login/login.css" rel="styleSheet">
    <link href="${pageContext.request.contextPath }/resources/css/inc/top.css" rel="styleSheet">
    <link href="${pageContext.request.contextPath }/resources/css/inc/footer.css" rel="styleSheet">

	<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.0.js"></script>
 
    <!-- 카카오 스크립트 -->
	<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/member/login/login.js"></script>
	
	<script>
	</script>
	
    <%-- 0627 배경인 수정 네이버 로그인 js --%>
<!--     <script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script> -->
</head>
<body>

	<jsp:include page="../../inc_ex/header.jsp" />	
	
 <div id="contents" class="subPage">
        <div id="sign">

            <!-- 서브컨텐츠 -->
            <article class="sign_in">

                <!-- 로그인 -->
                <form action="login" method="post">
                <section class="container">
                    <div class="layout2">
                        <div class="wrap_box">
                            <div class="inner600">
                                <img src="${pageContext.request.contextPath }/resources/img/member/social/ShoeCreamLogo.png" alt="">
								<!-- 아이디 -->
                                <div class="login_input">
                                    <div class="inp_bundle">
                                        <input type="text" name="mem_id"  value="${cookie.REMEMBER_ID.value}" class="inp" placeholder="아이디" />
                                    </div>   
                                    <!-- 비밀번호 -->
                                    <div class="inp_bundle">
                                        <input type="password" name="mem_passwd" class="inp flex"
                                            placeholder="비밀번호 (영문, 숫자, 특수문자 포함 8~30자)" />
                                    </div>
                                </div>

                                <div class="input_bottom">
<!--                                     <div class="checkbox_ui type1"> -->
<%--                                         <input type="checkbox" id="rememberId" name="rememberId" <c:if test="${not empty cookie.REMEMBER_ID.value}">checked</c:if>> --%>
<!--                                         <label for="rememberId">아이디 저장</label> -->
<!--                                     </div> -->
                                    <div class="find_btns">
<!--                                         <a href="memberFind" onclick="">비밀번호 찾기</a> -->
                                        <a href="find/memid" onclick="">아이디/비밀번호 찾기</a>
                                    </div>
                                    <div class="find_btns">
                                    
                                    </div>
                                </div>
								
<!-- 		                        <div class="d-grid gap-2 col mx-auto"> -->
<!-- 								  <button class="btn btn-primary btn_login btn_typeB2" type="button" style="font-size:20px;"> -->
<!-- 								  	<i class="fab fa-facebook-square" ></i> -->
<!-- 								  	Facebook으로 로그인 -->
<!-- 								  </button> -->
<!-- 								</div> -->
								
		                        <!-- Oauth 카카오 로그인 -->
<%--                                 <a href="javascript:kakaoLogin();"><img src="${pageContext.request.contextPath }/resources/img/member/login/kakao_login_large_wide.png" style="height:60px; width:auto;"></a> --%>
								<button class="btn_login btn_typeB2" >로그인</button>

                                <a href="https://kauth.kakao.com/oauth/authorize?response_type=code&client_id=29eee1b4771daa5dc16c4084cc6defc9&redirect_uri=http://localhost:8089/shoecream/auth/kakao/callback"><img src="${pageContext.request.contextPath }/resources/img/member/login/kakao_login_large_wide.png" style="height:75px; width:auto;"></a>
								
<!--                                 <input type="submit" class="btn_login btn_typeB2" value="로그인"> -->
                                <div class="join">
                                    <p>아이디가 없으신가요? </p>
                                    <a href="signup">회원가입</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
               </form>
<!-- 				<div class ="text-center"> -->
<%-- 					<a href="${ naver_url }"><img width="300" alt="Naver Login" src="${pageContext.request.contextPath }/resources/img/member/login/naverlogin.png"></a> --%>
<%-- 					<a href="${ google_url }"><img width="300" alt="Google Login" src="${pageContext.request.contextPath }/resources/img/member/login/google-signin-button.png"></a> --%>
<!-- 				</div> -->
                <!--// 로그인 -->
            </article>
            <!--[E] 서브컨텐츠 -->
        </div>
    </div>

</body>
</html>