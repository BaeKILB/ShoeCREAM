
	
$(function() { // onload
    
	// 대분류 카테고리
	$(".ct_lc_item_btn").on("click",function() {
		
		// 버튼들 활성화 상태 초기화 위해서 객채들 불러오기
		let mcItemBtns = document.querySelectorAll(".ct_mc_item_btn");
		// 객체 초기화
		mcItemBtns.forEach((e) => {
			e.classList.remove("mcBtnActive");
		});
		// 변수 초기화
		dataObj = initAjax();
		console.log(".ct_lc_item_btn.on - dataObj init" + JSON.stringify(dataObj))
		$("#orderMethod").val('');
		// 동일 대분류 선택시
        if($(this).siblings().attr('class') == '') {
//            $(this).siblings().addClass('hidden');
        	dataObj.lc_code = $(this).children().val();
    		$("#itemList").empty();
			if(!loadItems()){
				console.log("onload $('.ct_lc_item_btn').on - loadItems() error !");
			}
            return;
        }
        
        // 초기 또는 다른 대분류 선택시
        $(".ct_lc_item_btn").each(function() {
//            $(this).siblings().addClass('hidden');
        });
        
        // 선택 대분류 보여주기
//        $(this).siblings().removeClass('hidden');
        dataObj.lc_code = $(this).children().val();
		$("#itemList").empty();
		if(!loadItems()){
			console.log("onload $('.ct_lc_item_btn').on - loadItems() error !");
		}
        
		console.log("lc : " + dataObj.lc_code);
		console.log("mc : " + dataObj.mc_code);
    });
    
    $(".ct_mc_item_btn").on("click",function() {
		// 버튼들 활성화 상태 초기화 위해서 객채들 불러오기
		let mcItemBtns = document.querySelectorAll(".ct_mc_item_btn");
		// 변수 초기화
		let lc_temp = dataObj.lc_code;
		
		// 객체 초기화
		mcItemBtns.forEach((e) => {
			e.classList.remove("mcBtnActive");
		});
		this.classList.toggle("mcBtnActive");
		
		dataObj = initAjax();
		dataObj.lc_code = lc_temp;
		console.log(".ct_lc_item_btn.on - dataObj init" + JSON.stringify(dataObj))
		
		$("#orderMethod").val('');
		dataObj.mc_code = $(this).children().val();
		$("#itemList").empty();
		if(!loadItems()){
			console.log("onload $('.ct_mc_item_btn').on - loadItems() error !");
		}
		console.log("lc : " + dataObj.lc_code);
		console.log("mc : " + dataObj.mc_code);
		

	});
	
}); // onload


const categoryBtnDrop = (e) => {
	let ct_list = document.querySelector("." + e.id);
	
	e.classList.toggle("ct_img_up");
	ct_list.classList.toggle("ct_show");
};

const allScListHidden = (e) => {
	document.querySelectorAll(".ct_sc_list").forEach(t => {
		if(!t.className.includes(e.id)){
			t.classList.remove("ct_show")			
		}
	});	
}
const allMcListHidden = (e) => {
	document.querySelectorAll(".ct_mc_list").forEach(t => {
		if(!t.className.includes(e.id)){
			t.classList.remove("ct_show")
		}
	});	
}

// 페이지 축소시 카테고리 리스트가 아이템 리스트보다 상단 인데
// 이때 카테고리 접는 기능을 구현하기
const hiddenCategory = (e) => {
	
	let ct_list = document.querySelector(".sideCategoryWrap");
	ct_list.classList.toggle("hidden");
	e.classList.toggle("ct_img_up");
	
	
}
