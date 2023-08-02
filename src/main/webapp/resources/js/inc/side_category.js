
	
$(function() { // onload
    
	// 대분류 카테고리
	$(".ct_lc_item_btn").on("click",function() {
		// 변수 초기화
		dataObj = initAjax();
		console.log(".ct_lc_item_btn.on - dataObj init" + JSON.stringify(dataObj))
		$("#orderMethod").val('');
		// 동일 대분류 선택시
        if($(this).siblings().attr('class') == '') {
            $(this).siblings().addClass('hidden');
        	dataObj.lc_code = $(this).children().val();
    		$("#itemList").empty();
			if(!loadItems()){
				console.log("onload $('.ct_lc_item_btn').on - loadItems() error !");
			}
            return;
        }
        
        // 초기 또는 다른 대분류 선택시
        $(".ct_lc_item_btn").each(function() {
            $(this).siblings().addClass('hidden');
        });
        
        // 선택 대분류 보여주기
        $(this).siblings().removeClass('hidden');
        dataObj.lc_code = $(this).children().val();
		$("#itemList").empty();
		if(!loadItems()){
			console.log("onload $('.ct_lc_item_btn').on - loadItems() error !");
		}
        
		console.log("lc : " + dataObj.lc_code);
		console.log("mc : " + dataObj.mc_code);
    });
    
    $(".ct_mc_item_btn").on("click",function() {
		// 변수 초기화
		let lc_temp = dataObj.lc_code;
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
