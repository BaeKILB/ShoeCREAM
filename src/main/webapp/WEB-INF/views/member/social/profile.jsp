<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../inc_ex/header.jsp"%>
<!-- 부트스트랩 -->
<!-- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KyZXEAg3QhqLMpG8r+Knujsl5/7(disabled)WUz3/TbgIkzBEec3uhl/7/disabled" crossorigin="anonymous"> -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/disabled@2.11.6/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz4fnFO9gybK_td1dtz(disabled)UX/2lOM/8(disabled)21J05fp(disabled)Zy7(disabled)" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@disabled/disabled/disabled-alpha1/dist/js/bootstrap.min.js" integrity="sha384-KyZXEAg3QhqLMpG8r+Knujsl5(disabled)/7WUz3/TbgIkzBEec3uhl/7/disabled" crossorigin="anonymous"></script>
<!-- 제이쿼리 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<%-- <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/main_ex/market/common.css"> --%>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/member/social/profile.css">
<style>
.likeHeart{
	width: 400px;
    height: 300px;
    padding-left: 140px;
    padding-top: 140px;
    padding-bottom: 140px;
    padding-right: 100px;
}  

</style>
<!--프로필 섹션-->
<section class="profile" style="margin-top: 200px;">
	<!--유저정보 컨테이너-->
	<div class="profileContainer">

		<!--유저이미지-->
		<div class="profile-left">
			<div class="profile-img-wrap story-border">
				<form id="userProfileImageForm">
					<input type="file" name="profileImageFile" style="display: none;"
						id="userProfileImageInput" />
				</form>

<%-- 				<img class="profile-image" src="${pageContext.request.contextPath}/resources/upload/profile/${dto.member.mem_profileImageUrl}" --%>
<%-- 					onerror="this.src='${pageContext.request.contextPath }/resources/img/member/social/memProfile.jpg'" --%>
<!-- 					id="userProfileImage" /> -->
				<img class="profile-image" src="${pageContext.request.contextPath}/resources/upload/profile/${dto.member.mem_profileImageUrl}"
					onerror="this.src='${pageContext.request.contextPath }/resources/img/member/social/memProfile.jpg'"
					onclick="location.href='${pageContext.request.contextPath }/store/${dto.member.mem_idx}'" />
			</div>
		</div>
		<!--유저이미지end-->

		<!--유저정보 및 사진등록 구독하기-->
		<div class="profile-right">
			<div class="name-group">
				<h2>${dto.member.mem_nickname}</h2>
				<!--  원래 방법 하지만 뷰페이지에서 연산은 별로 안좋다 -->
<%-- 				<c:choose> --%>
<%-- 					<c:when test="${principal.member.mem_idx eq member.mem_idx}"> --%>
<!-- 						<button class="cta" -->
<%-- 							onclick="location.href='${pageContext.request.contextPath }/image/upload'">사진등록</button> --%>
<%-- 					</c:when> --%>
<%-- 					<c:otherwise> --%>
<!-- 						<button class="cta" onclick="toggleSubscribe(this)">구독하기</button> -->
<%-- 					</c:otherwise> --%>
<%-- 				</c:choose> --%>

				<c:choose>
					<c:when test="${dto.pageOwnerState }">
						<button class="cta" onclick="location.href='${pageContext.request.contextPath }/image/upload'">사진등록</button>
					</c:when>
					<c:otherwise>
						<c:choose>
							<c:when test="${dto.followState }">
								<button class="cta blue" onclick="toggleSubscribe(${dto.member.mem_idx},this)">구독취소</button>
							</c:when>
							<c:otherwise>
								<button class="cta" onclick="toggleSubscribe(${dto.member.mem_idx},this)">구독하기</button>
							</c:otherwise>
						</c:choose>
						<button class="cta" onclick="location.href='${pageContext.request.contextPath }/store/${dto.member.mem_idx}'">${dto.member.mem_nickname}상점</button>
					</c:otherwise>
				</c:choose>
				<button class="modi" onclick="popup('.modal-info')">
					<i class="fas fa-cog"></i>
				</button>
			</div>

			<div class="subscribe">
				<ul>
					<li><a href=""> 게시물<span>${social.size()}</span>
					</a></li>
					<li><a href="javascript:subscribeInfoModalOpen(${dto.member.mem_idx });"> 구독정보<span>${dto.followCount}</span>
					</a></li>
				</ul>
			</div>
			<div class="state">
				<h4>${dto.member.mem_bio }</h4>
			</div>
		</div>
		<!--유저정보 및 사진등록 구독하기-->

	</div>
</section>

<!--게시물컨섹션-->
<section id="tab-content">
	<!--게시물컨컨테이너-->
	<div class="profileContainer">
		<!--그냥 감싸는 div (지우면이미지커짐)-->
		<div id="tab-1-content" class="tab-content-item show">
			<!--게시물컨 그리드배열-->
			<div class="tab-1-content-inner">
				<!--아이템들-->
				<c:forEach var="social" items="${social}">
					<div class="img-box">
						    <a href="${pageContext.request.contextPath }/social/${social.mem_idx}/detail" class="image-link">
						        <img src="${pageContext.request.contextPath}/resources/upload/social/${social.posts_image1}" />
						    </a>
						<div class="comment">
							<a href="${pageContext.request.contextPath }/social/${social.posts_idx}/detail" class="likeHeart"> 
							<i class="fas fa-heart"></i><span>${social.likeCount }</span>
							</a>
						</div>
					</div>
				</c:forEach>
				<!--아이템들end-->
			</div>
		</div>
	</div>
</section>

<!--로그아웃, 회원정보변경 모달-->
<div class="modal-info" onclick="modalInfo()">
	<div class="modal">
		<!-- 		<button onclick="location.href='/user/1/update'">회원정보 변경</button> -->
		<button
			onclick="location.href='${pageContext.request.contextPath }/mypage/update'">회원정보
			변경</button>
		<button
			onclick="location.href='${pageContext.request.contextPath }/logout'">로그아웃</button>
		<button onclick="closePopup('.modal-info')">취소</button>
	</div>
</div>
<!--로그아웃, 회원정보변경 모달 end-->

<!--프로필사진 바꾸기 모달-->
<div class="modal-image" onclick="modalImage()">
	<div class="modal">
		<p>프로필 사진 바꾸기</p>
		<button onclick="profileImageUpload()">사진 업로드</button>
		<button onclick="closePopup('.modal-image')">취소</button>
	</div>
</div>

<!--프로필사진 바꾸기 모달end-->

<div class="modal-subscribe">
	<div class="subscribe">
		<div class="subscribe-header">
			<span>구독정보</span>
			<button onclick="modalClose()">
				<i class="fas fa-times"></i>
			</button>
		</div>

		<div class="subscribe-list" id="subscribeModalList">



		</div>
	</div>

</div>

<script>
  var contextPath = "${pageContext.request.contextPath}";
</script>
<script src="${pageContext.request.contextPath }/resources/js/member/social/profile.js"></script>

<%-- <%@ include file="../../inc_ex/footer.jsp"%> --%>