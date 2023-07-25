// 아이디 유효성 검사
var idC = false;

function validateId() {
    const mem_id = document.getElementById("mem_id").value.trim();
    const span = document.querySelector("#idError");

    if (!/^[A-Za-z0-9]{2,20}$/.test(mem_id)) {
        span.innerHTML = "아이디는 2자 이상 20자 이내의 영문자, 숫자로만 구성해주세요.";
        idC = false;
    } else {
        span.innerHTML = "";
        idC = true;
    }
}

function checkConstraints() {
    if (!idC) {
        document.getElementById("mem_id").focus();
    }
}

// 중복 확인 함수
//function checkDuplicateId() {
//    const mem_id = document.getElementById("mem_id").value.trim();
//
//    if (mem_id !== '' && idC) {
//        $.ajax({
//            type: "get",
//            url: "idCheck",
//            data: {
//                "mem_id": mem_id
//            }
//        }).done(function (result) {
//            // 아이디가 중복되었을 때
//            if (result == "1") {
//                $("#idError").html(mem_id + "은 등록되어있는 아이디입니다.");
//                $("input[name=mem_id]").val('').focus();
//            } else {
//                $("#idError").html(""); // 중복되지 않았을 경우, 결과 메시지를 제거합니다.
//            }
//        });
//    } else {
//        checkConstraints();
//    }
//}

// 페이지 로드 시 이벤트 리스너를 추가합니다.
$(document).ready(function () {
    $("input[name=mem_id]").on("input", validateId);
    $("input[name=mem_id]").on("focusout", checkDuplicateId);
});


//var idC = false;
//
//function validateId() {
//    const mem_id = document.getElementById("mem_id").value.trim();
//    const span = document.querySelector("#idError");
//
//    if (!/^[A-Za-z0-9]{2,20}$/.test(mem_id)) {
//        span.innerHTML = "아이디는 2자 이상 20자 이내의 영문자, 숫자로만 구성해주세요.";
//        document.getElementById("mem_id").focus();
//        idC = false;
//    } else {
//        span.innerHTML = "";
//        idC = true;
//    }
//}
//
//$(document).ready(function () {
//    let isChecked = false;
//
//    $("input[name=mem_id]").on("blur", function () {
//        const mem_id = $(this).val();
//
//        if (mem_id !== '') {
//            $.ajax({
//                type: "get",
//                url: "idCheck",
//                data: {
//                    'mem_id': mem_id
//                }
//            }).done(function (result) {
//                // 아이디가 중복되었을 때
//                if (result == '1') {
//                    // jQuery 선택자를 #idError로 변경하여 결과를 표시합니다.
//                    $("#idError").html(mem_id + "은 등록되어있는 아이디입니다.");
//                    $("input[name=mem_id]").val('').focus();
//                    isChecked = false;
//                } else {
//                    $("#idError").html(''); // 중복되지 않았을 경우, 결과 메시지를 제거합니다.
//                    isChecked = true;
//                }
//            });
//        }
//    });
//});



//let check = false; //submit 단계에서 확인할 변수
//
//
////이메일 시도
//var emailC = false;
//function checkEmail() {
//  var memEmail = document.getElementById("mem_id").value;
//  var emailError = document.getElementById("emailError");
//
//  if (validateEmail(memEmail)) {
//    emailError.textContent = '';
//    emailC = true;
//  } else {
//    emailError.textContent = '메일 주소를 정확히 입력하세요.';
//    emailC = false;
//  }
//}
//
//function validateEmail(email) {
//  const re = /([!#-'+/-9=?A-Z^-~-]+(.[!#-'+/-9=?A-Z^-~-]+)|"([]!#-[^-~ \t]|([\t -~]))+")@([!#-'+/-9=?A-Z^-~-]+(.[!#-'+/-9=?A-Z^-~-]+)|[[\t -Z^-~]*])+$/;
//  const hasKorean = /[ㄱ-ㅎㅏ-ㅣ가-힣]/;
//  return re.test(String(email).toLowerCase()) && !hasKorean.test(email);
//}
//
//
////이메일 중복확인 - alert으로 중복창 띄움
//function checkId(){
// var id = $('#mem_id').val(); //id값이 "id"인 입력란의 값을 저장
// $.ajax({
//     url:'./idCheck', //Controller에서 요청 받을 주소
//     type:'post', //POST 방식으로 전달
//     data:{id:id},
//     // 실제 count가 아니고 다른 형태의 data가 넘어오니, 구분을 위해 이름을 변경함
//     success:function(data){ //컨트롤러에서 넘어온 cnt값을 받는다 
//         const count = data;
//         if(count !== 0){ //cnt가 1이 아니면(=0일 경우) -> 사용 가능한 아이디 
//             //$('.id_already').css("display");  //,"inline-block" 추가 여부 확인해야함
//             alert("이미 사용중인 이메일 입니다.");
//             $('#mem_id').val('');
//             check = false;
//         }
//     },
//     error:function(){
//         alert("에러입니다");
//     }
// });
//};
//
//
//
////비밀번호 유효성 검사
//var passC = false;
//function validatePw() {
//  var memPw = document.getElementById("mem_passwd").value;
//  var pwError = document.getElementById("passwordError");
//
//  if (validatePassword(memPw)) {
//    pwError.textContent = '';
//    passC = true;
//  } else {
//    pwError.textContent = '영문, 숫자, 특수문자 포함 8~20글자 이상 입력해주세요.';
//    passC = false;
//  }
//}
//
//function validatePassword(password) {
//  const re = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,20}$/;
//  return re.test(password);
//}
//
////비밀번호 중복 확인검사 
//
//var passD = false;
//function passwordConfirm() {
//  var passwd = document.getElementById("mem_passwd").value;
//  var repeatPasswd = document.getElementById("passwordCheck").value;
//  var span = document.querySelector("#passwordCheckError");
//  if (passwd != repeatPasswd) {
//	span.innerHTML= '패스워드가 일치하지 않습니다.'; 
//    passD = false;
//  }else{
//	span.innerHTML= '';
//    passD = true;
//}
//
//}
//
////이름 확인 한글만,2글자 이상 10글자 미만, 자음,모음만 입력 안됨
//var nameC = false;
//function validateName(){
//	const name = document.getElementById("mem_name").value.trim();
//	const span = document.querySelector("#nameError");
//  		if (!/^[\uAC00-\uD7A3]{2,10}$/.test(name) || /[\u314F-\u3163]/.test(name)) {
//		    span.innerHTML= '유효한 이름을 입력 해 주세요'
//		    name.value = "";//얘네 왜 안될까 
//		    document.getElementById("mem_name").focus();//얘네 왜 안될까 
//		    nameC = false;}
//		    else{
//		 	span.innerHTML= '';
//		 	nameC = true;
//			}
//}
//
//생년월일 선택 max 오늘이후 선택 불가
let maxDate;
$(function(){
    $('[type="date"]').prop('max', function(){
        maxDate = new Date().toJSON().split('T')[0];
        return maxDate;
    });
});
//
var birC = false;
function validateBirth(){
	const birthDate = document.getElementById("mem_birthday").value;
	
	const span = document.querySelector("#birthError");
	console.log(birthDate);
	if(birthDate<'1900-01-01'||birthDate>maxDate){
		span.innerHTML= '유효한 생년월일을 입력해 주세요';
		document.getElementById("mem_birthday").value = "";
		birC = false;
	}else{
		span.innerHTML= '';
		birC = true;
	}
}
//
//주소찾기 
function sample6_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }
                // 조합된 참고항목을 해당 필드에 넣는다.
                document.getElementById("sample6_extraAddress").value = extraAddr;
            
            } else {
                document.getElementById("sample6_extraAddress").value = '';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('sample6_postcode').value = data.zonecode;
            document.getElementById("sample6_address").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("sample6_detailAddress").focus();
        }
    }).open();
}
//
//
//// 휴대폰 번호 입력 부분
//function changePhone1(){
//    const phone1 = document.getElementById("phone1").value // 010
//    if(phone1.length === 3){
//        document.getElementById("phone2").focus();
//        check = true;
//    }
//}
//
//function changePhone2(){
//    const phone2 = document.getElementById("phone2").value // 010
//    if(phone2.length === 4){
//        document.getElementById("phone3").focus();
//        
//        check = true;
//    }
//}
//
//function changePhone3(){
//    const phone3 = document.getElementById("phone3").value // 010
//    if(phone3.length === 4){
//      document.getElementById("sendMessage").focus();
//      document.getElementById("sendMessage").setAttribute("style","background-color:#F0F0F0;")
//      document.getElementById("sendMessage").disabled = false;
//      
//      check = true;
//    }
//    
//}
//
////핸드폰 번호 유효성 검사 및 인증번호 전송
//function sendMsg(){
//	var phone =$("#phone1").val()+"-"+$("#phone2").val()+"-"+$("#phone3").val();
//	//패턴 확인용
//	var patternPhone = /^010-(?!0*(\d)\1{3})[1-9]\d{3}-\d{4}$/;
////	var patternPhone = /^01[01]-[^0][0-9]{2,3}-[0-9]{3,4}/;
//	
//	 if(!patternPhone.test(phone)){
//		alert('유효한 핸드폰 번호를 입력 해 주세요.')
//   		document.getElementById("sendMessage").disabled = true;
//		document.getElementById("phone1").value = ""; // phone1 입력란 내용 지우기
//		document.getElementById("phone2").value = ""; // phone1 입력란 내용 지우기
//		document.getElementById("phone3").value = ""; // phone1 입력란 내용 지우기
//   		document.getElementById("phone1").focus();
//   		
//   		return false;
//		}else{
//	  $.ajax({ //중복 확인 시작
//	     url:'./phondCheck', //Controller에서 요청 받을 주소
//	     type:'post', //POST 방식으로 전달
//	     data:{phone:phone},
//		 success:function(data){ //컨트롤러에서 넘어온 cnt값을 받는다 
//         const count = data;
//	         if(count == 0){ //cnt가 0일경우 -> 사용 가능한 아이디 
//	             $.ajax({//메세지 전송 시작
//				     url:'./send-phone-authentication', //Controller에서 요청 받을 주소
//				     type:'post', //POST 방식으로 전달
//				     data:{phone:phone},
//				     success:function(phone){ 
//				    	 console.log("서버 응답 데이터:", phone); // 디버깅용 로그 출력
//				          alert("인증번호가 전송되었습니다.");
//				          $("#cert").attr("disabled", false);
//				          $("#certifyCheck").attr("disabled", false);
//				          $("#phone1").attr("readonly", true);
//				          $("#phone2").attr("readonly", true);
//				          $("#phone3").attr("readonly", true);
//				          //타이머 작동
//				          startTimer();
//	          
//	         			  return true;
//			    					 },
//				     error:function(){
//				         alert("에러입니다");
//				     }
// 						});
//        	   }else{
//				  alert("이미 사용중인 번호 입니다.");
//	              $('#phone1').val('');
//	              $('#phone2').val('');
//	              $('#phone3').val('');
//				  $('#phone1').focus();
//    			  check = false;}
//    		 },
//	     error:function(){
//	         alert("에러입니다");
//	     }
// 		});
//	};
//}
//	
//
////인증번호 확인
//var vCheck = false;
//function verifyCode(){
//	var newCode = $("#cert").val()
//	 $.ajax({
//     url:'./verify-phone-authentication', //Controller에서 요청 받을 주소
//     type:'post', //POST 방식으로 전달
//     data:{newCode:newCode},
//     success:function(data){ 
//   	  const isCorrectCode = data;	
//   	  if(isCorrectCode == true){
//         alert("인증 되었습니다.");
//         
//         vCheck =  true;
//		}else{
//		alert("인증번호가 일치하지 않습니다.")
//		
//		 check =  false;
//		}
//     },
//     error:function(){
//         alert("에러입니다");
//     }
// });	
//}
//
////타이머
//let timer; // 타이머 변수
//
//function startTimer() {
//  let seconds = 180; // 타이머 초기 시간 (3분)
//  timer = setInterval(function() {
//    let minutes = Math.floor(seconds / 60);
//    let remainingSeconds = seconds % 60;
//
//    // 타이머 시간을 cert 칸에 표시
//    document.getElementById("cert").placeholder = minutes + "분 " + remainingSeconds + "초 남았습니다.";
//
//    if (seconds <= 0) {
//      // 타이머 시간 초과
//      clearInterval(timer);
//      alert("시간이 초과되었습니다.");
//      document.getElementById("cert").disabled = true; // memberPhoneCertify 칸 비활성화
//      document.getElementById("cert").placeholder = "인증번호를 입력 해주세요"; 
//    }else if(vCheck == true){
//	  clearInterval(timer);
//      document.getElementById("cert").disabled = true; // memberPhoneCertify 칸 비활성화
//      document.getElementById("cert").value; 
//	
//}
//
//    seconds--;
//  }, 1000);
//}
//
//
//
//// 회원가입 버튼
//
//function signUpCheck(){
//  let email = document.getElementById("mem_id").value
//  let password = document.getElementById("mem_passwd").value
//  let passwordCheck = document.getElementById("passwordCheck").value
//  let name = document.getElementById("mem_name").value
//  let phone1 = document.getElementById("phone1").value
//  let phone2 = document.getElementById("phone2").value
//  let phone3 = document.getElementById("phone3").value
//  let addr1 = document.getElementById("sample6_postcode").value
//  let addr2 = document.getElementById("sample6_address").value
//  let birthDate = document.getElementById("mem_birthday").value
////  let check = true;
//
//  // 이메일 확인
//  if (email === "") {
//    alert("이메일을 입력해 주세요");
//    document.getElementById("mem_id").focus();
//    return;
//  } else if(emailC==false){
//	document.getElementById("mem_id").focus();
//	birthDate == "";
//	return;
//}
//
//
//  // 비밀번호 확인
// 
//  if (password === "") {
//    document.getElementById("mem_passwd").focus();
//    alert("비밀번호를 입력해 주세요.");
//    return;
//  } else if(passC==false){
//    document.getElementById("mem_passwd").focus();
//    return;
//  }
//
//  if (passwordCheck === "") {
//    alert("비밀번호 확인을 입력해 주세요.");
//    document.getElementById("passwordCheck").focus();
//    return;
//  }else if(passD==false){
//    document.getElementById("passwordCheck").focus();
//    return;
//  }
//  
//   if (password !== passwordCheck) {
//    alert("동일한 비밀번호를 입력해 주세요");
//    document.getElementById("passwordCheck").focus();
//    return;
//  } else if(passD==false){
//    document.getElementById("passwordCheck").focus();
//    return;
//  }
//
//  // 이름 확인
//  if (name === "") {
//    alert("이름을 입력해 주세요");
//    document.getElementById("mem_name").focus();
//    return;
//
//
//ementById("mem_name").focus();
//    return;
//}
//
//  //생년월일 확인 
//    if (birthDate === "") {
//    alert("생년월일을 입력해 주세요");
//    document.getElementById("birthDate").focus();
//    return;
//  } else if(birC == false){
//    document.getElementById("mem_name").focus();
//    return;
//}
//  // 주소 확인
//  if (addr1 === "" && addr2 === "") {
//    alert("주소를 입력해 주세요.");
//    document.getElementById("sample6_postcode").focus();
//    return;
//  } 
//
//
//  // 핸드폰 번호 확인
//  if (phone1 === "" || phone2 === "" || phone3 === "") {
//    document.getElementById("phone1").focus();
//    alert("핸드폰 번호를 입력해 주세요.");
//    return;
//  }
//
//  // 인증 확인
//  if (phone1 !== "" && phone2 !== "" && phone3 !== "" && vCheck === false) {
//    document.getElementById("phone1").focus();
//    alert("핸드폰 인증을 진행해 주세요.");
//    return;
//  }
//
//    // 모든 항목이 유효할 때 폼 제출
//    document.getElementById("fr").submit();
//    alert("회원가입이 완료되었습니다.");
//  }
//
//  