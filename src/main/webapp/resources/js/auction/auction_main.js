let pageNum = 1;
let maxPage = 1;
let listCount = '';
let pageListLimit = '';
let orderMethod = "";
let lcCode = '';
let mcCode = '';

$(function() { // onload
	let getParams = new URL(location.href).searchParams;
	if(getParams.get("mc_code") != null) mcCode = getParams.get("mc_code");
	if(getParams.get("lc_code") != null) mcCode = getParams.get("lc_code");
	
    getList();
    
    // 스크롤
    $(window).on("scroll",function() {
        let scrollTop = $(window).scrollTop();
        let windowHeight = $(window).height();
        let documentHeight = $(document).height();
        
        if(scrollTop + windowHeight + 1 >= documentHeight) {
            if (pageNum < maxPage) {
                pageNum++;
                getList();
            } 
        }
    });
	
	// 정렬
	$("#orderMethod").on("change",function() {
		pageNum = 1;
		maxPage = 1;
		orderMethod = $("#orderMethod").val();
		$("#itemList").empty();
		getList();
	});
	
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
    });
    
    $(".ct_mc_item_btn").on("click",function() {
		$("#orderMethod").val('');
		mcCode = $(this).children().val();
		$("#itemList").empty();
        getList();
	});
	
}); // onload

function getList() {
    $.ajax({
        type: "get"
        , url: "getAucList"
        , dataType: "json"
        , data: {
            'orderMethod': orderMethod
            , 'pageNum': pageNum
            , 'lc_code': lcCode
            , 'mc_code': mcCode
        } 
    })
    .done(function(data) {
        doneResult(data);
    })
    .fail(function() {
        failResult();
    });
}

const doneResult = data => {
    let pageInfo = data.pop();
    let path = window.location.pathname.substring(0, window.location.pathname.indexOf("/",2));
    maxPage = pageInfo.maxPage;
    listCount = pageInfo.listCount;
    pageListLimit = pageInfo.pageListLimit;
    
	let index = 0;
    for (let item of data) {
        let result =
            "<a href='AuctionDetail?auction_idx="+ item.auction_idx +"'>"
                + "<div class='auctionItem'>"
                    +"<img alt='테스트이미지' src='"+ path + item.image_path + "/" + item.image1 +"'>" 
                        +"<div>" 
                            + "상품명"
                            + item.auction_title
                        +"</div>"
                        +"<div>" 
                            + "상품가격"
                            + item.auc_start_price
                        +"</div>"
                        +"<div>"
                        	+"<div id='data"+index+"'>"
                        		+"<input type=hidden name='auction_idx' value='"+item.auction_idx+"'>"
                        		+"<input type=hidden name='auc_close_date' value='"+item.auc_close_date+"'>"
                        	+"</div>"
	                        +"<div id='remainingTime"+item.auction_idx+"'>"
	                        +"</div>"
                        +"</div>"
                    +"</div>"
                +"</a>";        
        $("#itemList").append(result);
        index++;
    }
};

const failResult = () => {
    console.log("fail");
};

// 시간카운트
const updateTimer = (idx, data) => {
	const future = Date.parse(data);
	const now = new Date();
	const diff = future - now;
	
	if (diff < 0) {
		$("#remainingTime"+idx).html("경매 마감");
	} else {
		const days = Math.floor(diff / (1000 * 60 * 60 * 24));
		const hours = Math.floor(diff / (1000 * 60 * 60));
		const mins = Math.floor(diff / (1000 * 60));
		const secs = Math.floor(diff / 1000);
		
		const d = days;
		const h = hours - days * 24;
		const m = mins - hours * 60;
		const s = secs - mins * 60;
		
		let result =  
		'<span>' + d + '<span>일</span>' +
		'<span>' + h + '<span>시</span>' +
		'<span>' + m + '<span>분</span>' +
		'<span>' + s + '<span>초</span>';
		
		$("#remainingTime"+idx).html(result);
	}
	
}

setInterval(() => {
	if (pageNum < maxPage) {
		let length = pageNum*pageListLimit;
		for(let i=0; i<length; i++) {
			let idx = $('div[id^=data]').eq(i).children('input[name^=auction]').val();
			let date = $('div[id^=data]').eq(i).children('input[name^=auc_close]').val();
			updateTimer(idx,date);
		}
	} else if(pageNum == maxPage) {
		let length = listCount;
		for(let i=0; i<=length; i++) {
			let idx = $('div[id^=data]').eq(i).children('input[name^=auction]').val();
			let date = $('div[id^=data]').eq(i).children('input[name^=auc_close]').val();
			updateTimer(idx,date);
		}
	}
	updateTimer()
}, 1000);

// 시간
const dateFormat = (data) => {
	let date = new Date(data)
    let month = date.getMonth() + 1;
    let day = date.getDate();
    let hour = date.getHours();
    let minute = date.getMinutes();
    let second = date.getSeconds();

    month = month >= 10 ? month : '0' + month;
    day = day >= 10 ? day : '0' + day;
    hour = hour >= 10 ? hour : '0' + hour;
    minute = minute >= 10 ? minute : '0' + minute;
//    second = second >= 10 ? second : '0' + second;

    return date.getFullYear() + '-' + month + '-' + day + ' ' + hour + ':' + minute;
}