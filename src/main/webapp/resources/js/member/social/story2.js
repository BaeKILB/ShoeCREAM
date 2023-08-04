/**
	2. 스토리 페이지
	(1) 스토리 로드하기
	(2) 스토리 스크롤 페이징하기
	(3) 좋아요, 안좋아요
	(4) 댓글쓰기
	(5) 댓글삭제
 */
 // 현재 로그인 한 유저의 mem_idx
 let principalId = $("#principalId").val();
 console.log("로그인한 유저 :", principalId)
 
 
$(document).ready(function () {
    // 스크롤 이벤트 초기화
    initScrollEvent();
});

// 스크롤바 이벤트
function initScrollEvent() {
    let pageNum = 1; // 현재 페이지 번호를 저장
    let maxPage = 1; // 최대 페이지 번호

    $(window).on("scroll", function () { // 스크롤 이벤트 핸들러
//    	console.log("윈도우 scrollTop",$(window).scrollTop());
//		console.log("문서의 높이",$(document).height());
//		console.log("윈도우 높이",$(window).height());
        let scrollTop = $(window).scrollTop();
        let windowHeight = $(window).height();
        let documentHeight = $(document).height();

        if (scrollTop + windowHeight >= documentHeight - 1) { // 마지막 페이지가 아니라면
            pageNum++; // 페이지 번호 증가
            storyLoad(pageNum); // 새로운 내용 로드
        }
    });
}

// 스토리 로드하기
function storyLoad(pageNum) {
    let url;
    url = "/shoecream/api/image?pageNum=" + pageNum;
    $.ajax({
        url: `${url}`,
        dataType: "json"
    }).done(res => {
        // 가장 마지막 페이지가 될 경우 페이징을 중지합니다.
        if (res.data.length === 0) {
            maxPage = pageNum;
        }
        
        res.data.forEach((image) => {
            let storyItem = getStoryItem(image);
            $("#storyList").append(storyItem);
        });
    }).fail(error => {
        console.log("오류", error);
    });
}

storyLoad(1); // 첫 번째 페이지 내용 로드

function getStoryItem(image) {

//var contextPath = "${pageContext.request.contextPath}";
//var imagePath = "${image.posts_image1}";
//    let contextPath = "C:/Users/kikir/Documents/itwill/workspace_spring5/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/ShoeCREAM/resources/upload/social/";
//    let contextPath = "/resources/upload/social/";

	let item = `<!------------------------중앙레이아웃-------------------------------------------------------------------------------->
<div style="display: flex; flex-direction: row; position: relative; justify-content: center; top: 85px;">
    <!----------------왼 쪽메인화면창--------------------------------------------------------------------------------->
    <div  class = "cLayer" style="max-width: 600px; width: 100%; max-height: 3000px; height: 100%; position: relative; font-size: 13px; font-weight: bold;">
			<!--전체 리스트 아이템-->
        <!--            첫번째 피드!------------------------------------------------------------------------------------>
        <div class="feed-box">
            <!--                상단의 이미지와 이름 그리고 ''' 아이콘-------------------------------------------------->
            <div style="display: flex; align-items: center; justify-content: space-between; margin-top: 2%; margin-left: 1%; margin-bottom: 2%;">
                <div style="display: flex; align-items: center">
                    <div class="box-profile">
                        <a href=""><img class="profile"
                                        src="https://blog.kakaocdn.net/dn/b0ZMMh/btq4eKTyBG4/aVgQqfsq543UByfJSaK0cK/img.jpg"></a>
                    </div>
                    <div style="margin-left: 10px">
                        BoYoung
                    </div>
                </div>
                <div>
                    <button id="open-modal" class="btn-open-popup" style="border: none; background-color: white;">
                        <span class="material-icons-outlined" style="margin-right: 15px;">more_horiz</span>
                    </button>
                </div>
            </div>
            <!--                메인 피드 슬라이드 사진--------------------------------------------------------------->
            <div id="carouselExampleControlsNoTouching" class="carousel slide" data-bs-touch="false"
                 data-bs-interval="false" style="height: 600px;">
                <div class="carousel-inner">
                    <div class="carousel-item active">
                        <img src="https://blog.kakaocdn.net/dn/b0ZMMh/btq4eKTyBG4/aVgQqfsq543UByfJSaK0cK/img.jpg"
                             class="d-block w-100 feed-picture" alt="...">
                    </div>
                    <div class="carousel-item">
                        <img src="http://talkimg.imbc.com/TVianUpload/tvian/TViews/image/2021/09/27/OCW92k0OLl2y637683075936484992.jpg"
                             class="d-block w-100 feed-picture" alt="...">
                    </div>
                    <div class="carousel-item">
                        <img src="https://pds.joongang.co.kr//news/component/htmlphoto_mmdata/201808/19/5277e53b-623d-47cc-ad96-d5264ef784a0.jpg"
                             class="d-block w-100 feed-picture" alt="...">
                    </div>
                </div>
                <button class="carousel-control-prev" type="button"
                        data-bs-target="#carouselExampleControlsNoTouching" data-bs-slide="prev">
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                    <span class="visually-hidden">Previous</span>
                </button>
                <button class="carousel-control-next" type="button"
                        data-bs-target="#carouselExampleControlsNoTouching" data-bs-slide="next">
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                    <span class="visually-hidden">Next</span>
                </button>
            </div>
            <!--                사진 아래 아이콘--------------------------------------------------------------------->
            <div style="margin-top: 2%; display: flex; flex-direction: row; justify-content: space-between;">
                <div style="margin-left: 10px;">
                    <span class="material-icons-outlined">favorite_border</span>
                    <span class="material-icons-outlined">mode_comment</span>
                    <span class="material-icons-outlined">send</span>
                </div>
                <div style="margin-right: 10px;">
                    <span class="material-icons-outlined">bookmark_border</span>
                </div>
            </div>
            <div style="margin-left: 10px;">
                <!--                좋아요-->
                <div>좋아요 23,232개</div>
                <!--                    게시자 글-->
                <div>BoYoung <span style="font-weight: lighter; color: dodgerblue;">#스파르타 #내일배움캠프 #파이팅</span><b
                        style="font-weight: lighter"> 오늘도 공부 열심히 하세요 !</b></div>
                <!--                댓글모두보기-->
                <div style="font-weight: lighter; color: grey">댓글 3,243개 모두보기</div>
                <!--                댓글-->
                <div>kyumin_1020 <span style="font-weight: lighter">보영누나 너무 이뻐요 ㅠㅠ 열심히 할게요 ㅠ</span></div>
                <!--                몇일,시간,분전-->
                <div style="font-weight: lighter; font-size: 10px;">3시간전</div>
                <!--                댓글달기-->
                <div style="display:flex; flex-direction: row; justify-content: center; margin-left: -10px; margin-top: 10px; border-top: solid 1px #dbdbdb;">
                    <span style="margin-left: 8px; margin-top: 7px;" class="material-symbols-outlined">mood</span>
                    <input type="email" class="form-control"
                           style="box-shadow: none; border: none; border-radius: 0px;" id="exampleFormControlInput1"
                           placeholder="댓글 달기 ...">
                    <a href="#"
                           style="width: 50px; margin-right: 8px; margin-top: 7px; text-decoration: none; color: cornflowerblue; font-weight: bold">
                            게시
                        </a>
                </div>
            </div>
        </div>
        </div>
        </div>`;
	return item;
}



// (2) 스토리 스크롤 페이징하기
//$(window).scroll(() => {
//
//});


// (3) 좋아요, 안좋아요
function toggleLike(posts_idx) {
	let likeIcon = $(`#storyLikeIcon-${posts_idx}`);
	
	if (likeIcon.hasClass("far")) {
		
		$.ajax({
			type:"post",
			url:`/shoecream/api/image/${posts_idx}/likes`,
			ataType:"json"
		}).done(res=>{
			
			let likeCountStr = $(`#storyLikeCount-${posts_idx}`).text();
			let likeCount = Number(likeCountStr) + 1;
			console.log("좋아요 카운트 증가", likeCount);
			$(`#storyLikeCount-${posts_idx}`).text(likeCount);
					
			likeIcon.addClass("fas");
			likeIcon.addClass("active");
			likeIcon.removeClass("far");
		}).fail(error=>{
				
			console.log("오류", error);
		});

	} else {
		
		$.ajax({
			type:"delete",
			url:`/shoecream/api/image/${posts_idx}/likes`,
			ataType:"json"
		}).done(res=>{
			
			let likeCountStr = $(`#storyLikeCount-${posts_idx}`).text();
			let likeCount = Number(likeCountStr) - 1;
			console.log("좋아요 카운트 감소", likeCount);
			$(`#storyLikeCount-${posts_idx}`).text(likeCount);
					
			likeIcon.removeClass("fas");
			likeIcon.removeClass("active");
			likeIcon.addClass("far");
		}).fail(error=>{
			console.log("오류", error);
		});
	
	}
}

// (4) 댓글쓰기
function addComment(posts_idx) {

	let commentInput = $(`#storyCommentInput-${posts_idx}`);
	let commentList = $(`#storyCommentList-${posts_idx}`);

	let data = {
    	posts_idx:posts_idx,
		comment_content:commentInput.val()
	}

//	alert(data.comment_content);
//	alert(data.posts_idx);
//	
	if (data.comment_content === "") {
		alert("댓글을 작성해주세요!");
		return;
	}
	
	$.ajax({
		type:"POST",
		url:"/shoecream/api/comment",
		data:JSON.stringify(data),
		contentType:"application/json;charset=utf-8",
		dataType:"json"
	}).done(res=>{
		console.log("성공", res);
			
		let comment = res.data;
		
		let content = `
				  <div class="sl__item__contents__comment" id="storyCommentItem-${comment.comment_idx}"> 
				    <p>
				      <b>${comment.mem_nickname} :</b>
				      ${comment.comment_content}
				    </p>
				  <button onclick="deleteComment(${comment.comment_idx})">
				    <i class="fas fa-times"></i></button>
				  </div>
		`;
		commentList.prepend(content);
		
	}).fail(error=>{
		console.log("실패", error);
		alert("오류 : " + error.responseJSON.data.comment_content)
	});

	commentInput.val("");
}

// (5) 댓글 삭제
function deleteComment(comment_idx) {
	alert(comment_idx);
	$.ajax({
		type:"DELETE",
		url:`/shoecream/api/comment/${comment_idx}`,
		dataType:"json"
	}).done(res=>{
		console.log("댓글 삭제 성공", res);
        $(`#storyCommentItem-${comment_idx}`).remove();
	}).fail(error=>{
		console.log("댓글 삭제 실패", error);
	});
}







