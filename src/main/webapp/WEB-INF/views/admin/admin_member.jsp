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
<link href="${pageContext.request.contextPath }/resources/css/admin/adminMember.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<!-- 토스트 그리드 -->
</head>
<script type="text/javascript">
	let pageNum = 1; // 기본 페이지 번호 미리 저장
	let maxPage = 1; // 최대 페이지 번호 미리 저장
	
	$(function() {
		List(pageNum);
	});
	
	function List(pageNum) {
		let searchType = $("#searchType").val();
		let searchKeyword = $("#searchKeyword").val();
		let word = "AdminMemberList?pageNum=" + pageNum + "&searchType=" + searchType + "&searchKeyword=" + searchKeyword;
		
		$.ajax({
			type: "GET",
			url: word,
			dataType: "JSON",
			data: {"pageNum": pageNum},
			success: function(data) {
				$('.tbody').empty();
				$('#pageList').empty();
	             
	             for(let member of data.memberList) {
		            	let birth = new Date(member.mem_birthday);
						$('.tbody').append(
								"<tr class='member" + member.mem_idx + "'>"
								+ "<td>"+ member.mem_idx +"</td>"
								+ "<td>"+ member.mem_id +"</td>"
								+ "<td>"+ member.mem_name +"</td>"
								+ "<td>"+ member.mem_nickname +"</td>"
								+ "<td>"+ member.mem_mtel +"</td>"
								+ "<td>"+ getFormatDate(birth) +"</td>"
// 								+ "<td>"+ member.mem_rank +"</td>"
								+ "<td><button style='cursor: pointer;' class='moreBtn' onclick='openModal(" + member.mem_idx + ");'>상세정보</button></td>"
								+ "</tr>"
						);
				 }
	             
	             if(pageNum > 1) {
	            	 $("#pageList").append(
		            	 	"<li class='pgi'>"
        					+ "<a href='#' onclick='List(1)' class='allprev'><i class='fa fa-angle-double-left pgi' aria-hidden='true'></i></a>"
		            	 	+ "</li>"
            	 	 );
	             }
	             if(pageNum > 1) {
	            	 $("#pageList").append(
		            	 	"<li class='pgi'>"
        					+ "<a href='#' onclick='List(" + (pageNum - 1) + ")' class='prev'><i class='fa fa-angle-left pgi' aria-hidden='true'></i></a>"
		            	 	+ "</li>"
            	 	 );
	             }
	             for (var num = data.startPage; num <= data.endPage; num++) {
		             word = "List("+ num + ")";
		             
	                 if (num == data.pageNum) {
	                	 $("#pageList").append(
	                		"<li>"
 	                		+ "<a href='#' onclick='List(" + num + ")' class='pageNum current'><b>" + num + "</b></a>"
	                		+ "</li>"
	                	 );
	                 } else {
	                	 $("#pageList").append(
 	                		"<li>"
 	                		+ "<a href='#' onclick='List(" + num + ")' class='pageNum'>" + num + "</a>"
 	                		+ "</li>"
	 	                 );
	                 }
	             }
	             if(pageNum < data.maxPage) {
	            	 $("#pageList").append(
		            	 "<li class='pgi'>"
    						+ "<a href='#' onclick='List(" + (pageNum + 1) + ")' class='next'><i class='fa fa-angle-right pgi' aria-hidden='true'></i></a>"
		                	+ "</a>"
		            	 	+ "</li>"
            	 	 );
	             }
	             if(pageNum < data.maxPage) {
	            	 $("#pageList").append(
		            	 "<li class='pgi'>"
		                	+ "<a href='#' onclick='List(" + data.maxPage + ")' class='allnext'>"
		                	+ "<i class='fa fa-angle-double-right pgi' aria-hidden='true'></i>"	
		                	+ "</a>"
		            	 	+ "</li>"
            	 	 );
	             }
			},
			error: function() {
				alert('데이터 불러오기 실패');
			}
		});
		
		function getFormatDate(date) {
			let year = date.getFullYear();
			let month = String(date.getMonth() + 1).padStart(2, '0');
			let day = String(date.getDate()).padStart(2, '0');
			let formattedDate = year + "-" + month + "-" + day;
			return formattedDate;
		}
	}
	
	function openModal(mem_idx) {
		$('.modal_background').css('display', 'block').animate({opacity: 1}, 200);
		$('.btn_close').on('click', function() {
	        $('.modal_background').animate({
	            opacity: 0
	        }, 200, function () {
	            $(this).css('display', 'none');
	        });
	    });
		
		$('.btn_primary').on('click', function() {
	        $('.modal_background').animate({
	            opacity: 0
	        }, 200, function () {
	            $(this).css('display', 'none');
	        });
	    });
		
		url = "MemberSelectInfo";
		$.ajax({
			type: "GET",
			url: url,
			dataType: "json",
			data: {mem_idx: mem_idx},
			success: function(data) {
				let birth = new Date(data.mem_birthday);
				let signDate = new Date(data.mem_sign_date);
				
				$('.mem_idx').empty();
				$('.mem_id').empty();
				$('.mem_name').empty();
				$('.mem_nickname').empty();
				$('.mem_mtel').empty();
				$('.mem_birthday').empty();
				$('.mem_address').empty();
				$('.mem_rank').empty();
				$('.mem_interest').empty();
				$('.mem_sign_date').empty();
				$('.mem_point').empty();
				$('.mem_balance').empty();
				$('.mem_b').empty();
				$('.mem_account_auth').empty();
				$('.mem_status').empty();
				$('.modal_footer button.mem_delete').remove();
				
				$('.mem_idx').append(data.mem_idx);
				$('.mem_id').append(data.mem_id);
				$('.mem_name').append(data.mem_name);
				$('.mem_nickname').append(data.mem_nickname);
				$('.mem_mtel').append(data.mem_mtel);
				$('.mem_birthday').append(getFormatDate(birth));
				$('.mem_address').append(data.mem_address);
				$('.mem_rank').append(
					data.mem_rank
					+ "<button style='cursor: pointer;' class='moreBtn rankup' onclick='MemberLevelUp(" + data.mem_idx + ");'>등업하기</button>"
				);
				$('.mem_interest').append(data.mem_interest);
				$('.mem_sign_date').append(getFormatDate(signDate));
				$('.mem_point').append(data.mem_point);
				$('.mem_balance').append(data.mem_balance);
				if(data.mem_account_auth == 'N') {
					$('.mem_account_auth').append('미인증');
				} else {
					$('.mem_account_auth').append('인증');
				}
				if(data.mem_status == 'Y') {
					$('.mem_status').append('회원');
				} else {
					$('.mem_status').append('탈퇴');
				}
				$('.modal_footer').prepend(
					"<button style='cursor: pointer;' class='btn_primary mem_delete' onclick='MemberDelete(" + data.mem_idx + ");'>회원 삭제하기</button>"
				);
			},
			error: function() {
				alert("정보 불러오기 실패");
			}
        });
		
		function getFormatDate(date) {
			let year = date.getFullYear();
			let month = String(date.getMonth() + 1).padStart(2, '0');
			let day = String(date.getDate()).padStart(2, '0');
			let formattedDate = year + "-" + month + "-" + day;
			return formattedDate;
		}
	}
	
// 	function MemberLevelUp(mem_idx) {
// 		url: "MemberLevelUp";
// 		$.ajax({
// 			type: "GET",
// 			url: url,
// 			dataType: "json",
// 			data: {mem_idx: mem_idx},
// 			success: function(data) {
// 				swal('등업 완료', '등업이 완료되었습니다', 'success');
				
// 			},
// 			error: function() {
// 				swal('등업 실패', '등업에 실패하였습니다', 'warning');
// 			}
// 		});
// 	}


	function MemberDelete(mem_idx) {
		Swal.fire({
			title: "회원을 삭제하시겠습니까?",
			text: "해당 회원은 DB에서 삭제처리됩니다.",
			icon: "warning",
			showCancelButton: true,
			confirmButtonText: "삭제",
			cancelButtonText: "취소",
			reverseButtons: true
		}).then((result) => {
			if (result.isConfirmed) {
				$.ajax({
					type: "GET",
					url: "MemberDelete",
					dataType: "text",
					data: {mem_idx: mem_idx},
					success: function(data) {
						if(data === "true") {
							Swal.fire('회원 삭제 완료', '회원 삭제 처리가 완료되었습니다', 'success');
							$('.modal_background').animate({
					            opacity: 0
					        }, 200, function () {
					            $(this).css('display', 'none');
					        });
							$('.member' + mem_idx).remove();
						}
					},
					error: function(data) {
						alert(data);
						Swal.fire('회원 삭제 실패', '회원 삭제 처리에 실패했습니다', 'warning');
					}
				});
			} else if(result.dismiss === Swal.DismissReason.cancel) {
				return false;
			}
		})
	}


</script>
<body>
	<aside>
		<jsp:include page="inc/sidebar.jsp" ></jsp:include>
	</aside>
	<c:set var="pageNum" value="1" />
	<c:if test="${not empty param.pageNum }">
		<c:set var="pageNum" value="${param.pageNum }" />	
	</c:if>
	<section id="admin_cont">
		<h1 class="admin_tit">회원 목록 조회</h1>
		<hr class="tit_line">
		<div class="member_cont">
			<div class="mem_list_wrap">
				<div class="search_wrap">
					<form action="AdminMember" method="get" class="searchForm">
						<select name="searchType" id="searchType">
							<option value="mem_id" <c:if test="${param.searchType eq 'mem_id' }">selected</c:if>>아이디</option>			
							<option value="mem_name" <c:if test="${param.searchType eq 'mem_name' }">selected</c:if>>이름</option>			
							<option value="mem_nickname" <c:if test="${param.searchType eq 'mem_nickname' }">selected</c:if>>닉네임</option>			
<%-- 							<option value="mem_rank" <c:if test="${param.searchType eq 'mem_rank' }">selected</c:if>>등급</option>			 --%>
						</select>
						<input type="text" name="searchKeyword" value="${param.searchKeyword }" id="searchKeyword">
						<input type="submit" value="검색" class="searchSubmit" style="cursor: pointer;">
					</form>
				</div>
				<div class="table_container">
					<table class="mem_list_table table">
						<thead>
							<tr>
								<th scope="col">회원번호</th>
								<th scope="col">아이디</th>
								<th scope="col">이름</th>
								<th scope="col">닉네임</th>
								<th scope="col">연락처</th>
								<th scope="col">생년월일</th>
<!-- 								<th scope="col">등급</th> -->
								<th scope="col">상세정보</th>
							</tr>
						</thead>
						<tbody class="tbody">
						</tbody>
					</table>
				</div>
				<ul id="pageList">
					
				</ul>
			</div>
		</div>
		<!-- 모달창 -->
		<div class="modal_background">
			<div class="modal_wrap">
				<div class="modal_box">
					<div class="modal_header">
						<div class="modal_title">회원정보 상세조회</div>
						<button type="button" class="btn_close" style="cursor: pointer;"></button>
					</div>
					<div class="modal_body">
						<div class="table_container">
							<table class="mem_list_modal_table table">
								<tr>
									<th>회원번호</th>
									<td class="mem_idx"></td>
								</tr>
								<tr>
									<th>아이디</th>
									<td class="mem_id"></td>
								</tr>
								<tr>
									<th>이름</th>
									<td class="mem_name"></td>
								</tr>
								<tr>
									<th>닉네임</th>
									<td class="mem_nickname"></td>
								</tr>
								<tr>
									<th>연락처</th>
									<td class="mem_mtel"></td>
								</tr>
								<tr>
									<th>생년월일</th>
									<td class="mem_birthday"></td>
								</tr>
								<tr>
									<th>주소</th>
									<td class="mem_address"></td>
								</tr>
								<tr>
									<th>관심분야</th>
									<td class="mem_interest"></td>
								</tr>
<!-- 								<tr> -->
<!-- 									<th>등급</th> -->
<!-- 									<td class="mem_rank"></td> -->
<!-- 								</tr> -->
								<tr>
									<th>가입일</th>
									<td class="mem_sign_date"></td>
								</tr>
								<tr>
									<th>계좌 인증 상태</th>
									<td class="mem_account_auth"></td>
								</tr>
								<tr>
									<th>포인트</th>
									<td class="mem_point"></td>
								</tr>
								<tr>
									<th>계좌 잔액</th>
									<td class="mem_balance"></td>
								</tr>
								<tr>
									<th>가입 상태</th>
									<td class="mem_status"></td>
								</tr>
							</table>
						</div>
					</div>
					<div class="modal_footer">
						<button class="btn_primary">Close</button>
					</div>
				</div>
			</div>
		</div>
	</section>
	<script>
		$(document).ready(function() {
			$('.cont_li_wrap.memList').show();
			$('.cont_item_list.memList').addClass('active');
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