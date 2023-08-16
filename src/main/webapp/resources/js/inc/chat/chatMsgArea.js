
// url 에서 파라미터 받아오기
let getParams = new URL(location.href).searchParams;

// 파라미터 정상적으로 있는지 확인하는 메서드
const isParamsReady = () => {
	
	if(getParams.get("chat_area") != null &&
		getParams.get("chat_area") != undefined && 
		getParams.get("chat_room_idx") != null &&
		getParams.get("chat_room_idx") != undefined){
		return true;
	}
	else false;
}

// 채팅 메시지 영역 위에 상품 상태에 따라서
// 상품 정보와 유저 정보 및 버튼 불러오기
const loadChatMsgBar = () => {
	if(isParamsReady()){
			
			
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
		if(isParamsReady()){		
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
		if(isParamsReady()){		
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
		if(isParamsReady()){		
			location.href = "transForm?chat_area=" + getParams.get("chat_area") 
			+ "&chat_room_idx=" + getParams.get("chat_room_idx");
		}
	}
}

// 결제 취소요청 눌렀을때 ajax 신호 보내기
const sandCancelPay = () => {
		let result = false;
	
		result = confirm("거래 취소 요청을 보내시겠습니까?");		
		if(result){
			if(isParamsReady()){		
				let checkError = false;
			
				let data =  $.ajax({
					type:"post"
					,url: "sandCancelPayJung.ajax"
					,data: {
						chat_area: getParams.get("chat_area")
						,chat_room_idx: getParams.get("chat_room_idx")
				
					}
					,dataType: "json"
					,async: false
					,success:function(){
						checkError = true;
					}
				    ,error: function(errorThrown) {
				        console.log(errorThrown.statusText);
				        console.log("error - loadChatMsgBar");
				        alert("취소 요청이 실패했습니다!");
				    }
				    
				    
				}); // ajax 끝
			    if(checkError){
					let d = data.responseJSON;
					alert(d.msg);

				}
				
			}
		}
}

// 결제 취소요청 허용 눌렀을때 ajax 신호 보내기
const allowCancelPay = () => {
		let result = false;
	
		result = confirm("거래 취소 요청을 허용 하시겠습니까?");	
		if(result){			
			result = confirm("거래 요청 요청 허용시 바로 포인트 환불이 됩니다 계속 하시겠습니까?");		
		}
		if(result){
			if(isParamsReady()){		
				let checkError = false;
			
				let data =  $.ajax({
					type:"post"
					,url: "allowCancelPayJung.ajax"
					,data: {
						chat_area: getParams.get("chat_area")
						,chat_room_idx: getParams.get("chat_room_idx")
				
					}
					,dataType: "json"
					,async: false
					,success:function(){
						checkError = true;
					}
				    ,error: function(errorThrown) {
				        console.log(errorThrown.statusText);
				        console.log("error - loadChatMsgBar");
				        alert("취소 요청이 실패했습니다!");
				    }
				    
				    
				}); // ajax 끝
			    if(checkError){
					let d = data.responseJSON;
					alert(d.msg);
				}
				
			}
		}
}

//onload


// 만약 chat_room_idx 가 파라미터에 존재하면 처음 로드할때 데이터 받아오기

if(getParams.get("chat_room_idx") != null && 
	getParams.get("chat_room_idx") != undefined &&
	getParams.get("chat_area") < 2){
	loadChatMsgBar();
}

// chat_room_idx 가 파라미터에 있을때 자동 포커스 및 색 변경
if(getParams.get("chat_room_idx") != null && 
	getParams.get("chat_room_idx") != undefined){
	let nowChatRooms = document.querySelector("#chat_room_" + getParams.get("chat_room_idx"));
	nowChatRooms.classList.toggle("select_room");
}

