
// ========== 0621 경인 추가 ==========
// ajax 데이터 보내기 및 데이터 받기



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
function addItems(dataObj){	// 만약 마지막 리스트까지 검색했으면 더보기 버튼을 지우기

	let resLoadBtn = document.querySelector("#btnLoadItem");
	
	if(dataObj.startPage >= dataObj.maxPage){	
		resLoadBtn.setAttribute("style","display:none")	
	}
	
	let itemListWrap = document.querySelector("#itemList");
	
	dataObj.jungListHtml.forEach((e) => {
		itemListWrap.insertAdjacentHTML("beforeend", e);
	});
}

// 첫 로드시 한번 ajax로 불러오기
dataObj = loadItemAjax(dataObj);


