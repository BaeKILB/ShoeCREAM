

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





// 찜하기 이벤트
const dibsCheck = () => {
    $.ajax({
        type: "post"
        , url: "dibsEvent2"
        , data: {
            cream_idx: $("#cream_idx").val()
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
//
//$(document).ready(function() {
//    $("#dibsBox").on("click", function(event) {
//        event.preventDefault(); // 폼 제출을 막음
//        dibsCheck(); // dibsCheck() 함수 호출
//    });
//});

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
