<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../inc_ex/header.jsp"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!-- 부트스트랩 -->
<link href="${pageContext.request.contextPath }/resources/css/etc/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/@popperjs/disabled@2.11.6/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz4fnFO9gybK_td1dtz(disabled)UX/2lOM/8(disabled)21J05fp(disabled)Zy7(disabled)" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@disabled/disabled/disabled-alpha1/dist/js/bootstrap.min.js" integrity="sha384-KyZXEAg3QhqLMpG8r+Knujsl5(disabled)/7WUz3/TbgIkzBEec3uhl/7/disabled" crossorigin="anonymous"></script>
<!-- 제이쿼리 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<!-- CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/member/social/popular.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/member/social/style.css">

<!-- 공통 CSS -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/css/main_ex/font/font.css">
	
<!-- Fontawesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
<!-- Fonts -->
<link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR&display=swap" rel="stylesheet">

<style>
body {
  font-family: 'Noto Sans KR', sans-serif; 
 } 
</style>

<!--인기 게시글-->
<main class="popular">
<div class="inq_container">
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
    <div class="col-auto ms-auto mb-3">
        <input type="radio" class="btn-check" name="productSortCheck" id="productSortPopular" value="popular" autocomplete="off" checked>
        <label class="btn btn-custom" for="productSortPopular"><b>인기순</b></label>
        <input type="radio" class="btn-check" name="productSortCheck" id="productSortLatest" value="latest" autocomplete="off">
        <label class="btn btn-custom" for="productSortLatest"><b>최신순</b></label>
    </div>
  </div>
</div>
		<!--인기게시글 갤러리(GRID배치)-->
		<div class="popular-gallery row">

		</div>

	</div>
	</div>
</main>
<script src="${pageContext.request.contextPath }/resources/js/member/social/popular.js"></script>
<script>
var contextPath = "${pageContext.request.contextPath}";
</script>
<%@ include file="../../inc_ex/footer.jsp"%>
