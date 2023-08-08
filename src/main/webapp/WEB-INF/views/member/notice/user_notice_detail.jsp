<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath }/resources/css/admin/common.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/admin/adminMain.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/admin/notice_detail.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/notice/user_notice.css" rel="stylesheet" type="text/css">
</head>
<body>
<jsp:include page="../../inc_ex/header.jsp" />	
	<h1 class="admin_tit">공지사항</h1>
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
	                                </div>
	                            </li>
	                        </ul>
	                        <div class="write_cont">
	                            <p style="white-space: pre-line;">${noticeDetail.bo_content }</p>
	                        </div>
	                    </div>
	                </div>
	            </div>
	        </div>
	</body>
</html>