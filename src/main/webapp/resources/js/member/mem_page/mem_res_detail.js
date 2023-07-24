$('.res_detail_article2 .menu_tit').click(function () {
    $(this).children('span').addClass('on');
    if ($(this).siblings('.res_con_wrap').children('.side_sub').is(':hidden')) {
        $(this).siblings('.res_con_wrap').children('.side_sub').slideDown();
        $(this).children('span').removeClass('on');
    } else {
        $(this).siblings('.res_con_wrap').children('.side_sub').slideUp();
    }
});

