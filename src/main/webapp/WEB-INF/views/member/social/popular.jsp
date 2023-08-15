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
		<div class="container">
		  <div class="row">
			<!-- 인기순/최신순 라디오 버튼 -->
			<div class="col-auto ms-auto">
			    <input type="radio" class="btn-check" name="productSortCheck" id="productSortPopular" value="popular" autocomplete="off">
			    <label class="btn btn-check-label" for="productSortPopular">인기순</label>
			    <input type="radio" class="btn-check" name="productSortCheck" id="productSortLatest" value="latest" autocomplete="off" checked>
			    <label class="btn btn-check-label" for="productSortLatest">최신순</label>
			</div>
		  </div>
		</div>
		<hr>
		<!--인기게시글 갤러리(GRID배치)-->
		<div class="popular-gallery row">

		</div>

	</div>
</main>
<script src="${pageContext.request.contextPath }/resources/js/member/social/popular.js"></script>
<script>
var contextPath = "${pageContext.request.contextPath}";
</script>
<%@ include file="../../inc_ex/footer.jsp"%>
