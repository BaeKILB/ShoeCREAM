$(document).ready(function ( ) {
    document.querySelectorAll("div.status_filter > button").forEach(btn => {
        btn.addEventListener("click", function() {
            document.querySelectorAll("div.status_filter > button").forEach(sib => {
                sib.classList.remove("active");
            })
            btn.classList.add("active");
        })
    })
});