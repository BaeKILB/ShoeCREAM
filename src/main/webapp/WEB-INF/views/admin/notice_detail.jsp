<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath }/resources/css/admin/common.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/admin/adminMain.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/admin/notice_detail.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>
<script type="text/javascript">
	function deleteConfirm() {
		if(!confirm("게시글을 삭제 하시겠습니까?")) {
			
			return false;
		} else {
			
			location.href="noticeDelete?bo_idx=${noticeDetail.bo_idx }";
		}
	}
</script>
</head>
<body>
    <aside>
        <jsp:include page="inc/sidebar.jsp" ></jsp:include>
    </aside>
    <section id="admin_cont">
        <h1 class="admin_tit">공지사항</h1>
        <hr class="tit_line">
        <div class="board_cont">
            <div class="board_list_wrap">
                <div>
                    <div class="dropdown_head">${noticeDetail.bo_title }</div>
                </div>
                <div class="wrapper">
                    <input type="hidden" name="pageNum" value="${cri.pageNum }">
                    <input type="hidden" name="amount" value="${cri.amount }">
                    <div class="list_wrap">
                        <ul class="list">
                            <li class="write_info">
                                <div class="write_box">
                                    <span class="">[작성자명 : 관리자]</span>
                                    <span class="write_t">&nbsp;&nbsp;등록일 :</span> <span class="write_c">
                                        <fmt:formatDate value="${noticeDetail.bo_sysdate }" pattern="yyyy-MM-dd" /></span>
                                </div>
                            </li>
                        </ul>
                        <div class="write_cont">
                            <p style="white-space: pre-line;">${noticeDetail.bo_content }</p>
                        </div>
                        <div class="mod_box">
                            <a class="moreBtn" href="NoticeList?pageNum=${cri.pageNum }">목록</a>
                            <%--  <c:if test="${sessionScope.sId eq 'admin@admin.com' }">      --%>
                            <a class="moreBtn" href="noticeModify?pageNum=${cri.pageNum }&bo_idx=${noticeDetail.bo_idx }">수정</a>
                            <a class="moreBtn" href="#" onclick="deleteConfirm()">삭제</a>
                            <%--  </c:if> --%>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
	    <script>
		$(document).ready(function() {
	        $('.cont_li_wrap.notList').show();
	        $('.cont_item_list.notList').addClass('active');
	    });
	        $(document).on('click', '.toggle_wrap', function() {
	            if ($('#admin_cont').css('margin-left') === '0px') {
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