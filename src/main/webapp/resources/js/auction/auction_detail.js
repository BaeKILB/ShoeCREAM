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
    // 찜하기 클릭
    $("#dibsBox").on("click",function() {
        dibsCheck();
    });
    
    // 판매자정보 클릭
    $("#sellerInfo").on("click",function() {
        location.href="판매자상점?mem_idx="+$("#mem_idx").val(); 
    });
});

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
        $("#dibsBox").empty();
        $("#dibsBox").append(result);
    } else {
        let result = "<img  class='dibsImage' src='"+path+"/resources/img/auction/favorite-heart-false.svg'><span>"+data.dibsCount+"</span>"
        $("#dibsBox").empty();
        $("#dibsBox").append(result);
    }
}

// 시간
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


