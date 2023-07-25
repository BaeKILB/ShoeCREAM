$(document).ready(function ( ) {
    document.querySelector(".all_goods_show_num > .show").addEventListener("click", showLi);
    document.querySelector(".all_goods_show_status > .show").addEventListener("click", showLi);
    document.querySelector(".goods_status_show > .show").addEventListener("click", showLi);

    document.querySelectorAll(".all_goods_show_num li:not(.show)").forEach(ele => {
        ele.addEventListener("click", clickLi);
    });
    document.querySelectorAll(".all_goods_show_status li:not(.show)").forEach(ele => {
        ele.addEventListener("click", clickLi);
    });
    document.querySelectorAll(".goods_status_show li:not(.show)").forEach(ele => {
        ele.addEventListener("click", clickLi);
    });
});

function showLi() {
    this.parentElement.style.overflow = "visible"
}

function clickLi() {
    let selected = this.innerText;
    this.parentElement.parentElement.removeAttribute("style");
    this.parentElement.previousElementSibling.firstElementChild.innerText = selected;
}