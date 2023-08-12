
	Kakao.init('213752c233aa04e8fcd397b634b173be'); //발급받은 키 중 javascript키를 사용해준다.
	console.log(Kakao.isInitialized()); // sdk초기화여부판단
	//카카오로그인
	function kakaoLogin() {
	    window.Kakao.Auth.login({
	        scope: 'profile_nickname, account_email',
	        success: function (authObj) {
	            console.log(authObj);
	            window.Kakao.API.request({
	                url: '/v2/user/me',
	                success: res => {
	                    const kakao_account = res.kakao_account;
	                    console.log(kakao_account);
	                    // 서버에 전송 및 회원 가입 처리
	                    signupWithKakao(kakao_account);
	                }
	            });
	        }
	    });
	}
	
	function signupWithKakao(kakao_account) {
    // 회원 가입 처리 URL (서버에 맞게 변경해 주세요)
    const signupUrl = 'signupWithKakao';

    // FormData 객체를 생성하고 값을 채워 넣습니다.
    const formData = new FormData();
    formData.append('email', kakao_account.email);
    formData.append('nickname', kakao_account.profile.nickname);

    // 서버로 전송
    fetch(signupUrl, {
        method: 'POST',
        body: formData
    })
        .then(response => response.json())
        .then(result => {
            console.log(result);
            
            // 회원가입 결과에 따른 처리를 작성하십시오.
            // 예: 로그인 처리, 에러 메시지 출력 등
        })
        .catch(error => {
            console.error('Error:', error);
        });
}
	
	
	
	//카카오로그아웃  
	function kakaoLogout() {
	    if (Kakao.Auth.getAccessToken()) {
	      Kakao.API.request({
	        url: '/v1/user/unlink',
	        success: function (response) {
	        	console.log(response)
	        },
	        fail: function (error) {
	          console.log(error)
	        },
	      })
	      Kakao.Auth.setAccessToken(undefined)
	    }
	  }  
