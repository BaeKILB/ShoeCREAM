/**
  1. 유저 프로파일 페이지
  (1) 유저 프로파일 페이지 구독하기, 구독취소
  (2) 구독자 정보 모달 보기
  (3) 구독자 정보 모달에서 구독하기, 구독취소
  (4) 유저 프로필 사진 변경
  (5) 사용자 정보 메뉴 열기 닫기
  (6) 사용자 정보(회원정보, 로그아웃, 닫기) 모달
  (7) 사용자 프로파일 이미지 메뉴(사진업로드, 취소) 모달 
  (8) 구독자 정보 모달 닫기
 */

// 유저 프로파일 페이지 구독하기, 구독취소
function toggleSubscribe(mem_idx, obj) {
	if ($(obj).text() === "구독취소") {
		$.ajax({
			type: "DELETE",
			url: "/shoecream/api/follow/" + mem_idx, // 왜 shoecream 을 붙여야하나 하아
			dataType: "json"
		}).done(res => {
			$(obj).text("구독하기");
			$(obj).toggleClass("blue");
		}).fail(error => {
			console.log("구독취소실패",error);
			console.log(mem_idx)
		});
	} else {
		$.ajax({
			type: "POST",
			url: "/shoecream/api/follow/" + mem_idx,
			dataType: "json"
		}).done(res => {
			$(obj).text("구독취소");
			$(obj).toggleClass("blue");
		}).fail(error => {
			console.log("구독하기실패",error);
			console.log(mem_idx)
		});
	}
}

// 구독자 정보  모달 보기
function subscribeInfoModalOpen(mem_idx) {
//	alert(mem_idx) // 잘 들어 오고
	
	$(".modal-subscribe").css("display", "flex");
	
	$.ajax({
		url:`/shoecream/api/social/${mem_idx}/follow`,
		dataType:"json"
	}).done(res=>{
//		alert(mem_idx) // 잘 오고
		console.log(res.data); // 데이터 잘 가고
		
		res.data.forEach((u)=>{
			let item = getSubscribeModalItem(u);
			$("#subscribeModalList").append(item);
		});
	}).fail(error=>{
		console.log("팔로잉 정보 불러오기 오류", error);
	});
}

function getSubscribeModalItem(u) {
//	alert("나 실행됨?");
	let item=`<div class="subscribe__item" id="subscribeModalItem-${u.mem_idx}">
	<div class="subscribe__img">
		<img src="/upload/${u.profileImageUrl}" onerror="this.src='https://kream.co.kr/_nuxt/img/blank_profile.4347742.png';" />
	</div>
	<div class="subscribe__text">
		<h2>${u.mem_id}</h2>
	</div>
	<div class="subscribe__btn">`;
	
	if(!u.equalMemberState){ // 동일 유저가 아닐 때 버튼이 만들어져야함
		if(u.followState){ // 구독한 상태
			item += `<button class="cta blue" onclick="toggleSubscribe(${u.mem_idx},this)">구독취소</button>`;			
		} else { // 구독 안한 상태
			item += `<button class="cta" onclick="toggleSubscribe(${u.mem_idx},this)">구독하기</button>`;			
		}
	}	
	item += `	
	</div>
</div>`;

	console.log(item);
	return item;
}

// 유저 프로파일 사진 변경 (완)
function profileImageUpload() {
	$("#userProfileImageInput").click();

	$("#userProfileImageInput").on("change", (e) => {
		let f = e.target.files[0];

		if (!f.type.match("image.*")) {
			alert("이미지를 등록해야 합니다.");
			return;
		}

		// 사진 전송 성공시 이미지 변경
		let reader = new FileReader();
		reader.onload = (e) => {
			$("#userProfileImage").attr("src", e.target.result);
		}
		reader.readAsDataURL(f); // 이 코드 실행시 reader.onload 실행됨.
	});
}


// 사용자 정보 메뉴 열기 닫기
function popup(obj) {
	$(obj).css("display", "flex");
}

function closePopup(obj) {
	$(obj).css("display", "none");
}


// 사용자 정보(회원정보, 로그아웃, 닫기) 모달
function modalInfo() {
	$(".modal-info").css("display", "none");
}

// 사용자 프로파일 이미지 메뉴(사진업로드, 취소) 모달
function modalImage() {
	$(".modal-image").css("display", "none");
}

// 구독자 정보 모달 닫기
function modalClose() {
	$(".modal-subscribe").css("display", "none");
	location.reload();
}






