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
    
    <%-- 0627 배경인 수정 네이버 로그인 js --%>
<!--     <script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script> -->
</head>
<body>
	
 <div id="contents" class="subPage">
        <div id="sign">

            <!-- 서브컨텐츠 -->
            <article class="sign_in">

                <!-- pageTitle -->
                <div class="pageTitle">
                    <div class="layout1">
                        <h2 class="tit">ShoeCream 로그인</h2>
                    </div>
                </div>
                <!--// pageTitle -->

                <!-- 로그인 -->
                <form action="MemberLoginPro" method="post">
                <section class="container">
                    <div class="layout2">
                        <div class="wrap_box">
                            <div class="inner600">
                                <h3 class="t_tit1">로그인</h3>
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
                                    <div class="checkbox_ui type1">
                                        <input type="checkbox" id="rememberId" name="rememberId" <c:if test="${not empty cookie.REMEMBER_ID.value}">checked</c:if>>
                                        <label for="rememberId">아이디 저장</label>
                                    </div>
                                    <div class="find_btns">
<!--                                         <a href="memberFind" onclick="">비밀번호 찾기</a> -->
                                        <a href="memberFind" onclick="">아이디/비밀번호 찾기</a>
                                    </div>
                                </div>

								<button class="btn_login btn_typeB2" >로그인</button>
<!--                                 <input type="submit" class="btn_login btn_typeB2" value="로그인"> -->
                                <div class="join">
                                    <p>아이디가 없으신가요? </p>
                                    <a href="SignUpForm">회원가입</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
               </form>
                <!--// 로그인 -->

            </article>
            <!--[E] 서브컨텐츠 -->
        </div>
    </div>

</body>

</html>