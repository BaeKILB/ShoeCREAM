<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../inc_ex/header.jsp"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/css/main_ex/market/common.css">

<!--인기 게시글-->
<main class="popular">
    <div class="exploreContainer">
         <!-- 인기 팔로워 -->
        <div class="container">
            <div class="row">
                <c:forEach var="profileInfo" items="${profileInfo }">
                    <div class="col-md text-center mb-3">
                        <a href="${pageContext.request.contextPath }/social/${profileInfo.mem_idx }" class="">
                            <div class="shortcut rounded">
                                <img src="${pageContext.request.contextPath }/resources/upload/profile/${profileInfo.mem_profileImageUrl }" class="profileImg" onerror="this.src='${pageContext.request.contextPath}/resources/img/member/social/memProfile.jpg'">
                                <p class="shortcut_title">${profileInfo.mem_nickname }</p>
                            </div>
                        </a>
                    </div>
                </c:forEach>
            </div>
        </div>
		
		<hr>
		<!--인기게시글 갤러리(GRID배치)-->
		<div class="popular-gallery row">
			<c:forEach var="image" items="${images }">
				<div class="p-img-box col-md-3 mb-4">
					<div style="border-radius:20%;">
					<a href="${pageContext.request.contextPath }/social/${image.mem_idx }"> <img class="rounded-image"
						src="${pageContext.request.contextPath }/resources/upload/social/${image.posts_image1}" />					
					</a>
					</div>
						<div id="storyCommentList-1" style=" margin-top: 3px;">
		                   <div class="sl__item__header" style="height: 25px;">
								<div class="container">
									<div class="row">
			                           <div class="col-1" style="height: 25px; padding-left: 0px;padding-right: 0px;">
			                               <a href="${pageContext.request.contextPath }/social/${image.mem_idx }"> <!-- 링크를 추가 -->
			                               <img class="profile-image" src="${pageContext.request.contextPath }/resources/upload/profile/${image.mem_profileImageUrl }" onerror="this.src='https://kream.co.kr/_nuxt/img/blank_profile.4347742.png';" style="width: 28.63636px;height: 28.63636px;margin-right: 5px; margin-left: 0px; border-radius: 50%;">
			                           	</a>
			                           </div>
			                           <div class="col d-flex align-items-center no-vertical-margins" style="font-size: 0.8rem;">
			                               <span><strong>${image.mem_nickname }</strong></span>
			                           </div>
			                           <div class ="col-1">
										<div class="sl__item__contents__icon">
											<button>
												<i class="fas fa-heart active" id="storyLikeIcon-${image.posts_idx}" onclick="toggleLike(${image.posts_idx})"></i>
											<%-- <i class="far fa-heart" id="storyLikeIcon-${image.posts_idx}" onclick="toggleLike(${image.posts_idx})"></i>`; --%>
											</button>
										</div>
			                           </div>
			                          <div class="col-1">
			                           	<span class="like"><b id="storyLikeCount-${image.posts_idx}">${image.likeCount}</b></span>
									</div> 
									</div>
									<div class="row" style="margin-top: 3px; word-break: normal;">
			                           <div class="col" style="padding-right: 0px; padding-left: 0px;">
										<span class="" style="white-space: pre-wrap; word-wrap: break-word; word-break: break-word; color :#495057;">${image.posts_content }</span>
			                           </div>
		                           </div>
								</div>
							</div>
						</div>
					</div>
			</c:forEach>
		</div>

	</div>
</main>
<script src="${pageContext.request.contextPath }/resources/js/member/social/popular.js"></script>
<script>
var contextPath = "${pageContext.request.contextPath}";
</script>
<%@ include file="../../inc_ex/footer.jsp"%>
