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
<script>
	function DeleteConfirm(qst_idx, pageNum) {
		Swal.fire({
			title: "답변을 삭제하시겠습니까?",
			text: "해당 답변은 DB에서 삭제처리됩니다.",
			icon: "warning",
			showCancelButton: true,
			confirmButtonText: "삭제",
			cancelButtonText: "취소",
			reverseButtons: true
		}).then((result) => {
			if (result.isConfirmed) {
				$.ajax({
					type: "GET",
					url: "InquiryDelete",
					dataType: "text",
					data: {qst_idx: qst_idx, pageNum: pageNum},
					success: function(data) {
						if(data === "true") {
							Swal.fire({
							  title: '답변 삭제 완료',
							  text: "답변 삭제 처리가 완료되었습니다",
							  icon: 'success',
							  showCancelButton: false,
							  confirmButtonColor: '#3085d6',
							  cancelButtonColor: '#d33',
							  confirmButtonText: '확인'
							}).then((result) => {
							  if (result.isConfirmed) {
								  location.href = "QstBoardDetail?qst_idx=" + qst_idx + "&pageNum=" + pageNum;
								  location.reload();
							  }
							})
						}
					},
					error: function(data) {
						Swal.fire('회원 삭제 실패', '회원 삭제 처리에 실패했습니다', 'warning');
					}
				});
			} else if(result.dismiss === Swal.DismissReason.cancel) {
				return false;
			}
		})
	}
</script>
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
				
				<c:choose>
					<c:when test="${empty inquiryAnswer}">
						<form action="QstWritePro" method="post">
							<input type="hidden" name="qst_idx" value="${inquiry.qst_idx }">
							<input type="hidden" name="mem_idx" value="${inquiry.mem_idx }">
							<input type="hidden" name="mem_name" value="${inquiry.mem_name }">
							<input type="hidden" name="qst_type" value="${inquiry.qst_type }">
							<input type="hidden" name="qst_pass" value="${inquiry.qst_pass }">
							<input type="hidden" name="qst_board_re_ref" value="${inquiry.qst_board_re_ref }">
							<input type="hidden" name="pageNum" value="${param.pageNum }">
							<div class="list_wrap modify">
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
									<input type="submit" class="list_btn" value="답변하기">
									<a class="list_btn" href="InquiryList?pageNum=${param.pageNum }">목록</a>
								</div>
							</div>
						</form>
					</c:when>
				</c:choose>
				
				<c:if test="${not empty inquiryAnswer}">	
					<div class="mod_box">
						<a class="list_btn" href="InquiryList?pageNum=${param.pageNum }">목록</a>
						<a class="list_btn" href="QstModifyForm?qst_idx=${inquiry.qst_idx }&pageNum=${param.pageNum }">수정</a>
						<a class="list_btn" href="#" onclick="DeleteConfirm(${inquiry.qst_idx }, ${param.pageNum });">삭제</a>
					</div>
				</c:if>
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