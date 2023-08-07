/**
 * auction_detail html 파일의 자바 스크립트 파일
 * 
 * 구현 할것
 * 입찰팝업
 * 즉시구매 팝업
 * 참고 사이트 
 * https://m.blog.naver.com/dasol825/220672901113
 */

function tenderPopup() { 
   window.open("biddingPopup?auction_idx="+$("#auction_idx").val(), "입찰하기", "width=500, height=800, left=100, top=50"); }

function buyingPopup() { 
   window.open("buyingPopup?auction_idx="+$("#auction_idx").val(), "즉시구매하기", "width=500, height=800, left=100, top=50"); }
   
   
//삭제버튼 클릭시   
function confirmDelete() {
let isDelete = confirm("게시물을 삭제하시겠습니까?");

   // isDelete 가 true 일 때 BoardDelete 서블릿 요청
   if(isDelete) {
      location.href='BoardDelete?board_num=${board.board_num}&pageNum=${param.pageNum}';
   }
}

//이미지 슬라이드
let slideIndex = 1;
showSlides(slideIndex);

// Next/previous controls
function plusSlides(n) {
  showSlides(slideIndex += n);
}

// Thumbnail image controls
function currentSlide(n) {
  showSlides(slideIndex = n);
}

function showSlides(n) {
  let i;
  let slides = document.getElementsByClassName("mySlides");
  let dots = document.getElementsByClassName("dot");
  if (n > slides.length) {slideIndex = 1}
  if (n < 1) {slideIndex = slides.length}
  for (i = 0; i < slides.length; i++) {
    slides[i].style.display = "none";
  }
  for (i = 0; i < dots.length; i++) {
    dots[i].className = dots[i].className.replace(" active", "");
  }
//  slides[slideIndex-1].style.display = "block";
//  dots[slideIndex-1].className += " active";
}

$(function() {
    // 입찰내역 클릭
    $("#bidHistoryBtn").on("click",function() {
		if ($(this).attr('class') == 'btn') {
			$("#bidHistory").removeClass('d-none');
			$(this).addClass('on');
			$.ajax({
				type: 'get'
				, dataType: 'json'
				, url: 'bidHistory'
				, data: {
					auction_idx: $("#auction_idx").val()
				}
			})
			.done(function(data) {
				bidResult(data);
			})
			.fail(() => {
				console.log("fail");
			});
		} else {
			$(this).removeClass('on');
			$("#bidHistory").empty();
			$("#bidHistory").addClass('d-none');
		}
	});
});

const bidResult = (data) => {
	let result =
		"<div class='row'>"
				+ "<div class='col-2 text-center'>입찰자</div>"
				+ "<div class='col-3 text-center'>입찰가격</div>"
				+ "<div class='col-5 text-center'>거래시간</div>"
				+ "<div class='col-2 text-center'>상태</div>"
		+ "</div>";
	$("#bidHistory").append(result);
	
	for (let item of data) {
        let result =
			"<div class='row'>"
				+ "<div class='col-2 text-center'>"+item.mem_nickname+"</div>"
				+ "<div class='col-3 text-center'>"+item.bid_price+"</div>"
				+ "<div class='col-5 text-center'>"+dateFormat(item.bid_date)+"</div>"
				+ "<div class='col-2 text-center'>"+item.bid_state+"</div>"
			+ "</div>";
        $("#bidHistory").append(result);
	};	
};

// 찜하기 이벤트
const dibsCheck = () => {
    $.ajax({
        type: "post"
        , url: "dibsEvent"
        , data: {
            auction_idx: $("#auction_idx").val()
        }
        , dataType: "json"
        , success: function(data) {
            dibsResult(data)
        }
        ,error: function() {
            console.log("error");  
        }
    })
}

// 찜하기 이벤트 결과값
const dibsResult = (data) => {
    let path = window.location.pathname.substring(0, window.location.pathname.indexOf("/",2));
    if (data.result) {
        let result = "<img class='dibsImage' src='"+path+"/resources/img/auction/favorite-heart-true.svg'><span>"+data.dibsCount+"</span>"
        $("#dibsBox").children().empty();
        $("#dibsBox").children().append(result);
    } else {
        let result = "<img  class='dibsImage' src='"+path+"/resources/img/auction/favorite-heart-false.svg'><span>"+data.dibsCount+"</span>"
        $("#dibsBox").children().empty();
        $("#dibsBox").children().append(result);
    }
}

// 시간카운트
const updateTimer = () => {
    const future = Date.parse($("#auc_close_date").val());
    const now = new Date();
    const diff = future - now;
    
    if (diff < 0) {
        $("#acdBox").html("경매 마감");
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
        
        $("#acdBox").html(result);
    }
}

// 시간 반복
setInterval(() => {
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
    second = second >= 10 ? second : '0' + second;

    return date.getFullYear() + '-' + month + '-' + day + ' ' + hour + ':' + minute + ':' + second;
}
