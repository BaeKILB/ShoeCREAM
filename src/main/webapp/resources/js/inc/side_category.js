
	
$(function() { // onload
    
	// 대분류 카테고리
	$(".ct_lc_item_btn").on("click",function() {
		// 변수 초기화
		lcCode = '';
		mcCode = '';
		orderMethod = '';
		pageNum = 1;
		maxPage = 1;
		$("#orderMethod").val('');
		
		// 동일 대분류 선택시
        if($(this).siblings().attr('class') == '') {
            $(this).siblings().addClass('hidden');
    		$("#itemList").empty();
            getList();
            return;
        }
        
        // 초기 또는 다른 대분류 선택시
        $(".ct_lc_item_btn").each(function() {
            $(this).siblings().addClass('hidden');
        });
        
        // 선택 대분류 보여주기
        $(this).siblings().removeClass('hidden');
        lcCode = $(this).children().val();
		$("#itemList").empty();
        getList();
        
		console.log("lc : " + lcCode);
		console.log("mc : " + mcCode);
    });
    
    $(".ct_mc_item_btn").on("click",function() {
		$("#orderMethod").val('');
		mcCode = $(this).children().val();
		$("#itemList").empty();
        getList();
        
		console.log("lc : " + lcCode);
		console.log("mc : " + mcCode);
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
