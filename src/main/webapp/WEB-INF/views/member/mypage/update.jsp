<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
   <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
   
<!DOCTYPE html>
<html lang="en">
<!-- 원본 파일 이름 member_update -->
<head>
   <meta charset="UTF-8">
   <meta http-equiv="X-UA-Compatible" content="IE=edge">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <title>마이페이지</title>
   <link href="${pageContext.request.contextPath }/resources/css/member/common.css" rel="stylesheet">
   <link href="${pageContext.request.contextPath }/resources/css/member/mem_page/mem_info_update.css" rel="stylesheet">
   <link href="${pageContext.request.contextPath }/resources/css/inc/top.css" rel="styleSheet">
   <link href="${pageContext.request.contextPath }/resources/css/inc/footer.css" rel="styleSheet">
   <script src="http://code.jquery.com/jquery-latest.min.js"></script>
   <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
   <script src="${pageContext.request.contextPath }/resources/js/inc/jquery-3.7.0.js"></script>
<script type="text/javascript">
$(function(){
     const passWd = document.getElementById("mem_passwd");
     const validateMessage = document.getElementById('passwordError');

     passWd.addEventListener("input", function() {
       const pass = passWd.value;
       if (validateEmail(pass)) {
         validateMessage.textContent = '';
       } else {
         validateMessage.textContent = '영문,숫자,특수문자 포함 8~20글자 이상 입력 해주세요.';
       }
     });
     
     function validateEmail(pass) {
       const re = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,20}$/;
       return re.test(pass);
     }
   });
   
//비밀번호 중복 확인검사 
function validatePassword() {
  var passwd = document.getElementById("mem_passwd").value;
  var repeatPasswd = document.getElementById("passwordCheck").value;
  var span = document.querySelector("#passwordCheckError");

  if (passwd != repeatPasswd) {
   span.innerHTML= '패스워드가 일치하지 않습니다.' 
   
    return false;
  }else{
   span.innerHTML= '' 
   
  return true;
}

}



</script>
<script src="${pageContext.request.contextPath }/resources/js/member/login/signup.js"></script>
   
</head>


<body>
<!--    <header> -->
<%--       <jsp:include page="../../../inc/top1.jsp"></jsp:include> --%>
		<jsp:include page="../../inc_ex/header.jsp" />
<!--    </header> -->
   <form action="MemberModify" method="post" name="fr" onsubmit='return signUpCheck();'>
   <section id="sec_con">
      <h1 class="con_title">내 정보 수정</h1>
      <div class="inq_container">
<%--          <jsp:include page="../../../inc/mem_sidebar.jsp"></jsp:include> --%>

         <div class="member-update-cont">
            <ul>
               <li>
                  <label for="name">아이디</label>
                  <div class="form-input">
                     <input type="text" name="mem_id"  class="form-control" readonly="readonly"  value="${member.mem_id }">
                  </div>
               </li>
               <li>
                  <label for="name">이름</label>
                  <div class="form-input">
                     <input type="text" name="mem_name" id="name" class="form-control" value="${member.mem_name }"  readonly="readonly">
                  </div>
               </li>
               <li>
                  <label for="name">현재 비밀번호</label>
                  <div class="form-input">
                     <input type="password" name="mem_passwd"  class="form-control" >
                  </div>
               </li>
               <li>
                  <label for="name">비밀번호 변경</label>
                  <div class="form-input">
                     <input type="password"  name="newPasswd" id="mem_passwd"  autoComplete="off" class="form-control"  placeholder="비밀변호 변경 시 입력하세요" oninput="checkPassword()">
                    <div id="passwordError" class="error"></div>
                  </div>
               
               </li>
               <li>
                  <label for="name">비밀번호 변경 확인</label>
                  <div class="form-input">
                     <input type="password" name="newPasswd1" oninput='validatePassword()'  id="passwordCheck" class="form-control" placeholder="비밀변호 변경 시 입력하세요">
                      <div id="passwordCheckError" class="error"></div>
                  </div>
               
               </li>
               <li id="mem_birthday"><label for="name">생년월일</label>
                  <div class="form-input">
                     <div class="form-select">
                           <select name="mem_bir1" class="form-control birthYear1" id="birthYear">
                              <option value="">생년</option>
                              <c:forEach var="i" begin="1943" end="2023">
                                 <option value="${i}"<c:if test="${member.mem_bir1 eq i }">selected</c:if>>${i}</option>
                              </c:forEach>
                           </select>
                           -
                           <select name="mem_bir2" title="월" class="form-control birthMonth" id="birthMonth">
                           <option value="">월</option>
                              <c:forEach var="i" begin="1" end="12">
                                 <option value="${i}" <c:if test="${member.mem_bir2 eq i }">selected</c:if>>${i}</option>
                              </c:forEach>
                           </select>
                           -
                           <select name="mem_bir3"  title="일" class="form-control birthMonth" id="birthDay">
                              <option value="">일</option>
                              <c:forEach var="i" begin="1" end="31">
                                 <option value="${i}" <c:if test="${member.mem_bir3 eq i }">selected</c:if>>${i}</option>
                              </c:forEach>
                           </select>
                     </div>
                  </div>
               </li>
               <li id="call_num">
                  <label for="name">휴대폰번호</label>
                  <div class="form-input">
                     <div class="form-select">
                        <select name="phone1" title="월" id="phoneType" class="form-phone" value="${member.phone1}"  readonly="readonly">
                           <option value="010">010</option>
                           <option value="011">011</option>
                           <option value="016">016</option>
                           <option value="017">017</option>
                           <option value="018">018</option>
                           <option value="019">019</option>
                        </select>
                        -
                        <input type="text" name="phone2" id="phone2" type="text" maxlength="4" class="form-phone1" value="${member.phone2}" readonly="readonly">
                        -
                        <input type="text" name="phone3" id="phone3" type="text" maxlength="4" class="form-phone1" value="${member.phone3}" readonly="readonly"
                        
                        \
                        >
                     </div>
                  </div>
               </li>

               <li id="ad">
                  <label for="name">주소</label>
                    <div class="addr">
                        <input id="sample6_postcode" name="sample6_postcode" type="text" placeholder="우편번호" value="${member.sample6_postcode}" >
                        <input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
                        <input type="text" id="sample6_address" name="sample6_address" placeholder="주소"  value="${member.sample6_address}"><br>
                     <input type="text" id="sample6_detailAddress"  name="sample6_detailAddress" placeholder="상세주소"  value="${member.sample6_detailAddress}">
                     <input type="text" id="sample6_extraAddress"  name="sample6_extraAddress"  placeholder="참고항목" value="${member.sample6_extraAddress}">
                        <div id="nameError" class="error"></div>
                    </div>
               </li>
            </ul>
            <div class="btn_info_update cr">
               <input type="submit" alt="회원정보수정" value="수정하기" class="upd_btn" >
            </div>
         </div>
      </div>
   </section>
   </form>
<!--    <footer> -->
<%--       <jsp:include page="../../../inc/footer.jsp"></jsp:include> --%>
<!--    </footer> -->
	<script type="text/javascript">
	   
	function signUpCheck() {

		let password = document.getElementById("mem_passwd").value
	    let passwordCheck = document.getElementById("passwordCheck").value
	    
	    if(password != null && passwordCheck != null && password != "" && passwordCheck != "" ){
		    if (!validatePassword(password) || !validatePassword(passwordCheck) ) {
		      alert('영문,숫자,특수문자 포함 8~20글자 이상 입력 해주세요.');
		      return false;
		    }	    	
	    }
		return true;
	}  
	</script>
</body>

</html>