
// url 에서 파라미터 받아오기
let getParams = new URL(location.href).searchParams;


// 채팅 메시지 영역 위에 상품 상태에 따라서
// 상품 정보와 유저 정보 및 버튼 불러오기
const payWithPoint = () => {
	if(getParams.get("product_idx") != null &&
		getParams.get("product_idx") != undefined &&
		getParams.get("product_selector") != null &&
		getParams.get("product_selector") != undefined
		){
			
			
		let checkError = false;
	
		let data =  $.ajax({
			type:"post"
			,url: "payWithPoint.ajax"
			,data: {
				product_idx: getParams.get("product_idx")
				,product_selector: getParams.get("product_selector")
			}
			,dataType: "json"
			,async: false
			,success:function(){
				checkError = true;
			}
		    ,error: function(errorThrown) {
				alert("결제에 실패했습니다 !");
		        console.log(errorThrown.statusText);
		        console.log("error - payWithPoint");
		    }
		    
		    
		}); // ajax 끝
	    if(checkError){
			let d = data.responseJSON;
			console.log("payWithPoint : " + d.result)
			
			if(d.result == true){
				alert("결제에 성공했습니다 !");
				opener.document.querySelector("#btnHidden").click();
				window.close();
			
			}
			else{
				alert("결제에 실패했습니다 !");
				console.log(d.error);
			}
		}
	}// if문 끝
	else{
		console.log("error ! - loadChatMsgBar : params is null");
	}
}


