<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%-- <jsp:include page="../../inc_ex/header_social.jsp" /> --%>
<%@ include file="../layout/header.jsp"%>
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/css/main_ex/market/common.css">

<!--인기 게시글-->
<main class="popular">
	<div class="exploreContainer">

		<!--인기게시글 갤러리(GRID배치)-->
		<div class="popular-gallery">
			<c:forEach var="image" items="${images }">
				<div class="p-img-box">
					<a href="${pageContext.request.contextPath }/social/${image.mem_idx }"> <img
						src="${pageContext.request.contextPath }/resources/upload/social/${image.posts_image1}" />					
					</a>
				</div>
			</c:forEach>
		</div>

	</div>
</main>

<%@ include file="../../inc_ex/footer.jsp"%>
