// 로그인
const loginForm = () => {
	location.href="LoginForm";
}

// 회원가입
const joinForm = () => {
	location.href="JoinForm";
}

const registerForm = () => {
	location.href="RegisterForm";
}

$(function(){ // onload
	// 검색
	$("#search").on("click",function() {
		$.ajax({
			type:"get"
			, url: ""
			, dataType:"json"
			, data: {
				"searchKeyword":$("#searchKeyword").val()
			}
		})
		.done(function(data){
			console.log("성공"+data)
		})
		.fail(function() {
			console.log("실패")
		})
	});
}); // onload


