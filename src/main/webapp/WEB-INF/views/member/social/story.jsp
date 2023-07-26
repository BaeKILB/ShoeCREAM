<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<jsp:include page="../../inc_ex/header_social.jsp" />
<%@ include file="../layout/header.jsp"%>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/main_ex/market/common.css">
<main class="main">
	<section class="container">
		<!--전체 리스트 시작-->
		<article class="story-list" id="storyList">

			<!--전체 리스트 아이템-->
			<div class="story-list__item">
				<div class="sl__item__header">
					<div>
						<img class="profile-image" src="#"
							onerror="this.src='${pageContext.request.contextPath }/resources/img/member/social/person.jpeg'" />
					</div>
					<div>TherePrograming</div>
				</div>

				<div class="sl__item__img">
					<img src="${pageContext.request.contextPath }/resources/img/member/social/jodan.jpg"/>
<%-- 					<img src="${pageContext.request.contextPath }/resources/img/member/home.jpg" /> --%>
				</div>

				<div class="sl__item__contents">
					<div class="sl__item__contents__icon">

						<button>
							<i class="fas fa-heart active" id="storyLikeIcon-1" onclick="toggleLike()"></i>
						</button>
					</div>

					<span class="like"><b id="storyLikeCount-1">3 </b>likes</span>

					<div class="sl__item__contents__content">
						<p>리셀로 샀어요 ^^</p>
					</div>

					<div id="storyCommentList-1">

						<div class="sl__item__contents__comment" id="storyCommentItem-1"">
							<p>
								<b>HaHa :</b> 부럽습니다.
							</p>

							<button>
								<i class="fas fa-times"></i>
							</button>

						</div>

					</div>

					<div class="sl__item__input">
						<input type="text" placeholder="댓글 달기..." id="storyCommentInput-1" />
						<button type="button" onClick="addComment()">게시</button>
					</div>

				</div>
			</div>

		</article>
	</section>
</main>
<script src="${pageContext.request.contextPath }/resources/js/member/social/story.js"></script>
	<!-- 푸터 시작 -->
	<jsp:include page="../../inc_ex/footer.jsp" />
</body>
</html>
