<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../inc_ex/header.jsp"%>

<!DOCTYPE html>
<html>
<head>
<script>
  let posts_idx = ${posts_idx};
</script>
<!--JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/member/social/detail.css">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<main class="main">
	<input type="hidden" id="posts_idx" value="${posts_idx}" />
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
<script src="${pageContext.request.contextPath }/resources/js/member/social/detail.js"></script>

	<!-- 푸터 시작 -->
	<jsp:include page="../../inc_ex/footer.jsp" />
</body>
</html>