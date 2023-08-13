
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




