
// url 에서 파라미터 받아오기
let getParams = new URL(location.href).searchParams;


// 채팅 메시지 영역 위에 상품 상태에 따라서
// 상품 정보와 유저 정보 및 버튼 불러오기
const loadChatMsgBar = () => {
	if(getParams.get("chat_area") != null &&
		getParams.get("chat_area") != undefined && 
		getParams.get("chat_room_idx") != null &&
		getParams.get("chat_room_idx") != undefined){
			
			
		let checkError = false;
	
		let data =  $.ajax({
			type:"post"
			,url: "checkChatRoomStatus.ajax"
			,data: {
				chat_room_area: getParams.get("chat_area")
				,chat_room_idx: getParams.get("chat_room_idx")
				,localURL : localURL
			}
			,dataType: "json"
			,async: false
			,success:function(){
				checkError = true;
			}
		    ,error: function(errorThrown) {
		        console.log(errorThrown.statusText);
		        console.log("error - loadChatMsgBar");
		    }
		    
		    
		}); // ajax 끝
	    if(checkError){
			let d = data.responseJSON;
			console.log("loadChatMsgBar : " + d.html)
			$(".chat_msg_info_wrap").empty();
			let itemListWrap = document.querySelector(".chat_msg_info_wrap");
			
			itemListWrap.insertAdjacentHTML("beforeend", d.html);
		}
	}// if문 끝
	else{
		console.log("error ! - loadChatMsgBar : params is null");
	}
}

// 만약 chat_room_idx 가 파라미터에 존재하면 처음 로드할때 데이터 받아오기

if(getParams.get("chat_room_idx") != null && 
	getParams.get("chat_room_idx") != undefined &&
	getParams.get("chat_area") < 1){
	loadChatMsgBar();
}

// 채팅방 나가기 신호 보내기
// param = 0 : 일반 나가기
// param = 1 : 예약중 나가기
// param = 2 : 거래중 (페이결제후) 나가기
const chatRoomOut = (check) => {
	let result = false;
	if(check == 1){
		result = confirm("현재 예약중 상태입니다 지금 나가면 상대방에게 피해를 줄 수 있으며 "
		+"운영 정책상 위반사항이 있을시 불이익을 받을 수 있습니다 정말 나가시겠습니까?");		
	}
	if(check == 2){
		alert("현재 페이 결제 된 상태임으로 나가실 수 없습니다! 결제 취소 또는 관리자에게 문의해주세요");
	}
	else{
		result = confirm("정말 채팅방을 나가시겠습니까?");
	}
	
	if(result){
		if(getParams.get("chat_area") != null &&
		getParams.get("chat_area") != undefined && 
		getParams.get("chat_room_idx") != null &&
		getParams.get("chat_room_idx") != undefined){		
			location.href = "chatRoomOut?chat_area=" + getParams.get("chat_area") 
			+ "&chat_room_idx=" + getParams.get("chat_room_idx");
		}
	}
}


// 예약 진행 버튼 눌렀을때
const startRes = () => {
	let result = false;
	
	result = confirm("예약 진행 하시겠습니까?");		
	
	if(result){
		if(getParams.get("chat_area") != null &&
		getParams.get("chat_area") != undefined && 
		getParams.get("chat_room_idx") != null &&
		getParams.get("chat_room_idx") != undefined){		
			location.href = "startRes?chat_area=" + getParams.get("chat_area") 
			+ "&chat_room_idx=" + getParams.get("chat_room_idx");
		}
	}
}

// 거래완료를 눌렀을때
const transComplete = () => {
		let result = false;
	
	result = confirm("거래 완료를 진행 하시겠습니까?");		
	
	if(result){
		if(getParams.get("chat_area") != null &&
		getParams.get("chat_area") != undefined && 
		getParams.get("chat_room_idx") != null &&
		getParams.get("chat_room_idx") != undefined){		
			location.href = "transForm?chat_area=" + getParams.get("chat_area") 
			+ "&chat_room_idx=" + getParams.get("chat_room_idx");
		}
	}
}
