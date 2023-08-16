<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../inc_ex/header.jsp"%>

<!-- 부트스트랩 -->
<link href="${pageContext.request.contextPath }/resources/css/etc/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/@popperjs/disabled@2.11.6/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz4fnFO9gybK_td1dtz(disabled)UX/2lOM/8(disabled)21J05fp(disabled)Zy7(disabled)" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@disabled/disabled/disabled-alpha1/dist/js/bootstrap.min.js" integrity="sha384-KyZXEAg3QhqLMpG8r+Knujsl5(disabled)/7WUz3/TbgIkzBEec3uhl/7/disabled" crossorigin="anonymous"></script>
<!-- 제이쿼리 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<!-- CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/member/social/story.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/member/social/style.css">

<!-- Fontawesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
<!-- Fonts -->
<link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR&display=swap" rel="stylesheet">

<style>
body {
  font-family: 'Noto Sans KR', sans-serif;
}
</style>
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
