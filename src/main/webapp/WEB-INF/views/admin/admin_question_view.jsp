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
									<fmt:formatDate value="${inquiry.qst_date }" pattern="yy-MM-dd"/>
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
				
				<c:choose>
					<c:when test="${not empty inquiryAnswer}">
						<div class="list_wrap answer">
							<ul class="list">
								<li>
									<div class="subject">
										${inquiryAnswer.qst_subject }
									</div>
								</li>
								<li class="write_info">
									<div class="write_box">
										<span class="write_t">작성자명</span>
										<span class="write_c">
											${inquiryAnswer.mem_name }
										</span>
									</div>
									<div class="write_box">
										<span class="write_t">등록일</span>
										<span class="write_c">
											<fmt:formatDate value="${inquiryAnswer.qst_date }" pattern="yy-MM-dd"/>
										</span>
									</div>
									<div class="write_box">
										<span class="write_t">문의유형</span>
										<span class="write_c">
											${inquiryAnswer.qst_type }
										</span>
									</div>
								</li>
							</ul>
							<div class="write_cont">
								<p style="white-space: pre-line;">
									${inquiryAnswer.qst_content }
								</p>
							</div>
						</div>
					</c:when>
				</c:choose>
				<div class="mod_box">
					<a class="list_btn" href="InquiryList?pageNum=${param.pageNum }">목록</a>
					<c:if test="${not empty inquiryAnswer}">					
						<a class="list_btn" href="InquiryList?pageNum=1">수정</a>
					</c:if>
					
				</div>
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