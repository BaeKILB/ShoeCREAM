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
    function getFormatDate(date) {
        let targetDate = /(\d\d)(\d\d)-(\d\d)-(\d\d)\s(\d\d):(\d\d):(\d\d).(\d)/g;
        let formatDate = "$2-$3-$4 $5:$6";
        return date.replace(targetDate, formatDate);
    }
    
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
                            + getFormatDate(item.auction_date)
                        +"</div>"
                    +"</div>"
                +"</a>";        
        $("#itemList").append(result);
    }
};

const failResult = () => {
    console.log("fail");
};