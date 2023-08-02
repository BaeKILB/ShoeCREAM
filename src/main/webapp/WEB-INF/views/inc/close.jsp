<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${empty param.msg }">
	<script>
		alert("${msg}");
	</script>
</c:if>
<script>
	opener.location.reload();
	close();
</script>