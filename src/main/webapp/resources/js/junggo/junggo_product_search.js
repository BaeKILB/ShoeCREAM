
// ========== 0621 경인 추가 ==========
// ajax 데이터 보내기 및 데이터 받기
let dataObj;

// url 파라미터 가져오기
let getParams = new URL(location.href).searchParams;

console.log(getParams);

let obj = {}
if(getParams.get("lc_code") != null){	
	obj["lc_code"] = getParams.get("lc_code");
}
if(getParams.get("mc_code") != null){	
	obj["mc_code"] = getParams.get("mc_code");
}
obj["localURL"] = localURL;
console.log(obj);


// ajax 로 초기정보 구성하기
function initAjax() {
	
	// 파라미터 가져오기
	let checkError = false;

	let data =  $.ajax({
        url: "junggoSearchInit.ajax",
        type: "post",
        data: obj,
        dataType: "json",
        async: false,
        error: function(errorThrown) {
            console.log(errorThrown.statusText);
            console.log("error - initAjax");
            checkError = true;
        }
    });
    
    // url에서 들고온 변수 사용했으니 비우기
    obj = {};
    
    if(!checkError){    
		// 초기값 저장
		
		return data.responseJSON;
	}
}

// 중고 상품 항목 불러오기
function loadItemAjax(obj) {
	obj["localURL"] = localURL;
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

// 찜 하기 ajax
function dibsAjax(obj) {
	let checkError = false;
	console.log(obj)
	let data =  $.ajax({
        url: "jungDibsBtn.ajax",
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
		let dibBtn = document.querySelector("#dibs_" + obj["product_idx"]);
		let dibFavoriteCheck = document.querySelector("#favorite_check_" + obj["product_idx"]);
		let dj = data.responseJSON;
		
		if(dj.dibs_result != "true"){
			alert("찜하기가 실패하였습니다");
		}
		dibBtn.classList.toggle("UnFavorite_btn");	
		dibBtn.classList.toggle("favorite_btn");	
		if(dj.favorite_check == "Y"){
			dibBtn.value = "♥ " + dj.dibs_count;
			dibFavoriteCheck.value = "Y";
		}
		else{
			dibBtn.value = "💔 " + dj.dibs_count;
			dibFavoriteCheck.value = "N";			
		}
		
	}
	else{
		alert("찜하기가 실패하였습니다!")
	}

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
	dibsUpdate();
}

// 찜 관련 동작 넣기
// 찜 등록 or 해제버튼
const dibsUpdate = () => {
	document.querySelectorAll(".dibs_form").forEach((e) => {
	  e.onsubmit = function (event) {
	    // Form의 기본 동작 취소
	    event.preventDefault();
	    // Form 데이터 받아오기
	    var formData = new FormData(this);
	    let data = {};
	    data["product_idx"] = formData.get("product_idx");
	    data["favorite_check"] = formData.get("favorite_check");
	    data["mem_id"] = formData.get("mem_id");
	    data["mem_idx"] = formData.get("mem_idx");
	    data["buyier_idx"] = formData.get("buyier_idx");
	    
	    console.log(formData.get("product_idx"))
	    console.log(data)
	    // Form 데이터 ajax 동작 적용하기
	    dibsAjax(data);
	  };
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
	
    // 스크롤 상품 로드
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


// 페이지 처음 열었을때 나오는 초기 중고 리스트처럼
// 현재 dataObj 다시 새로 init 후에 다시 리스트 받아와서 출력
const reLoadInitItems = () => {
	
	dataObj = initAjax();
	if(!loadItems()){
		console.log("onload - loadItems() error !");
	}
	
}
