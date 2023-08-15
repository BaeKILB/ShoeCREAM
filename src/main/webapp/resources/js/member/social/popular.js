$(document).ready(function() {
  $('input[name="productSortCheck"]').on('change', function() {
    loadSortedPosts($(this).val());
  });

  // 기본으로 인기순 게시물 로드
  loadSortedPosts('popular');
});

function loadSortedPosts(sortType) {
  $.ajax({
    url: contextPath + '/social/popular/' + sortType,
    type: 'GET',
    dataType: 'json',
    success: function(data) {
      let postsHTML = '';

      for (let post of data) {
        postsHTML += `
          <div class="p-img-box col-md-3 mb-4">
            <div style="border-radius:20%;">
              <a href="${contextPath}/social/${post.mem_idx}"> <img class="rounded-image"
                  src="${contextPath}/resources/upload/social/${post.posts_image1}" />
              </a>
            </div>
            <div id="storyCommentList-1" style=" margin-top: 3px;">
              <div class="sl__item__header" style="height: 25px;">
                <div class="container">
                  <div class="row">
                    <div class="col-1" style="height: 25px; padding-left: 0px;padding-right: 0px;">
                      <a href="${contextPath}/social/${post.mem_idx}">
                      <img class="profile-image" src="${contextPath}/resources/upload/profile/${post.mem_profileImageUrl}" onerror="this.src='https://kream.co.kr/_nuxt/img/blank_profile.4347742.png';" style="width: 28.63636px;height: 28.63636px;margin-right: 5px; margin-left: 0px; border-radius: 50%;">
                      </a>
                    </div>
                    <div class="col d-flex align-items-center no-vertical-margins" style="font-size: 0.8rem;">
                      <span><strong>${post.mem_nickname}</strong></span>
                    </div>
                    <div class ="col-1">
                      <div class="sl__item__contents__icon">
                        <button>
                          <i class="fas fa-heart active" id="storyLikeIcon-${post.posts_idx}" onclick="toggleLike(${post.posts_idx})"></i>
                        </button>
                      </div>
                    </div>
	                  <div class="col-1">
	                    <span class="like"><b id="storyLikeCount-${post.posts_idx}">${post.likeCount}</b></span>
	                  </div> 
                  </div>
                  <div class="row" style="margin-top: 3px; word-break: normal;">
                    <div class="col" style="padding-right: 0px; padding-left: 0px;">
                      <span class="" style="white-space: pre-wrap; word-wrap: break-word; word-break: break-word; color :#495057;">${post.posts_content }</span>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>`;
      }
      $('.popular-gallery').html(postsHTML);
    },
    error: function(err) {
      console.error(err);
    }
  });
}



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
 
 // 현재 로그인 한 유저의 mem_idx
 let principalId = $("#principalId").val();
 console.log("로그인한 유저 :", principalId)

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




