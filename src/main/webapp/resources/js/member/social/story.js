/**
	2. 스토리 페이지
	(1) 스토리 로드하기
	(2) 스토리 스크롤 페이징하기
	(3) 좋아요, 안좋아요
	(4) 댓글쓰기
	(5) 댓글삭제
 */
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

	let item = `<div class="story-list__item">
	<div class="sl__item__header">
		<div>
            <img class="profile-image" src="/shoecream/resources/upload/social/${image.profileImageUrl}"
				onerror="this.src='https://kream.co.kr/_nuxt/img/blank_profile.4347742.png';" />
		</div>
		<div>${image.mem_nickname}</div>
	</div>

	<div class="sl__item__img">
		<img src="/shoecream/resources/upload/social/${image.posts_image1}"/>
	</div>

	<div class="sl__item__contents">
		<div class="sl__item__contents__icon">

			<button>`;
			
			if(image.likeState) {
				item += `<i class="fas fa-heart active" id="storyLikeIcon-${image.posts_idx}" onclick="toggleLike(${image.posts_idx})"></i>`;
			} else {
				item += `<i class="far fa-heart" id="storyLikeIcon-${image.posts_idx}" onclick="toggleLike(${image.posts_idx})"></i>`;
			}
				
			
		item += `
			</button>
		</div>

		<span class="like"><b id="storyLikeCount-${image.posts_idx}">${image.likeCount} </b>likes</span>

		<div class="sl__item__contents__content">
			<p>${image.posts_content}</p>
		</div>

		<div id="storyCommentList-${image.posts_idx}">`;
		
			image.comment_contents.forEach((comment)=>{
				item+=`<div class="sl__item__contents__comment" id="storyCommentItem-${comment.posts_idx}">
				<p>
					<b>${comment.mem_nickname} :</b> ${comment.comment_content}
				</p>

				<button>
					<i class="fas fa-times"></i>
				</button>

			</div>`;
			});
		item+=`
		</div>

		<div class="sl__item__input">
			<input type="text" placeholder="댓글 달기..." id="storyCommentInput-${image.posts_idx}" />
			<button type="button" onClick="addComment(${image.posts_idx})">게시</button>
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
				  <div class="sl__item__contents__comment" id="storyCommentItem-${comment.posts_idx}"> 
				    <p>
				      <b>${comment.mem_nickname} :</b>
				      ${comment.comment_content}
				    </p>
				    <button><i class="fas fa-times"></i></button>
				  </div>
		`;
		commentList.prepend(content);
		
	}).fail(error=>{
		console.log("실패", error);
	});

	commentInput.val("");
}

// (5) 댓글 삭제
function deleteComment() {

}







