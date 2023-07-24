/**
 *
 */

// 카테고리 확장 테스트
// dom 로드시 자동 동작
/*document.addEventListener("DOMContentLoaded", function () {
	
	// 대분류 항목
    let ctLc = document.querySelectorAll(".ct_lc_item");
    // 중분류 항목
    let ctMc = document.querySelectorAll(".ct_mc_item");
    // 소분류 항목
    let ctSc = document.querySelectorAll(".ct_sc_item");
    // 대분류 리스트 
    let lcList =  document.querySelector(".ct_lc_list");
    // 대분류에 해당하는 중분류 리스트 
    let mcList =  document.querySelectorAll(".ct_mc_list");
    // 중분류에 해당하는 소분류 리스트
    let scList =  document.querySelectorAll(".ct_sc_list"); 
	
	
	let nowMcList = null;
	let nowScList = null;
	
	// 이벤트 리스너 등록 
	// 대분류
	for(let lc of ctLc){
		// 대분류 항목 위에 마우스 올렸을때
		lc.addEventListener("mouseenter",() => {
			let mcl = document.querySelector("." + (lc.getAttribute("id") + "").trim());
			let scl = document.querySelectorAll("." + (mcl.getAttribute("id") + "").trim());
			
			//기존에 떠있는 항목들 삭제 
			
			for(let ml of mcList){
				ml.style.display = "none";
			}
			for(let sl of scl){
				sl.style.display = "none";
			}
			
			// 띄울 항목 띄우기
			mcl.style.display = "inline-block";
			// 현재 띄운 항목 저장 (추후 마우스 아웃될때 화면에서 지울수 있게)
			nowMcList = mcl;
		});
		

	}
	
	
	
	// 이벤트 리스너 등록
	// 중분류
	for(let mc of ctMc){
		mc.addEventListener("mouseenter",() => {
			let scl = document.querySelector("." + (mc.getAttribute("id") + "").trim());
			
			// 기존에 떠 있는 sl 항목 없애기
			for(let sl of scList){
				sl.style.display = "none";
			}	
			scl.style.display = "inline-block";			
			mc.style.display = "inline-block";		
			nowScList = scl;
		});
		
	}
	
	
	// 이벤트 리스너 등록
	// 소분류
	for(let sc of ctSc){
		
		// sc 로 넘어갔을때 이미 띄워져있는 중분류 를 유지하기 위한 준비
//		let mc = document.querySelector("#" + (sc.classList[1] + "").trim());
//		let lc = document.querySelector("." + (mc.classList[1] + "").trim());
		
		sc.addEventListener("mouseenter",() => {
			nowMcList.style.display = "inline-block";			
//			sc.style.display = "inline-block";			
			
		});
		
	}
	// 마우스 벗어났을때 이벤트 리스너 등록
	lcList.addEventListener("mouseleave",() => {
		for(let ml of mcList){
			ml.style.display = "none";
		}
		for(let sl of scList){
			sl.style.display = "none";
		}
		
	});
	// 마우스 벗어났을때 이벤트 리스너 등록
	for(let mc of mcList){		
		mc.addEventListener("mouseleave",(event) => {
			
			// 일단 현재 마우스가 어느 요소 위에 있는지 받아오기
			const element = document.elementFromPoint(event.clientX, event.clientY);
			
			if(!element.className.includes(categoryList)){				
				for(let ml of mcList){
					ml.style.display = "none";
				}
				for(let sl of scList){
					sl.style.display = "none";
				}		
			}
		});
	}
//	 마우스 벗어났을때 이벤트 리스너 등록
	for(let sc of scList){		
		sc.addEventListener("mouseleave",(event) => {
			// 일단 현재 마우스가 어느 요소 위에 있는지 받아오기
			const element = document.elementFromPoint(event.clientX, event.clientY);
			
			// 소분류에서 마우스를 벗어날때는 2가지 경우가 있음
			// 마우스가 완전히 벗어났을때
			// 또는 마우스가 중 카테고리에 있을때가 있을때
			// 만약 중 카테고리에 있을 때는 중 카테고리가 사라지지 않게 해야함!
			
			console.log(element)
//			if(nowMcList != null){				
//				nowMcList.style.display = "none";
//			}
//			if(nowScList != null){				
//				nowScList.style.display = "none";
//			}
		});
	}
	
});*/


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
