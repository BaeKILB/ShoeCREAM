
// url 에서 파라미터 받아오기
let getParams = new URL(location.href).searchParams;


// 채팅 메시지 영역 위에 상품 상태에 따라서
// 상품 정보와 유저 정보 및 버튼 불러오기
const loadChatMsgBar = (param) => {
	if(param.get("chat_area") != null &&
		param.get("chat_area") != undefined && 
		param.get("chat_room_idx") != null &&
		param.get("chat_room_idx") != undefined){
			
			
		let checkError = false;
	
		let data =  $.ajax({
			type:"post"
			,url: "checkChatRoomStatus.ajax"
			,data: {
				chat_room_area: param.get("chat_area")
				,chat_room_idx: param.get("chat_room_idx")
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
	loadChatMsgBar(getParams);
}
