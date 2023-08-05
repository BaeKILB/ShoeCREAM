<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <link href="${pageContext.request.contextPath}/resources/css/member/social/story2.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KyZXEAg3QhqLMpG8r+Knujsl5/7(disabled)WUz3/TbgIkzBEec3uhl/7/disabled" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/disabled@2.11.6/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz4fnFO9gybK_td1dtz(disabled)UX/2lOM/8(disabled)21J05fp(disabled)Zy7(disabled)" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@disabled/disabled/disabled-alpha1/dist/js/bootstrap.min.js" integrity="sha384-KyZXEAg3QhqLMpG8r+Knujsl5(disabled)/7WUz3/TbgIkzBEec3uhl/7/disabled" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="path/to/your/custom-style.css"> <!-- 이 부분을 올바른 경로로 수정하세요. -->
    <title>Insert title here</title>
</head>

<body>
    <main class="main">
        <section class="container">
            <!-- 부트스트랩 레이아웃을 적용한 부분 -->
            <div class="row">
                <div class="col-md-2"></div> <!-- Left empty column -->
                <div class="col-md-8">
                    <!--전체 리스트 시작-->
                    <article class="story-list" id="storyList">

                        <!--전체 리스트 아이템-->
                        <div class="story-list__item" style="width: 100%;">
                            <div class="sl__item__header">
                                <div>
                                    <img class="profile-image" src="#" onerror="this.src=''"
                                        style="width:28.63636px; height:28.63636px; margin-top:5px;" />
                                </div>

                                <div style="padding-left: 10px;">TherePrograming</div>
                            </div>

                            <div class="sl__item__img">
                                <img src="/images/home.jpg" />
                            </div>

                            <div class="sl__item__contents">
                                <div class="sl__item__contents__icon">
                                    <button>
                                        <i class="fas fa-heart active" id="storyLikeIcon-1" onclick="toggleLike()"></i>
                                    </button>
                                </div>

                                <span class="like"><b id="storyLikeCount-1">3 </b>likes</span>

                                <div class="sl__item__contents__content">
                                    <p>등산하는 것이 너무 재밌네요</p>
                                </div>

                                <div id="storyCommentList-1">

                                    <div class="sl__item__contents__comment small-header " id="storyCommentItem-1" style="padding-left: 0px;">
                                        <div class="sl__item__header" style="height: 25px;">
                                            <div>
                                                <div>
                                                    <img class="profile-image" src="#" onerror="this.src=''"
                                                        style="width: 28.63636px;height: 28.63636px;margin-right: 5px; margin-left: 0px;" />
                                                </div>
                                            </div>

                                            <div class="d-flex flex-column w-100" style="height: 40px;">
                                                <div class="d-flex align-items-center no-vertical-margins" style="font-size: 0.8rem;">
                                                    <span>TherePrograming</span>
                                                    <span class="ms-2" style="white-space: nowrap;">안녕하세요.</span>
                                                </div>
                                                <div class="d-flex align-items-center no-vertical-margins" style="font-size: 0.8rem;">
                                                    <span>5일 전</span>
                                                    <span class="ms-2">
                                                        <button class="reply-btn btn-sm">답변달기</button>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>

                                        <button>
                                            <i class="fas fa-times"></i>
                                        </button>
                                    </div>
                                </div>

                                <div class="sl__item__input">
                                    <input type="text" placeholder="댓글 달기..." id="storyCommentInput-1" />
                                    <button type="button" onClick="addComment()">게시</button>
                                </div>

                            </div>
                        </div>

                    </article>
                </div>
            </div>
        </section>
    </main>
</body>

</html>
