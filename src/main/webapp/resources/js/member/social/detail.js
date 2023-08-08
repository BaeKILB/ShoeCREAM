 
 // 댓글 및 게시물 시간 계산 표시
function displayedAt(createdAt) {
  const milliSeconds = new Date() - new Date(createdAt)
  const seconds = milliSeconds / 1000
  if (seconds < 60) return `방금 전`
  const minutes = seconds / 60
  if (minutes < 60) return `${Math.floor(minutes)}분 전`
  const hours = minutes / 60
  if (hours < 24) return `${Math.floor(hours)}시간 전`
  const days = hours / 24
  if (days < 7) return `${Math.floor(days)}일 전`
  const weeks = days / 7
  if (weeks < 5) return `${Math.floor(weeks)}주 전`
  const months = days / 30
  if (months < 12) return `${Math.floor(months)}개월 전`
  const years = days / 365
  return `${Math.floor(years)}년 전`
}
 
 // 글 삭제
function deleteConfirm(){
	
	if(!confirm("삭제 하시겠습니까?")){
		return false;
	}else{
		location.href="ImageDeletePro";
	}
}
 
 // 현재 로그인 한 유저의 mem_idx
 let principalId = $("#principalId").val();
 console.log("로그인한 유저 :", principalId)
// let posts_idx = $("#posts_idx").val();
 console.log("해당 게시물 idx :", posts_idx);
 
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
	let url = `${contextPath}/api/image/${posts_idx}/detail?pageNum=${pageNum}`;
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

	let item = 
	`<div class="story-list__item" style="width: 100%;">
	<div class="sl__item__header">
        <div style="margin-left: 5px;">
            <a href="/shoecream/social/${image.mem_idx}"> <!-- 링크를 추가 -->
                <img class="profile-image" src="/shoecream/resources/upload/profile/${image.mem_profileImageUrl}"
                    onerror="this.src='https://kream.co.kr/_nuxt/img/blank_profile.4347742.png';" style="width: 41.818182px;"/>
            </a>
        </div>
			<div class="nickname-date-wrapper" style="display: flex; flex-direction: column; margin-left: 10px;">
			    <div style="font-size:14px; height: 20px;">
			        <strong>${image.mem_nickname}</strong>
			    </div>
			
			    <div style="font-size:12px; color:#adb5bd;">
			        ${displayedAt(image.posts_date)}
			    </div>
			</div>`;
				if (principalId == image.mem_idx) {
					item += 
        		`    <div class="right-part" style="display: flex; flex-grow: 1;">
    <div class="edit-delete-buttons">
        <div>
            <button type="button" class="btn btn-light edit-btn" style="font-size: 12px;" onclick="window.location.href='/shoecream/social/1/update'">수정</button>
        </div>
        <div>
            <button type="button" class="btn btn-light delete-btn" style=" font-size: 12px;" onclick="deleteConfirm();">삭제</button>
        </div>
    </div>
    </div>`;
		        }
		item+=`
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
			
					<span class="like">좋아요<b id="storyLikeCount-${image.posts_idx}">${image.likeCount}</b>개</span>
			
					<div class="sl__item__contents__content">
						<p>${image.posts_content}</p>
					</div>
			
					<div id="storyCommentList-${image.posts_idx}">`;
		
				image.comment_contents.forEach((comment)=>{
				item+=`<div class="sl__item__contents__comment small-header " id="storyCommentItem-${comment.comment_idx}" style="padding-left: 5px;margin-bottom: 20px;">
                                        <div class="sl__item__header" style="height: 25px;">
                                            <div style="margin-top: 10px;">
                                                <div style="height: 25px;">
                                                    <a href="/shoecream/social/${comment.mem_idx}"> <!-- 링크를 추가 -->
                                                    <img class="profile-image" src="/shoecream/resources/upload/profile/${comment.mem_profileImageUrl}" onerror="this.src='https://kream.co.kr/_nuxt/img/blank_profile.4347742.png';"
                                                        style="width: 28.63636px;height: 28.63636px;margin-right: 5px; margin-left: 0px;" />
                                                	</a>
                                                </div>
                                            </div>

                                            <div class="d-flex flex-column w-100" style="height: 40px;">
                                                <div class="d-flex align-items-center no-vertical-margins" style="font-size: 0.8rem;">
                                                    <span><strong>${comment.mem_nickname}</strong></span>
                                                    <span class="ms-2" style="white-space: nowrap; color :#495057;">${comment.comment_content}</span>
                                                </div>
                                                <div class="d-flex align-items-center no-vertical-margins " style="font-size: 0.7rem;">
                                                    <span class="" style="color:#adb5bd;">${displayedAt(comment.comment_date)}</span>
                                                    <span class="ms-2">
                                                        <button class="reply-btn btn-sm text-black-50"><strong>답변달기</strong></button>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>`;
				
			if (principalId == comment.mem_idx) {
				item +=
				`<button onclick="deleteComment(${comment.comment_idx})">
					<i class="fas fa-times"></i>
				</button>`;
			}
		item+=`
			</div>`;
			});
		
		item += `
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
			type: "post",
            url: `${contextPath}/api/image/${posts_idx}/likes`,
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
            url:`${contextPath}/api/image/${posts_idx}/likes`,
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
		url:`${contextPath}/api/comment`,
		data:JSON.stringify(data),
		contentType:"application/json;charset=utf-8",
		dataType:"json"
    }).done(res=>{
        console.log("성공", res);

        let comment = res.data;
        let profileImageUrl = comment.mem_profileImageUrl;
        
        let content = `
                  <div class="sl__item__contents__comment small-header " id="storyCommentItem-${comment.comment_idx}" style="padding-left: 5px;margin-bottom: 20px;">
                                        <div class="sl__item__header" style="height: 25px;">
                                            <div style="margin-top: 10px;">
                                                <div style="height: 25px;">
                                                    <a href="/shoecream/social/${comment.mem_idx}"> <!-- 링크를 추가 -->
                                                    <img class="profile-image" src="/shoecream/resources/upload/profile/${comment.mem_profileImageUrl}" onerror="this.src='https://kream.co.kr/_nuxt/img/blank_profile.4347742.png';"
                                                        style="width: 28.63636px;height: 28.63636px;margin-right: 5px; margin-left: 0px;" />
                                                	</a>
                                                </div>
                                            </div>

                                            <div class="d-flex flex-column w-100" style="height: 40px;">
                                                <div class="d-flex align-items-center no-vertical-margins" style="font-size: 0.8rem;">
                                                    <span><strong>${comment.mem_nickname}</strong></span>
                                                    <span class="ms-2" style="white-space: nowrap; color :#495057;">${comment.comment_content}</span>
                                                </div>
                                                <div class="d-flex align-items-center no-vertical-margins " style="font-size: 0.7rem;">
                                                    <span class="" style="color:#adb5bd;">${displayedAt(comment.comment_date)}</span>
                                                    <span class="ms-2">
                                                        <button class="reply-btn btn-sm text-black-50"><strong>답변달기</strong></button>
                                                    </span>
                                                </div>
                                            </div>
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
		url:`${contextPath}/api/comment/${comment_idx}`,
		dataType:"json"
	}).done(res=>{
		console.log("댓글 삭제 성공", res);
        $(`#storyCommentItem-${comment_idx}`).remove();
	}).fail(error=>{
		console.log("댓글 삭제 실패", error);
	});
}







