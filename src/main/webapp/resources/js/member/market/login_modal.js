$(document).ready(function ( ) {
    document.querySelector(".btn_map_close").addEventListener("click", openModal);
    document.querySelector(".join_bg").addEventListener("click", closeModal);
    document.querySelector(".btn_join_close").addEventListener("click", closeModal);
});

function closeModal() {
	document.querySelector(".join_modal_wrap").classList.add("hidden");
    document.querySelector("#bot_header_border").style.position = "sticky";
    document.body.style.overflow = "auto";
}

function openModal(event) {
    event.preventDefault();
	document.querySelector(".join_modal_wrap").classList.remove("hidden");
	document.querySelector("#bot_header_border").style.position = "static";
	document.body.style.overflow = "hidden";
}