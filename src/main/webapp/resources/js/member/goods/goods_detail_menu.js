
/* 카테고리 마우스 호버 시 */
$(document).ready(function(){
    $(".entire_bar").hover(function(){
        $('.entire_bar > .hidden_menu').css('display','block');
    })
    $(".category_clothes_bar").hover(function(){
        $('.category_clothes_bar > .hidden_menu').css('display','block');
    })
    $(".category_acc_bar").hover(function(){
        $('.category_acc_bar > .hidden_menu').css('display','block');
    })
})
/* 카테고리 마우스 떠날 시 */
$(document).ready(function(){
    $(".entire_bar").mouseleave(function(){
        $('.entire_bar > .hidden_menu').css('display', 'none');
    })
    $(".category_clothes_bar").mouseleave(function(){
        $('.category_clothes_bar > .hidden_menu').css('display', 'none');
    })
    $(".category_acc_bar").mouseleave(function(){
        $('.category_acc_bar > .hidden_menu').css('display', 'none');
    })
})