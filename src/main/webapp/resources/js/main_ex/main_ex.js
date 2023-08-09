/**
 * 
 */
 
 
 // 0808 경인추가 
 // 중고상품 ajax 로 불러오기
 
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
	obj[""]
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
	
	let limit = obj.jungListHtml.length;
	
	if(limit > 5){
		limit = 4;
	}
	
	for(let i = 0; i < limit; i++ ){
		
	}
	
	
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
	dataObj
	let temp = loadItemAjax(dataObj);
	if(temp != undefined){		
		dataObj = temp;
	}
	else{
		return false;
	}
	return true;
}


// =================== onload
$(function() { 

	dataObj = initAjax();
	if(!loadItems()){
		console.log("onload - loadItems() error !");
	}
	
});




