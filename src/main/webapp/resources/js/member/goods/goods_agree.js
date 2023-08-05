
/* 약관동의 체크 클릭 시 */
$(document).ready(function(){
    const change = ".agree_content > div > i";

    const rgb = 'rgb(229, 229, 229)';
    const red = 'red';
    let bool = true;

    $(change).click(function(){
        if(bool) {
            $(this).css('backgroundColor', red);
            bool = false;
        }else {
            $(this).css('backgroundColor', rgb);
            bool = true;
        }
    })
})

