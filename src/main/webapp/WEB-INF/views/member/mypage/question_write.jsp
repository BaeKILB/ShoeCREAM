<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath }/resources/css/member/common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/resources/css/member/mem_page/common.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/member/mem_page/question.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>
   <header>
		<jsp:include page="../../inc_ex/header.jsp" />
    </header>
	<div class="inq_container">
        <jsp:include page="../../inc_ex/mem_sidebar.jsp"></jsp:include>
	<section id="admin_cont">
		<form action="${pageContext.request.contextPath }/QstMemberWritePro" method="post">
		<hr class="tit_line">
		<div class="question_cont">
			<div class="mem_list_wrap">
				<div class="list_wrap">
					<ul class="list">
						<li>
							<div class="subject">
								${inquiry.qst_subject }
							</div>
						</li>
						<li class="write_info">
							<div class="write_box">
								<span class="write_t">작성자명</span>
								<span class="write_c">
									 <input type="text" name="mem_name" id="mem_name" class="inputBox" value="${member.mem_name}" readonly >
								</span>
							</div>
<!-- 							<div class="write_box"> -->
<!-- 								<span class="write_t">등록일</span> -->
<!-- 								<span class="write_c"> -->
<%-- 									<fmt:formatDate value="${member.qst_date }" pattern="yy-MM-dd HH:mm"/> --%>
<!-- 								</span> -->
<!-- 							</div> -->
							<div class="category">
								<span class="write_t">문의유형</span> 
								<span class="write_c">
									<select name="qst_type" id="qst_type" required="required">
										<option value="" selected>선택하세요</option>
										<option value="거래신고">거래신고</option>
										<option value="크림문의">크림문의</option>
										<option value="회원/계정">회원/계정</option>
										<option value="계좌/포인트">계좌/포인트</option>
										<option value="판매광고">판매광고</option>
										<option value="오류/신고/제안">오류/신고/제안</option>
								</select>
								</span>
							</div>
						</li>
					</ul>
				</div>
						<input type="hidden" name="mem_idx" value="${member.mem_idx }">
							<div class="list_wrap modify">
								<ul class="list">
									<li>
										<div class="subject">
											<input type="text" value="" class="inputBox" name="qst_subject" placeholder="제목을 입력해주세요" required="required">
										</div>
									</li>
								</ul>
								<div class="write_cont">
									<p>
										<textarea style="white-space: pre-line;" class="inputBox" placeholder="내용을 입력해주세요" name="qst_content" required="required"></textarea>
									</p>
								</div>
								<div class="mod_box">
									<input type="submit" class="list_btn" value="등록하기">
									<a class="list_btn" href="${pageContext.request.contextPath }/mypage/questionList?pageNum=${param.pageNum }">목록</a>
								</div>
							</div>
						</form>
			</div>
		</div>
	</section>
	</div>
	
	<script type="text/javascript">
		$(document).ready(function() {
			$('.cont_li_wrap.inqList').show();
			$('.cont_item_list.inqList').addClass('active');
		});
	    $(document).on('click', '.toggle_wrap', function() {
	    	if($('#admin_cont').css('margin-left') === '0px') {
	    		$('#admin_cont').show().animate({
					marginLeft : '15.625rem'
				}, 200);
	    	} else {
	    		$('#admin_cont').show().animate({
					marginLeft : '0px'
				}, 200);
	    	}
	    });
	</script>
</body>
</html>