<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../inc_ex/header.jsp"%>
<%-- 	<jsp:include page="../../inc_ex/header_social.jsp" /> --%>
<%-- <%@ include file="../layout/header.jsp"%> --%>
<style>

</style>
<%-- <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/main_ex/market/common.css"> --%>

<main class="main">
	<section class="container">
		<!--전체 리스트 시작-->
			    <!-- 부트스트랩 레이아웃을 적용한 부분 -->
    	<div class="row">
      		<div class="col-md-2"></div> <!-- Left empty column -->
      			<div class="col-md-8"> 
				<article class="story-list" id="storyList">
			<!--전체 리스트 아이템-->

	
				</article>
	      	</div>
<!-- 			<div class="col-md-2"></div> -->
	    </div>
	</section>
</main>
<script>
  var contextPath = "${pageContext.request.contextPath}";
</script>
<script src="${pageContext.request.contextPath }/resources/js/member/social/story.js"></script>
	<!-- 푸터 시작 -->
	<jsp:include page="../../inc_ex/footer.jsp" />
</body>
</html>
