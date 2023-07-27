
// 내가 메시지를 보내거나 해서 생기는 경우일때 체크
// 스크롤을 맨 아래로 내림
let myLoad = true;

//초기값 셋팅
let productName = "";
let chat_room_idx = "";
let username = ""
console.log(productName + ", " + chat_room_idx + ", " );

let sockJs = new SockJS("stomp_chat");
//1. SockJS를 내부에 들고있는 stomp를 내어줌
let stomp = Stomp.over(sockJs);

//스크롤 자동 내리기
function scrolDown() {
	let msgArea = document.querySelector("#msgArea");
	if(msgArea.scrollTop >
		msgArea.scrollHeight - msgArea.clientHeight - 200
		|| myLoad){					
		msgArea.scrollTop = msgArea.scrollHeight;
	}
}

const chatAdder = (content) => {
	
	
	   let str = '';
	
       str = "<div class='col-6'>";
       if(content.chat_msg_idx == content.my_idx){	
       		str += "<div class='alert alert-secondary'>";
		}
		else{
			str += "<div class='alert alert-danger'>";
		}
       str += "<b>" + content.mem_nickname + " : " + content.chat_msg_content + "</b>";
       str += "</div></div>";
       $("#msgArea").append(str);
	   
}

const getRoomAjax = (chat_room_idx) => {
	$.ajax({
		type : "GET"
		,url : "getRoomAjax?chat_room_idx=" + chat_room_idx
		,dataType: "json"
		,success: function(data){
			console.log(JSON.stringify(data))
		}
	})	
}


const connectStart = () => {
		//2. connection이 맺어지면 실행
    stomp.connect({}, function (){

       //4. subscribe(path, callback)으로 메세지를 받을 수 있음
       stomp.subscribe("/topic/room" + chat_room_idx, function (chat) {
    	   
		console.log("STOMP Connection On")
		 
			chatAdder(JSON.parse(chat.body));
			scrolDown();
			myLoad = false;
			
       },
       function(){console.log("연결 실패!")});

       //3. send(path, header, chat_content)로 메세지를 보낼 수 있음
       stomp.send('/pub/enter', {}, JSON.stringify({chat_room_idx: chat_room_idx, chat_writer: username}))
		
    });
}


const initChatMsg = (pName, chatRoomIdx, userName) => {
	//연결 종료
	stomp.disconnect();
	
	// 채팅창 구역 비우기
	$("#msgArea").empty();
	
	sockJs = new SockJS("stomp_chat");
	
	// 초기값 셋팅
	productName = pName;
	chat_room_idx = chatRoomIdx;
	username = userName;
	console.log("test");
	connectStart();
	
	console.log("test2");
	scrolDown();
}


$(document).ready(function(){

    $("#button-send").on("click", function(e){
        let msg = document.getElementById("msg");

        console.log(username + ":" + msg.value);
        stomp.send('/pub/message', {}, JSON.stringify({chat_room_idx: chat_room_idx, chat_msg_content: msg.value, chat_msg_idx:chat_msg_idx ,sId:username}));
        msg.value = '';
        myLoad = true;
    });   
});
