let pageNum = 1;
let maxPage = 1;
let lcCode = '';
let mcCode = '';

// onload
$(function() {
	getAuctionList();
	getCreamList();
})

// 경매
function getAuctionList() {
    $.ajax({
        type: "get"
        , url: "getAucList"
        , dataType: "json"
        , data: {
            'orderMethod': "popular"
            , 'pageNum': pageNum
            , 'lc_code': lcCode
            , 'mc_code': mcCode
            , 'main': '1'
        } 
    })
    .done(function(data) {
        doneAuctionResult(data);
    })
    .fail(function() {
        failAuctionResult();
    });
}

const doneAuctionResult = data => {
    let pageInfo = data.pop();
    let path = window.location.pathname.substring(0, window.location.pathname.indexOf("/",2));
    maxPage = pageInfo.maxPage;
    listCount = pageInfo.listCount;
    pageListLimit = pageInfo.pageListLimit;
    
	let index = 0;
    for (let item of data) {
        // 입찰내역이 있을경우 가격을 입찰가로 바꿔야함 가져올때 bid_list 도 같이 가져오자
        let price = 0;
        if(item.bid_price == null) {
            price = item.auc_start_price;
        } else {
            price = item.bid_price
        }
        let result = 
                "<div class='card col-lg-3 col-md-4 col-6'>"
                +"  <a href='AuctionDetail?auction_idx="+ item.auction_idx +"'>"
                +"      <img src='"+ path + item.image_path + "/" + item.image1 +"' class='card-img-top' alt='productImage'>"
                +"      <div class='card-body'>"
                +"        <h5 class='card-title'>"+item.auction_title+"</h5>"
                +"      </div>"
                +"      <ul class='list-group list-group-flush'>"
                +"        <li class='list-group-item'>가격 "+price+"원</li>"
                +"        <li class='list-group-item'>"
                +"          <div>"
                +"              <div id='data"+index+"'>"
                +"                  <input type=hidden name='auction_idx' value='"+item.auction_idx+"'>"
                +"                  <input type=hidden name='auc_close_date' value='"+item.auc_close_date+"'>"
                +"              </div>"
                +"              <div id='remainingTime"+item.auction_idx+"'>&nbsp;</div>"
                +"          </div>"
                +"        </li>"
                +"        <li class='list-group-item'>"
                +"          <div class='row'>"
                +"              <div class='col'>"
                +"                  <svg xmlns = 'http://www.w3.org/2000/svg' width = '16' height = '16' fill = 'currentColor' class='bi bi-eye' viewBox = '0 0 16 16' >"
                +"                      <path d='M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8zM1.173 8a13.133 13.133 0 0 1 1.66-2.043C4.12 4.668 5.88 3.5 8 3.5c2.12 0 3.879 1.168 5.168 2.457A13.133 13.133 0 0 1 14.828 8c-.058.087-.122.183-.195.288-.335.48-.83 1.12-1.465 1.755C11.879 11.332 10.119 12.5 8 12.5c-2.12 0-3.879-1.168-5.168-2.457A13.134 13.134 0 0 1 1.172 8z'/>"
                +"                      <path d='M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5zM4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0z'/>"
                +"                  </svg >" 
                +                   item.auction_readcount
                +"              </div>"
                +"              <div class='col'>"
                +"                  <svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-heart-fill' viewBox='0 0 16 16'>"
                +"                      <path fill-rule='evenodd' d='M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z'/>"
                +"                  </svg>" 
                +                   item.dibs_count
                +"              </div>"
                +"          </div>"
                +"        </li>"
                +"    </ul>"
                +"  </a>";
                +"</div>";
        $("#auctionList").append(result);
        index++;
    }
};

const failAuctionResult = () => {
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

// 크림
function getCreamList() {
	console.log("test");
    $.ajax({
        type: "get"
        , url: "getCreamList"
        , dataType: "json"
        , data: {
             'pageNum': pageNum
             , 'main': '1'
        } 
    })
    .done(function(data) {
        doneCreamResult(data);
    })
    .fail(function() {
        failCreamResult();
    });
}

const doneCreamResult = data => {
    let pageInfo = data.pop();
    let path = window.location.pathname.substring(0, window.location.pathname.indexOf("/",2));
    maxPage = pageInfo.maxPage;
    listCount = pageInfo.listCount;
    pageListLimit = pageInfo.pageListLimit;
    
    let index = 0;
    for (let item of data) {
        // 입찰내역이 있을경우 가격을 입찰가로 바꿔야함 가져올때 bid_list 도 같이 가져오자
  
        let result = 
                "<div class='card col-lg-3 col-md-4 col-6'>"
                +"  <a href='CreamDetail?cream_idx="+ item.cream_idx +"'>"
                +"      <img src='"+ path + item.image_path + "/" + item.image1 +"' class='card-img-top' alt='productImage'>"
                +"      <div class='card-body'>"
                +"        <h5 class='card-title'>"+item.cream_title+"</h5>"
                +"      </div>"
                +"      <ul class='list-group list-group-flush'>"
                +"        <li class='list-group-item'>가격 "+item.size220+"~ 원</li>"
                +"        <li class='list-group-item'>"
                +"          <div class='row'>"
                +"              <div class='col'>"
                +"                  <svg xmlns = 'http://www.w3.org/2000/svg' width = '16' height = '16' fill = 'currentColor' class='bi bi-eye' viewBox = '0 0 16 16' >"
                +"                      <path d='M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8zM1.173 8a13.133 13.133 0 0 1 1.66-2.043C4.12 4.668 5.88 3.5 8 3.5c2.12 0 3.879 1.168 5.168 2.457A13.133 13.133 0 0 1 14.828 8c-.058.087-.122.183-.195.288-.335.48-.83 1.12-1.465 1.755C11.879 11.332 10.119 12.5 8 12.5c-2.12 0-3.879-1.168-5.168-2.457A13.134 13.134 0 0 1 1.172 8z'/>"
                +"                      <path d='M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5zM4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0z'/>"
                +"                  </svg >" 
                +                   item.cream_readcount
                +"              </div>"
                +"              <div class='col'>"
                +"                  <svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-heart-fill' viewBox='0 0 16 16'>"
                +"                      <path fill-rule='evenodd' d='M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z'/>"
                +"                  </svg>" 
                +                   item.dibs_count
                +"              </div>"
                +"          </div>"
                +"        </li>"
                +"    </ul>"
                +"  </a>"
                +"</div>";
        $("#creamList").append(result);
        index++;
    }
};

const failCreamResult = () => {
    console.log("fail");
};