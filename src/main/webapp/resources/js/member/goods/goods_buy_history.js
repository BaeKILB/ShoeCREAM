$(document).ready(function ( ) {
    /* 반품신청 */
    document.querySelector("button.btn_return").addEventListener("click", openReturnModal);
    document.querySelector(".return_bg").addEventListener("click", closeReturnModal);
    document.querySelectorAll("div.modal_return_area .btn_area > *").forEach(btn => {
        btn.addEventListener("click", closeReturnModal)
    });

    /* 구매확정 */
    document.querySelector("button.btn_buy_decide").addEventListener("click", openDecideModal);
    document.querySelector(".decide_bg").addEventListener("click", closeDecideModal);
    document.querySelectorAll("div.modal_decide_area .btn_area > *").forEach(btn => {
        btn.addEventListener("click", closeDecideModal)
    });
    
    /* 리뷰작성 */
    document.querySelector("button.btn_review_modal").addEventListener("click", openReviewModal);
    document.querySelector(".review_bg").addEventListener("click", closeReviewModal);
    document.querySelectorAll("div.modal_review_area .btn_area > *").forEach(btn => {
        btn.addEventListener("click", closeReviewModal)
    });

});

function closeReturnModal() {
	document.querySelector(".modal_return_area").classList.add("hidden");
    document.body.style.overflow = "auto";
}

function openReturnModal(event) {
    event.preventDefault();
	document.querySelector(".modal_return_area").classList.remove("hidden");
	document.body.style.overflow = "hidden";
}

function closeDecideModal() {
	document.querySelector(".modal_decide_area").classList.add("hidden");
    document.body.style.overflow = "auto";
}

function openDecideModal(event) {
    event.preventDefault();
	document.querySelector(".modal_decide_area").classList.remove("hidden");
	document.body.style.overflow = "hidden";
}

function closeReviewModal() {
	document.querySelector(".modal_review_area").classList.add("hidden");
    document.body.style.overflow = "auto";
}

function openReviewModal(event) {
    event.preventDefault();
	document.querySelector(".modal_review_area").classList.remove("hidden");
	document.body.style.overflow = "hidden";
}