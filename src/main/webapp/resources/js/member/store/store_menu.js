/* 소개글 수정 클릭시 */
$(document).ready(function(){
    $("#intro_modify > button").click(function(){
        $('#intro_modify').css('display', 'none');
        $('.text_area').css('display', 'block');
    })
})
/* 소개글 수정 확인 클릭시 */
$(document).ready(function(){
    $(".text_area > button").click(function(){
        $('#intro_modify').css('display', 'block');
        $('.text_area').css('display', 'none');
    })
})


/* 하단 상품메뉴의 카테고리 호버 시 */
$(document).ready(function(){
    $(".goods_cate").hover(function(){
        $('.hidden_menu').css('display','block');
    })
})
/* 하단 상품메뉴의 카테고리 떠날 시 */
$(document).ready(function(){
    $(".goods_cate").mouseleave(function(){
        $('.hidden_menu').css('display', 'none');
    })
})


/* 하단 상점 메뉴 클릭 */
function common() {
    $('.my_store_menus').css('border', 'none');
    $('.my_store_menus').css('borderBottom', '1px solid black');
    $('.my_store_menus').css('fontWeight', 'normal');
    $('.my_store_menus').css('color', '#888');
    $('.my_store_menus').css('backgroundColor', '#FAFAFA');
}
function fn_border(change) {
    $(change).css('borderTop', '1px solid black');
    $(change).css('borderLeft', '1px solid black');
    $(change).css('borderRight', '1px solid black');
    $(change).css('borderBottom', 'none');
    $(change).css('fontWeight', 'bold');
    $(change).css('color', 'black');
    $(change).css('backgroundColor', 'white');
}


$(document).ready(function(){
    $(".sales_menu").click(function(){
        common();
        $('.common_menu').css('display', 'none');
        $('#sales_menu_area').css('display', 'block');
        fn_border(this);
        $('.follower_menu').css('borderRight', '1px solid rgb(238, 238, 238)');
    })
})

$(document).ready(function(){
    $(".purchases_menu").click(function(){
        common();
        $('.common_menu').css('display', 'none');
        $('#purchases_menu_area').css('display', 'block');
        fn_border(this);
        $('.sales_menu').css('borderLeft', '1px solid rgb(238, 238, 238)');
        $('.follower_menu').css('borderRight', '1px solid rgb(238, 238, 238)');
    })
})

$(document).ready(function(){
    $(".secondhandLike_menu").click(function(){
        common();
        $('.common_menu').css('display', 'none');
        $('#secondhandLike_menu_area').css('display', 'block');
        fn_border(this);
        $('.sales_menu').css('borderLeft', '1px solid rgb(238, 238, 238)');
        $('.follower_menu').css('borderRight', '1px solid rgb(238, 238, 238)');
    })
})

$(document).ready(function(){
    $(".auction_menu").click(function(){
        common();
        $('.common_menu').css('display', 'none');
        $('#auction_menu_area').css('display', 'block');
        fn_border(this);
        $('.sales_menu').css('borderLeft', '1px solid rgb(238, 238, 238)');
        $('.follower_menu').css('borderRight', '1px solid rgb(238, 238, 238)');
    })
})

$(document).ready(function(){
    $(".auctionbid_menu").click(function(){
        common();
        $('.common_menu').css('display', 'none');
        $('#auctionbid_menu_area').css('display', 'block');
        fn_border(this);
        $('.sales_menu').css('borderLeft', '1px solid rgb(238, 238, 238)');
        $('.follower_menu').css('borderRight', '1px solid rgb(238, 238, 238)');
    })
})

$(document).ready(function(){
    $(".auctionLike_menu").click(function(){
        common();
        $('.common_menu').css('display', 'none');
        $('#auctionLike_menu_area').css('display', 'block');
        fn_border(this);
        $('.sales_menu').css('borderLeft', '1px solid rgb(238, 238, 238)');
        $('.follower_menu').css('borderRight', '1px solid rgb(238, 238, 238)');
    })
})

$(document).ready(function(){
    $(".auctiongoods_menu").click(function(){
        common();
        $('.common_menu').css('display', 'none');
        $('#auctiongoods_menu_area').css('display', 'block');
        fn_border(this);
        $('.sales_menu').css('borderLeft', '1px solid rgb(238, 238, 238)');
        $('.follower_menu').css('borderRight', '1px solid rgb(238, 238, 238)');
    })
})
