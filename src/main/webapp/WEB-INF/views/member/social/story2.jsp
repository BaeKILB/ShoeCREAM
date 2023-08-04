<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%-- 	<jsp:include page="../../inc_ex/header_social.jsp" /> --%>
<%@ include file="../layout/header.jsp"%>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/main_ex/market/common.css">
   <!-- 부트스트랩 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <!--    구글 머터리얼 아이콘   -->
    <link href="https://fonts.googleapis.com/css?family=Material+Icons|Material+Icons+Outlined|Material+Icons+Two+Tone|Material+Icons+Round|Material+Icons+Sharp"
          rel="stylesheet">
    <link rel="stylesheet"
          href="https://fonts.sandbox.google.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200"/>
    <!--    jQuery-->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<style>
    /*메뉴바 우측 상단 미니프로필*/
    .mini-profile {
        width: 24px;
        height: 24px;
        border-radius: 70%;
        overflow: hidden;
    }

    /*스토리 라인 프로필*/
    .story-profile {
        width: 65px;
        height: 65px;
        border-radius: 70%;
        position: relative;
        border: 3px solid transparent;
        background-image: linear-gradient(#fff, #fff),
        linear-gradient(to left, #b347ab, #d42694, orange 100%);
        background-origin: border-box;
        background-clip: content-box, border-box;
        /*overflow: hidden;*/
    }

    /*스토리 박스*/
    .story-box {
        height: 119px;
        border: solid 1px #dbdbdb;
        display: flex;
        border-radius: 2px;
        justify-content: space-around;
        background-color: white;
        font-weight: lighter;
        font-size: 11px;
        color: #696868;
        text-align: center;
    }

    .story-name {
        margin-top: 5px;
    }

    /*피드박스 좌측 상단 미니프로필*/
    .box-profile {
        width: 30px;
        height: 30px;
        border-radius: 70%;
        overflow: hidden;
    }

    /*프로필사진들*/
    .profile {
        width: 100%;
        height: 100%;
        object-fit: cover;
    }

    /*슬라이드 이미지*/
    .carousel-item {
        width: 100%;
        height: 600px;
    }

    .d-block {
        display: block;
        width: 100%;
        height: 600px;
        object-fit: cover;
        overflow: hidden;
    }

    /*댓글창*/
    input:focus {
        outline: none;
        border: none;
    }

    /*왼쪽 메인화면 프로필*/
    .left-profile {
        width: 55px;
        height: 55px;
        border-radius: 70%;
        overflow: hidden;
    }

    /*왼쪽 메인화면 추가정보프로필*/
    .left-mini-profile {
        width: 37px;
        height: 37px;
        border-radius: 70%;
        overflow: hidden;
    }

    /*상단 스토리 이미지*/
    .rounded-circle {
        padding: 2px;

    }


    /*피드 박스*/
    .feed-box {
        border: solid 1px #dbdbdb;
        border-radius: 2px;
        margin-top: 30px;
        background-color: white;
    }

    /*추천회원*/
    .rec-member {
        align-items: center;
        display: flex;
        margin-top: 2px;
    }

    a {
        text-decoration: none;
        color: black;
    }

    .modal-overlay {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        display: none;
        z-index: 1;
        background-color: rgba(0, 0, 0, 0.4);
        animation: showText1 0.5s;
    }

    .modal_body {
        position: absolute;
        top: 50%;
        left: 50%;
        width: 400px;
        height: 330px;
        text-align: center;
        background-color: rgb(255, 255, 255);
        border-radius: 10px;
        box-shadow: 0 2px 3px 0 rgba(34, 36, 38, 0.15);
        transform: translateX(-50%) translateY(-50%);
        font-size: 13px;
        display: flex;
        flex-direction: column;
        justify-content: space-evenly;
        line-height: 50px;
    }

    .modal-text {
        border-bottom: 0;
        border-left: 0;
        border-right: 0;
        border-top: 1px solid #dbdbdb;
        background-color: white;
    }

    @keyframes showText1 {
        from {
            transform: translateX(0px);
            opacity: 0;
        }

        to {
            transform: translateX(0px);
            opacity: 1;
        }
    }

    @media screen and (max-width: 640px) {

        html {
            /*background: red;*/

        }

        .aLayer {
            /*padding: 1.0em;*/
            display: none;

        }

    }

    @media screen and (max-width: 1000px) {

        html {
            /*background: red;*/

        }

        .bLayer {
            /*padding: 1.0em;*/
            display: none;

        }

    }

    @media screen and (max-width: 640px) {

        html {
            /*background: red;*/

        }

        .cLayer {
            width: 90%;
            height: 60%;
            overflow: hidden;


        }

    }


</style>

<main class="main">
	<section class="container">
		<!--전체 리스트 시작-->
		<article class="story-list" id="storyList">


		</article>
	</section>
</main>
<script src="${pageContext.request.contextPath }/resources/js/member/social/story2.js"></script>
	<!-- 푸터 시작 -->
<%-- 	<jsp:include page="../../inc_ex/footer.jsp" /> --%>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
        crossorigin="anonymous"></script>
</body>
</html>
