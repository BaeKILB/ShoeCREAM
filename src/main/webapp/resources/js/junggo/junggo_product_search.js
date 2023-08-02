
// ========== 0621 경인 추가 ==========
// ajax 데이터 보내기 및 데이터 받기
let dataObj;

// ajax 로 초기정보 구성하기
function initAjax() {
	
	// 파라미터 가져오기
	let getParams = new URL(location.href).searchParams;
	console.log(getParams);
	let checkError = false;
	
	let data =  $.ajax({
        url: "junggoSearchInit.ajax",
        type: "post",
        data: JSON.stringify(getParams),
        dataType: "json",
        async: false,
        error: function(errorThrown) {
            console.log(errorThrown.statusText);
            console.log("error - initAjax");
            checkError = true;
        }
    });
    if(!checkError){    
		// 초기값 저장
		
		return data.responseJSON;
	}
}


function loadItemAjax(obj) {
	
	let checkError = false;
	
	let data =  $.ajax({
        url: "jungProductList.ajax",
        type: "post",
        data: obj,
        dataType: "json",
        async: false,
        error: function(errorThrown) {
            console.log(errorThrown.statusText);
            console.log("error");
            checkError = true;
        }
    });
    if(!checkError){
		addItems(data.responseJSON);	
	}
    
    return data.responseJSON;

}


// ajax 로 받아온 데이터 페이지에 적용
function addItems(obj){	// 만약 마지막 리스트까지 검색했으면 더보기 버튼을 지우기

//	let resLoadBtn = document.querySelector("#btnLoadItem");
//	
//	if(obj.startPage >= obj.maxPage){	
//		resLoadBtn.setAttribute("style","display:none")	
//	}
	
	let itemListWrap = document.querySelector("#itemList");
	
	obj.jungListHtml.forEach((e) => {
		itemListWrap.insertAdjacentHTML("beforeend", e);
	});
}

const loadItems = () => {
	let temp = loadItemAjax(dataObj);
	if(temp != undefined){		
		dataObj = temp;
	}
	else{
		return false;
	}
	return true;
}

$(function() { // onload

	dataObj = initAjax();
	if(!loadItems()){
		console.log("onload - loadItems() error !");
	}
	
    // 스크롤
    $(window).on("scroll",function() {
        let scrollTop = $(window).scrollTop();
        let windowHeight = $(window).height();
        let documentHeight = $(document).height();
        
        if(scrollTop + windowHeight + 1 >= documentHeight) {
			if (dataObj.startPage <= dataObj.maxPage) {
   				if(!loadItems()){
					console.log("onload $(window).on - loadItems() error !");
				}
       		}
        }
    });
	
	// 정렬
	$("#orderMethod").on("change",function() {
		$("#itemList").empty();
		// 변수 초기화
		let lc_temp = dataObj.lc_code;
		let mc_temp = dataObj.mc_code;
		dataObj = initAjax();
		dataObj.lc_code = lc_temp;
		dataObj.mc_code = mc_temp;
		dataObj.orderMethod = $("#orderMethod").val();
		console.log(".ct_lc_item_btn.on - dataObj init" + JSON.stringify(dataObj))
		
		if(!loadItems()){
			console.log("onload $('#orderMethod').on - loadItems() error !");
		}
	});
});


