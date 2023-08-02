<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath }/resources/css/admin/common.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/admin/admin_question.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>
	<aside>
		<jsp:include page="inc/sidebar.jsp" ></jsp:include>
	</aside>
	
	<section id="admin_cont">
		<h1 class="admin_tit">1:1 문의 조회</h1>
		<hr class="tit_line">
		<div class="question_cont">
			<div class="mem_list_wrap">
				<div class="list_wrap">
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
										${inquiry.mem_name }
									</span>
								</div>
								<div class="write_box">
									<span class="write_t">등록일</span>
									<span class="write_c">
										<fmt:formatDate value="${inquiry.qst_date }" pattern="yy-MM-dd HH:mm"/>
									</span>
								</div>
								<div class="write_box">
									<span class="write_t">문의유형</span>
									<span class="write_c">
										${inquiry.qst_type }
									</span>
								</div>
							</li>
						</ul>
						<div class="write_cont">
							<p style="white-space: pre-line;">
								${inquiry.qst_content }
							</p>
						</div>
					</div>
				</div>
				<c:choose>
					<c:when test="${not empty inquiryAnswer}">
						<form action="QstModifyPro" method="post">
							<input type="hidden" name="qst_idx" value="${inquiry.qst_idx }">
							<input type="hidden" name="mem_idx" value="${inquiry.mem_idx }">
							<input type="hidden" name="mem_name" value="${inquiry.mem_name }">
							<input type="hidden" name="qst_type" value="${inquiry.qst_type }">
							<input type="hidden" name="qst_pass" value="${inquiry.qst_pass }">
							<input type="hidden" name="qst_board_re_ref" value="${inquiry.qst_board_re_ref }">
							<input type="hidden" name="pageNum" value="${param.pageNum }">
							<div class="list_wrap">
								<ul class="list">
									<li>
										<div class="subject">
											<input type="text" value="${inquiry.mem_name } 님 답변 드립니다." class="inputBox" name="qst_subject">
										</div>
									</li>
								</ul>
								<div class="write_cont">
									<p>
										<textarea style="white-space: pre-line;" class="inputBox" placeholder="내용을 입력해주세요" name="qst_content" required="required"></textarea>
									</p>
								</div>
								<div class="mod_box">
									<input type="submit" class="submit_btn" value="등록">
								</div>
							</div>
						</form>
					</c:when>
				</c:choose>
			</div>
		</div>
	</section>
	
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