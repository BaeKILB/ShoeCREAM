<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
    <%-- 원본 파일 이름 sidebar --%>

<link  href="${pageContext.request.contextPath }/resources/css/main_ex/inc/mem_sidebar.css" rel="stylesheet">

	<div class="mypage_sidebar">
		<!-- 유저 프로필 -->
		<div class="user_profile">
			<dl class="user_info">
				<dt>
					<b>${member.mem_name }</b> 님
				</dt>
				<dd>${sessionScope.sId }</dd>
			</dl>
			<p class="info_manage" >마이페이지</p>
		</div>

		<ul class="side_menu">
			<li>
			    <div class="menu_tit mt_user">
			        <span>내 정보 관리</span>
			    </div>
			    <ul class="side_sub">
			        <li><a href="${pageContext.request.contextPath}/mypage/update">내 정보 관리</a></li>
			        <c:if test="${member.mem_status == null or member.mem_status == ''}">
			            <li style="margin-top: 10px;"><a href="${pageContext.request.contextPath}/mypage/updatePasswd">내 비밀먼호 변경</a></li>
			        </c:if>
			        <li><a href="${pageContext.request.contextPath}/mypage/profile">내 프로필 관리</a></li>
			        <li><a href="${pageContext.request.contextPath}/mypage/account">내 계좌</a></li>
			        <li><a href="${pageContext.request.contextPath}/mypage/delete">회원탈퇴</a></li>
			    </ul>
			</li>
			<li>
				<div class="menu_tit mt_call">
					<span>고객센터</span>
				</div>
				<ul class="side_sub">
					<li><a href="https://pf.kakao.com/_sxfWQxj">1:1 카카오톡으로 문의하기</a></li>
					<li>전화문의 051-123-4567</li>
				</ul>
			</li>
		</ul>
		<script>
			$('.menu_tit').click(function () {
			    $(this).children('span').addClass('on');
			    if ($(this).siblings('.side_sub').is(':hidden')) {
			        $(this).siblings('.side_sub').slideDown();
			        $(this).children('span').removeClass('on');
			    } else {
			        $(this).siblings('.side_sub').slideUp();
			    }
			});
		</script>
	</div>
	
