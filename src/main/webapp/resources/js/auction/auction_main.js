let pageNum = 1;
let maxPage = 1;
let orderMethod = "";

$(function() { // onload

    getList();

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
	
	$("#orderMethod").on("change",function() {
		orderMethod = $("#orderMethod").val();
		pageNum = 1;
		maxPage = 1;
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
    maxPage = pageInfo.maxPage
    
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
                            + "등록일"
                            + dateFormat(item.auction_date)
                        +"</div>"
                    +"</div>"
                +"</a>";        
        $("#itemList").append(result);
    }
};

const failResult = () => {
    console.log("fail");
};

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