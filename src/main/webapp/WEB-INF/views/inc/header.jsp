<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script>
let socket = null;

$(function () {
    if (${sId} > 0) {
        connectWs();
    }
});

function connectWs() {
    let wsUrl = "<c:url value='/alram'/>"; // 웹소켓 엔드포인트 URL 설정
    const maxRetries = 5;
    let currentRetries = 0;

    function initWs() {
        const ws = new SockJS(wsUrl);
        socket = ws;

        ws.onopen = function () {
            console.log("open");
            currentRetries = 0;
        };

        ws.onmessage = function (event) {
            alert(event.data);
            let $socketAlert = $('div#socketAlert');
            $socketAlert.html(event.data);
            $socketAlert.css('display', 'block');

            setTimeout(function () {
                $socketAlert.css('display', 'none');
            }, 5000);
        };

        ws.onclose = function () {
            console.log('close');
            if (currentRetries < maxRetries) {
                setTimeout(() => {
                    console.log('Retrying WebSocket...');
                    currentRetries++;
                    initWs();
                }, 2000 * (currentRetries ** 2));
            } else {
                console.error('WebSocket reconnection attempts exceeded.');
            }
        };

        ws.onerror = function (error) {
            console.error('WebSocket error:', error);
        };
    }

    initWs();
};
</script>
<script>
// 로그인
const login = () => {
    location.href="login";
}

// 회원가입
const signup = () => {
    location.href="signup";
}

const registerForm = () => {
    location.href="RegisterForm";
}
</script>

<!DOCTYPE html>
<main>
    <span id="memberPannel">
        <button onclick="registerForm()">판매하기</button>
        <button onclick="login()">로그인</button>
        <button onclick="signup()"> 회원가입</button>
    </span>
</main>
