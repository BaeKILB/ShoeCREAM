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
   window.open("biddingPopup?auction_idx="+$("#auction_idx").val(), "입찰하기", "width=400, height=800, left=100, top=50"); }

function buyingPopup() { 
   window.open("buyingPopup", "즉시구매하기", "width=400, height=800, left=100, top=50"); }
   
   
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
  slides[slideIndex-1].style.display = "block";
  dots[slideIndex-1].className += " active";
}