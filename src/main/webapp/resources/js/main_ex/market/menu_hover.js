
/* 햄버거에 마우스 호버 시 */
$(document).ready(function(){
    $(".hamburger").hover(function(){
        $('#menu').attr('src', 'resources/images/market/ch_hamburger.png');
        $('#test_cates').css('display', 'block');
    })
/* 햄버거에서 마우스 떠날 시 */
    $(".hamburger").mouseleave(function(){
        $('#menu').attr('src', 'resources/images/market/hamburger.png');
        $('#test_cates').css('display', 'none');
    })


/* 대분류 메뉴 호버 시*/
    $("#test_cates").hover(function(){
        $('#test_cates').css('display', 'block');
    })
/* 대분류 메뉴 떠날 시 */
    $("#test_cates").mouseleave(function(){
        $('#test_cates').css('display', 'none');
    })


/* 대분류 */
/* 패션의류에 호버 시 */
    $("#clothes").hover(function(){
	
        $('#test_clos').css('display', 'block');
        $('#test_cates > h2 > span').css('display', 'block');
    })
/* 패션의류에서 떠날 시 */
    $("#clothes").mouseleave(function(){
        $('#test_clos').css('display', 'none');
        $('#test_cates > h2 > span').css('display', 'none');
    })
/* 패션잡화에 호버 시 */
    $("#acc").hover(function(){
        $('#test_accs').css('display', 'block');
        $('#test_cates > h2 > span').css('display', 'block');
    })
/* 패션잡화에서 떠날 시 */
    $("#acc").mouseleave(function(){
        $('#test_accs').css('display', 'none');
        $('#test_cates > h2 > span').css('display', 'none');
    })
/* 취미/컬렉션에 호버 시 */
    $("#hobby").hover(function(){
        $('#test_hobby').css('display', 'block');
        $('#test_cates > h2 > span').css('display', 'block');
    })
/* 취미/컬렉션에서 떠날 시 */
    $("#hobby").mouseleave(function(){
        $('#test_hobby').css('display', 'none');
        $('#test_cates > h2 > span').css('display', 'none');
    })
/* 디지털에 호버 시 */
    $("#digital").hover(function(){
        $('#test_digital').css('display', 'block');
        $('#test_cates > h2 > span').css('display', 'block');
    })
/* 디지털에서 떠날 시 */
    $("#digital").mouseleave(function(){
        $('#test_digital').css('display', 'none');
        $('#test_cates > h2 > span').css('display', 'none');
    })
/* 스포츠/레저에 호버 시 */
    $("#sports").hover(function(){
        $('#test_sports').css('display', 'block');
        $('#test_cates > h2 > span').css('display', 'block');
    })
/* 스포츠/레저에서 떠날 시 */
    $("#sports").mouseleave(function(){
        $('#test_sports').css('display', 'none');
        $('#test_cates > h2 > span').css('display', 'none');
    })
/* 뷰티에 호버 시 */
    $("#beauty").hover(function(){
        $('#test_beauty').css('display', 'block');
        $('#test_cates > h2 > span').css('display', 'block');
    })
/* 뷰티에서 떠날 시 */
    $("#beauty").mouseleave(function(){
        $('#test_beauty').css('display', 'none');
        $('#test_cates > h2 > span').css('display', 'none');
    })
/* 생활/가전에 호버 시 */
    $("#life").hover(function(){
        $('#test_life').css('display', 'block');
        $('#test_cates > h2 > span').css('display', 'block');
    })
/* 생활/가전에서 떠날 시 */
    $("#life").mouseleave(function(){
        $('#test_life').css('display', 'none');
        $('#test_cates > h2 > span').css('display', 'none');
    })
/* 자동차/공구에 호버 시 */
    $("#car").hover(function(){
        $('#test_car').css('display', 'block');
        $('#test_cates > h2 > span').css('display', 'block');
    })
/* 자동차/공구에서 떠날 시 */
    $("#car").mouseleave(function(){
        $('#test_car').css('display', 'none');
        $('#test_cates > h2 > span').css('display', 'none');
    })
/* 도서/기타에 호버 시 */
    $("#book").hover(function(){
        $('#test_book').css('display', 'block');
        $('#test_cates > h2 > span').css('display', 'block');
    })
/* 도서/기타에서 떠날 시 */
    $("#book").mouseleave(function(){
        $('#test_book').css('display', 'none');
        $('#test_cates > h2 > span').css('display', 'none');
    })


/* 중분류 표시 */
    $("#test_clos").hover(function(){
        $('#test_cates').css('display', 'block');
        $('#test_clos').css('display', 'block');

        $('#test_cates > h2 > span').css('display', 'block');
    })
    
    $("#test_clos").mouseleave(function(){
        $('#test_cates').css('display', 'block');

        $('#test_clos').css('display', 'none');
    })


    $("#test_accs").hover(function(){
        $('#test_cates').css('display', 'block');
        $('#test_accs').css('display', 'block');


        $('#test_cates > h2 > span').css('display', 'block');
    })
    
    $("#test_accs").mouseleave(function(){
        $('#test_cates').css('display', 'block');

        $('#test_accs').css('display', 'none');
    })
    
    $("#test_hobby").hover(function(){
        $('#test_cates').css('display', 'block');
        $('#test_hobby').css('display', 'block');


        $('#test_cates > h2 > span').css('display', 'block');
    })
    
    $("#test_hobby").mouseleave(function(){
        $('#test_cates').css('display', 'block');

        $('#test_hobby').css('display', 'none');
    })
    
    $("#test_digital").hover(function(){
        $('#test_cates').css('display', 'block');
        $('#test_digital').css('display', 'block');


        $('#test_cates > h2 > span').css('display', 'block');
    })
    
    $("#test_digital").mouseleave(function(){
        $('#test_cates').css('display', 'block');

        $('#test_digital').css('display', 'none');
    })
    
    $("#test_sports").hover(function(){
        $('#test_cates').css('display', 'block');
        $('#test_sports').css('display', 'block');


        $('#test_cates > h2 > span').css('display', 'block');
    })
    
    $("#test_sports").mouseleave(function(){
        $('#test_cates').css('display', 'block');

        $('#test_sports').css('display', 'none');
    })
    
    $("#test_beauty").hover(function(){
        $('#test_cates').css('display', 'block');
        $('#test_beauty').css('display', 'block');


        $('#test_cates > h2 > span').css('display', 'block');
    })
    
    $("#test_beauty").mouseleave(function(){
        $('#test_cates').css('display', 'block');

        $('#test_beauty').css('display', 'none');
    })
    
    $("#test_life").hover(function(){
        $('#test_cates').css('display', 'block');
        $('#test_life').css('display', 'block');


        $('#test_cates > h2 > span').css('display', 'block');
    })
    
    $("#test_life").mouseleave(function(){
        $('#test_cates').css('display', 'block');

        $('#test_life').css('display', 'none');
    })
    
    $("#test_car").hover(function(){
        $('#test_cates').css('display', 'block');
        $('#test_car').css('display', 'block');


        $('#test_cates > h2 > span').css('display', 'block');
    })
    
    $("#test_car").mouseleave(function(){
        $('#test_cates').css('display', 'block');

        $('#test_car').css('display', 'none');
    })
    
    $("#test_book").hover(function(){
        $('#test_cates').css('display', 'block');
        $('#test_book').css('display', 'block');


        $('#test_cates > h2 > span').css('display', 'block');
    })
    
    $("#test_book").mouseleave(function(){
        $('#test_cates').css('display', 'block');

        $('#test_book').css('display', 'none');
    })
    /* 소 분류 */
    $("#test_bookA").hover(function(){
        $('#test_cates').css('display', 'block');
        $('#test_book').css('display', 'block');
        $('#test_bookAA').css('display', 'block');


        $('#test_cates > h2 > span').css('display', 'block');
    })
    
    $("#test_bookA").mouseleave(function(){
        $('#test_cates').css('display', 'block');

        $('#test_book').css('display', 'none');
        $('#test_bookAA').css('display', 'none');
    }) 
    
    $("#test_bookAA").hover(function(){
        $('#test_cates').css('display', 'block');
        $('#test_book').css('display', 'block');
        $('#test_bookAA').css('display', 'block');


        $('#test_cates > h2 > span').css('display', 'block');
    })
    
    $("#test_bookAA").mouseleave(function(){
        $('#test_cates').css('display', 'block');

        $('#test_book').css('display', 'none');
        $('#test_bookAA').css('display', 'none');
    })
    /* 한개 소분류 끝*/    
    
    /* 소 분류 */
    $("#test_bookB").hover(function(){
        $('#test_cates').css('display', 'block');
        $('#test_book').css('display', 'block');
        $('#test_bookBB').css('display', 'block');


        $('#test_cates > h2 > span').css('display', 'block');
    })
    
    $("#test_bookB").mouseleave(function(){
        $('#test_cates').css('display', 'block');

        $('#test_book').css('display', 'none');
        $('#test_bookBB').css('display', 'none');
    }) 
    
    $("#test_bookBB").hover(function(){
        $('#test_cates').css('display', 'block');
        $('#test_book').css('display', 'block');
        $('#test_bookBB').css('display', 'block');


        $('#test_cates > h2 > span').css('display', 'block');
    })
    
    $("#test_bookBB").mouseleave(function(){
        $('#test_cates').css('display', 'block');

        $('#test_book').css('display', 'none');
        $('#test_bookBB').css('display', 'none');
    })
    /* 한개 소분류 끝*/    
    
    /* 소 분류 */
    $("#test_bookC").hover(function(){
        $('#test_cates').css('display', 'block');
        $('#test_book').css('display', 'block');
        $('#test_bookCC').css('display', 'block');


        $('#test_cates > h2 > span').css('display', 'block');
    })
    
    $("#test_bookC").mouseleave(function(){
        $('#test_cates').css('display', 'block');

        $('#test_book').css('display', 'none');
        $('#test_bookCC').css('display', 'none');
    }) 
    
    $("#test_bookCC").hover(function(){
        $('#test_cates').css('display', 'block');
        $('#test_book').css('display', 'block');
        $('#test_bookCC').css('display', 'block');


        $('#test_cates > h2 > span').css('display', 'block');
    })
    
    $("#test_bookCC").mouseleave(function(){
        $('#test_cates').css('display', 'block');

        $('#test_book').css('display', 'none');
        $('#test_bookCC').css('display', 'none');
    })
    /* 한개 소분류 끝*/    
    
    /* 소 분류 */
    $("#test_bookD").hover(function(){
        $('#test_cates').css('display', 'block');
        $('#test_book').css('display', 'block');
        $('#test_bookDD').css('display', 'block');


        $('#test_cates > h2 > span').css('display', 'block');
    })
    
    $("#test_bookD").mouseleave(function(){
        $('#test_cates').css('display', 'block');

        $('#test_book').css('display', 'none');
        $('#test_bookDD').css('display', 'none');
    }) 
    
    $("#test_bookDD").hover(function(){
        $('#test_cates').css('display', 'block');
        $('#test_book').css('display', 'block');
        $('#test_bookDD').css('display', 'block');


        $('#test_cates > h2 > span').css('display', 'block');
    })
    
    $("#test_bookDD").mouseleave(function(){
        $('#test_cates').css('display', 'block');

        $('#test_book').css('display', 'none');
        $('#test_bookDD').css('display', 'none');
    })
    /* 한개 소분류 끝*/    
    
    /* 소 분류 */
    $("#test_carA").hover(function(){
        $('#test_cates').css('display', 'block');
        $('#test_car').css('display', 'block');
        $('#test_carAA').css('display', 'block');


        $('#test_cates > h2 > span').css('display', 'block');
    })
    
    $("#test_carA").mouseleave(function(){
        $('#test_cates').css('display', 'block');

        $('#test_car').css('display', 'none');
        $('#test_carAA').css('display', 'none');
    }) 
    
    $("#test_carAA").hover(function(){
        $('#test_cates').css('display', 'block');
        $('#test_car').css('display', 'block');
        $('#test_carAA').css('display', 'block');


        $('#test_cates > h2 > span').css('display', 'block');
    })
    
    $("#test_carAA").mouseleave(function(){
        $('#test_cates').css('display', 'block');

        $('#test_car').css('display', 'none');
        $('#test_carAA').css('display', 'none');
    })
    /* 한개 소분류 끝*/    
    
    /* 소 분류 */
    $("#test_carB").hover(function(){
        $('#test_cates').css('display', 'block');
        $('#test_car').css('display', 'block');
        $('#test_carBB').css('display', 'block');


        $('#test_cates > h2 > span').css('display', 'block');
    })
    
    $("#test_carB").mouseleave(function(){
        $('#test_cates').css('display', 'block');

        $('#test_car').css('display', 'none');
        $('#test_carBB').css('display', 'none');
    }) 
    
    $("#test_carBB").hover(function(){
        $('#test_cates').css('display', 'block');
        $('#test_car').css('display', 'block');
        $('#test_carBB').css('display', 'block');


        $('#test_cates > h2 > span').css('display', 'block');
    })
    
    $("#test_carBB").mouseleave(function(){
        $('#test_cates').css('display', 'block');

        $('#test_car').css('display', 'none');
        $('#test_carBB').css('display', 'none');
    })
    /* 한개 소분류 끝*/    
    
    /* 소 분류 */
    $("#test_lifeA").hover(function(){
        $('#test_cates').css('display', 'block');
        $('#test_life').css('display', 'block');
        $('#test_lifeAA').css('display', 'block');


        $('#test_cates > h2 > span').css('display', 'block');
    })
    
    $("#test_lifeA").mouseleave(function(){
        $('#test_cates').css('display', 'block');

        $('#test_life').css('display', 'none');
        $('#test_lifeAA').css('display', 'none');
    }) 
    
    $("#test_lifeAA").hover(function(){
        $('#test_cates').css('display', 'block');
        $('#test_life').css('display', 'block');
        $('#test_lifeAA').css('display', 'block');


        $('#test_cates > h2 > span').css('display', 'block');
    })
    
    $("#test_lifeAA").mouseleave(function(){
        $('#test_cates').css('display', 'block');

        $('#test_life').css('display', 'none');
        $('#test_lifeAA').css('display', 'none');
    })
    /* 한개 소분류 끝*/    
    
    /* 소 분류 */
    $("#test_lifeB").hover(function(){
        $('#test_cates').css('display', 'block');
        $('#test_life').css('display', 'block');
        $('#test_lifeBB').css('display', 'block');


        $('#test_cates > h2 > span').css('display', 'block');
    })
    
    $("#test_lifeB").mouseleave(function(){
        $('#test_cates').css('display', 'block');

        $('#test_life').css('display', 'none');
        $('#test_lifeBB').css('display', 'none');
    }) 
    
    $("#test_lifeBB").hover(function(){
        $('#test_cates').css('display', 'block');
        $('#test_life').css('display', 'block');
        $('#test_lifeBB').css('display', 'block');


        $('#test_cates > h2 > span').css('display', 'block');
    })
    
    $("#test_lifeBB").mouseleave(function(){
        $('#test_cates').css('display', 'block');

        $('#test_life').css('display', 'none');
        $('#test_lifeBB').css('display', 'none');
    })
    /* 한개 소분류 끝*/    
    
    /* 소 분류 */
    $("#test_lifeC").hover(function(){
        $('#test_cates').css('display', 'block');
        $('#test_life').css('display', 'block');
        $('#test_lifeCC').css('display', 'block');


        $('#test_cates > h2 > span').css('display', 'block');
    })
    
    $("#test_lifeC").mouseleave(function(){
        $('#test_cates').css('display', 'block');

        $('#test_life').css('display', 'none');
        $('#test_lifeCC').css('display', 'none');
    }) 
    
    $("#test_lifeCC").hover(function(){
        $('#test_cates').css('display', 'block');
        $('#test_life').css('display', 'block');
        $('#test_lifeCC').css('display', 'block');


        $('#test_cates > h2 > span').css('display', 'block');
    })
    
    $("#test_lifeCC").mouseleave(function(){
        $('#test_cates').css('display', 'block');

        $('#test_life').css('display', 'none');
        $('#test_lifeCC').css('display', 'none');
    })
    /* 한개 소분류 끝*/    
    
    /* 소 분류 */
    $("#test_lifeD").hover(function(){
        $('#test_cates').css('display', 'block');
        $('#test_life').css('display', 'block');
        $('#test_lifeDD').css('display', 'block');


        $('#test_cates > h2 > span').css('display', 'block');
    })
    
    $("#test_lifeD").mouseleave(function(){
        $('#test_cates').css('display', 'block');

        $('#test_life').css('display', 'none');
        $('#test_lifeDD').css('display', 'none');
    }) 
    
    $("#test_lifeDD").hover(function(){
        $('#test_cates').css('display', 'block');
        $('#test_life').css('display', 'block');
        $('#test_lifeDD').css('display', 'block');


        $('#test_cates > h2 > span').css('display', 'block');
    })
    
    $("#test_lifeDD").mouseleave(function(){
        $('#test_cates').css('display', 'block');

        $('#test_life').css('display', 'none');
        $('#test_lifeDD').css('display', 'none');
    })
    /* 한개 소분류 끝*/    
    
    /* 소 분류 */
    $("#test_beautyA").hover(function(){
        $('#test_cates').css('display', 'block');
        $('#test_beauty').css('display', 'block');
        $('#test_beautyAA').css('display', 'block');


        $('#test_cates > h2 > span').css('display', 'block');
    })
    
    $("#test_beautyA").mouseleave(function(){
        $('#test_cates').css('display', 'block');

        $('#test_beauty').css('display', 'none');
        $('#test_beautyAA').css('display', 'none');
    }) 
    
    $("#test_beautyAA").hover(function(){
        $('#test_cates').css('display', 'block');
        $('#test_beauty').css('display', 'block');
        $('#test_beautyAA').css('display', 'block');


        $('#test_cates > h2 > span').css('display', 'block');
    })
    
    $("#test_beautyAA").mouseleave(function(){
        $('#test_cates').css('display', 'block');

        $('#test_beauty').css('display', 'none');
        $('#test_beautyAA').css('display', 'none');
    })
    /* 한개 소분류 끝*/    
    
    /* 소 분류 */
    $("#test_beautyB").hover(function(){
        $('#test_cates').css('display', 'block');
        $('#test_beauty').css('display', 'block');
        $('#test_beautyBB').css('display', 'block');


        $('#test_cates > h2 > span').css('display', 'block');
    })
    
    $("#test_beautyB").mouseleave(function(){
        $('#test_cates').css('display', 'block');

        $('#test_beauty').css('display', 'none');
        $('#test_beautyBB').css('display', 'none');
    }) 
    
    $("#test_beautyBB").hover(function(){
        $('#test_cates').css('display', 'block');
        $('#test_beauty').css('display', 'block');
        $('#test_beautyBB').css('display', 'block');


        $('#test_cates > h2 > span').css('display', 'block');
    })
    
    $("#test_beautyBB").mouseleave(function(){
        $('#test_cates').css('display', 'block');

        $('#test_beauty').css('display', 'none');
        $('#test_beautyBB').css('display', 'none');
    })
    /* 한개 소분류 끝*/    
    
    /* 소 분류 */
    $("#test_sportsA").hover(function(){
        $('#test_cates').css('display', 'block');
        $('#test_sports').css('display', 'block');
        $('#test_sportsAA').css('display', 'block');


        $('#test_cates > h2 > span').css('display', 'block');
    })
    
    $("#test_sportsA").mouseleave(function(){
        $('#test_cates').css('display', 'block');

        $('#test_sports').css('display', 'none');
        $('#test_sportsAA').css('display', 'none');
    }) 
    
    $("#test_sportsAA").hover(function(){
        $('#test_cates').css('display', 'block');
        $('#test_sports').css('display', 'block');
        $('#test_sportsAA').css('display', 'block');


        $('#test_cates > h2 > span').css('display', 'block');
    })
    
    $("#test_sportsAA").mouseleave(function(){
        $('#test_cates').css('display', 'block');

        $('#test_sports').css('display', 'none');
        $('#test_sportsAA').css('display', 'none');
    })
    /* 한개 소분류 끝*/    
    
    /* 소 분류 */
    $("#test_sportsB").hover(function(){
        $('#test_cates').css('display', 'block');
        $('#test_sports').css('display', 'block');
        $('#test_sportsBB').css('display', 'block');


        $('#test_cates > h2 > span').css('display', 'block');
    })
    
    $("#test_sportsB").mouseleave(function(){
        $('#test_cates').css('display', 'block');

        $('#test_sports').css('display', 'none');
        $('#test_sportsBB').css('display', 'none');
    }) 
    
    $("#test_sportsBB").hover(function(){
        $('#test_cates').css('display', 'block');
        $('#test_sports').css('display', 'block');
        $('#test_sportsBB').css('display', 'block');


        $('#test_cates > h2 > span').css('display', 'block');
    })
    
    $("#test_sportsBB").mouseleave(function(){
        $('#test_cates').css('display', 'block');

        $('#test_sports').css('display', 'none');
        $('#test_sportsBB').css('display', 'none');
    })
    /* 한개 소분류 끝*/    
    
    /* 소 분류 */
    $("#test_sportsC").hover(function(){
        $('#test_cates').css('display', 'block');
        $('#test_sports').css('display', 'block');
        $('#test_sportsCC').css('display', 'block');


        $('#test_cates > h2 > span').css('display', 'block');
    })
    
    $("#test_sportsC").mouseleave(function(){
        $('#test_cates').css('display', 'block');

        $('#test_sports').css('display', 'none');
        $('#test_sportsCC').css('display', 'none');
    }) 
    
    $("#test_sportsCC").hover(function(){
        $('#test_cates').css('display', 'block');
        $('#test_sports').css('display', 'block');
        $('#test_sportsCC').css('display', 'block');


        $('#test_cates > h2 > span').css('display', 'block');
    })
    
    $("#test_sportsCC").mouseleave(function(){
        $('#test_cates').css('display', 'block');

        $('#test_sports').css('display', 'none');
        $('#test_sportsCC').css('display', 'none');
    })
    /* 한개 소분류 끝*/   
     
    /* 소 분류 */
    $("#test_sportsD").hover(function(){
        $('#test_cates').css('display', 'block');
        $('#test_sports').css('display', 'block');
        $('#test_sportsDD').css('display', 'block');


        $('#test_cates > h2 > span').css('display', 'block');
    })
    
    $("#test_sportsD").mouseleave(function(){
        $('#test_cates').css('display', 'block');

        $('#test_sports').css('display', 'none');
        $('#test_sportsDD').css('display', 'none');
    }) 
    
    $("#test_sportsDD").hover(function(){
        $('#test_cates').css('display', 'block');
        $('#test_sports').css('display', 'block');
        $('#test_sportsDD').css('display', 'block');


        $('#test_cates > h2 > span').css('display', 'block');
    })
    
    $("#test_sportsDD").mouseleave(function(){
        $('#test_cates').css('display', 'block');

        $('#test_sports').css('display', 'none');
        $('#test_sportsDD').css('display', 'none');
    })
    /* 한개 소분류 끝*/    
    
    /* 소 분류 */
    $("#test_sportsD").hover(function(){
        $('#test_cates').css('display', 'block');
        $('#test_sports').css('display', 'block');
        $('#test_sportsDD').css('display', 'block');


        $('#test_cates > h2 > span').css('display', 'block');
    })
    
    $("#test_sportsD").mouseleave(function(){
        $('#test_cates').css('display', 'block');

        $('#test_sports').css('display', 'none');
        $('#test_sportsDD').css('display', 'none');
    }) 
    
    $("#test_sportsDD").hover(function(){
        $('#test_cates').css('display', 'block');
        $('#test_sports').css('display', 'block');
        $('#test_sportsDD').css('display', 'block');


        $('#test_cates > h2 > span').css('display', 'block');
    })
    
    $("#test_sportsDD").mouseleave(function(){
        $('#test_cates').css('display', 'block');

        $('#test_sports').css('display', 'none');
        $('#test_sportsDD').css('display', 'none');
    })
    /* 한개 소분류 끝*/    
    
    /* 소 분류 */
    $("#test_digitalA").hover(function(){
        $('#test_cates').css('display', 'block');
        $('#test_digital').css('display', 'block');
        $('#test_digitalAA').css('display', 'block');


        $('#test_cates > h2 > span').css('display', 'block');
    })
    
    $("#test_digitalA").mouseleave(function(){
        $('#test_cates').css('display', 'block');

        $('#test_digital').css('display', 'none');
        $('#test_digitalAA').css('display', 'none');
    }) 
    
    $("#test_digitalAA").hover(function(){
        $('#test_cates').css('display', 'block');
        $('#test_digital').css('display', 'block');
        $('#test_digitalAA').css('display', 'block');


        $('#test_cates > h2 > span').css('display', 'block');
    })
    
    $("#test_digitalAA").mouseleave(function(){
        $('#test_cates').css('display', 'block');

        $('#test_digital').css('display', 'none');
        $('#test_digitalAA').css('display', 'none');
    })
    /* 한개 소분류 끝*/    
    
    /* 소 분류 */
    $("#test_digitalB").hover(function(){
        $('#test_cates').css('display', 'block');
        $('#test_digital').css('display', 'block');
        $('#test_digitalBB').css('display', 'block');


        $('#test_cates > h2 > span').css('display', 'block');
    })
    
    $("#test_digitalB").mouseleave(function(){
        $('#test_cates').css('display', 'block');

        $('#test_digital').css('display', 'none');
        $('#test_digitalBB').css('display', 'none');
    }) 
    
    $("#test_digitalBB").hover(function(){
        $('#test_cates').css('display', 'block');
        $('#test_digital').css('display', 'block');
        $('#test_digitalBB').css('display', 'block');


        $('#test_cates > h2 > span').css('display', 'block');
    })
    
    $("#test_digitalBB").mouseleave(function(){
        $('#test_cates').css('display', 'block');

        $('#test_digital').css('display', 'none');
        $('#test_digitalBB').css('display', 'none');
    })
    /* 한개 소분류 끝*/    
    
    /* 소 분류 */
    $("#test_digitalC").hover(function(){
        $('#test_cates').css('display', 'block');
        $('#test_digital').css('display', 'block');
        $('#test_digitalCC').css('display', 'block');


        $('#test_cates > h2 > span').css('display', 'block');
    })
    
    $("#test_digitalC").mouseleave(function(){
        $('#test_cates').css('display', 'block');

        $('#test_digital').css('display', 'none');
        $('#test_digitalCC').css('display', 'none');
    }) 
    
    $("#test_digitalCC").hover(function(){
        $('#test_cates').css('display', 'block');
        $('#test_digital').css('display', 'block');
        $('#test_digitalCC').css('display', 'block');


        $('#test_cates > h2 > span').css('display', 'block');
    })
    
    $("#test_digitalCC").mouseleave(function(){
        $('#test_cates').css('display', 'block');

        $('#test_digital').css('display', 'none');
        $('#test_digitalCC').css('display', 'none');
    })
    /* 한개 소분류 끝*/    
    
    /* 소 분류 */
    $("#test_digitalD").hover(function(){
        $('#test_cates').css('display', 'block');
        $('#test_digital').css('display', 'block');
        $('#test_digitalDD').css('display', 'block');


        $('#test_cates > h2 > span').css('display', 'block');
    })
    
    $("#test_digitalD").mouseleave(function(){
        $('#test_cates').css('display', 'block');

        $('#test_digital').css('display', 'none');
        $('#test_digitalDD').css('display', 'none');
    }) 
    
    $("#test_digitalDD").hover(function(){
        $('#test_cates').css('display', 'block');
        $('#test_digital').css('display', 'block');
        $('#test_digitalDD').css('display', 'block');


        $('#test_cates > h2 > span').css('display', 'block');
    })
    
    $("#test_digitalDD").mouseleave(function(){
        $('#test_cates').css('display', 'block');

        $('#test_digital').css('display', 'none');
        $('#test_digitalDD').css('display', 'none');
    })
    /* 한개 소분류 끝*/    
    
    /* 소 분류 */
    $("#test_hobbyA").hover(function(){
        $('#test_cates').css('display', 'block');
        $('#test_hobby').css('display', 'block');
        $('#test_hobbyAA').css('display', 'block');


        $('#test_cates > h2 > span').css('display', 'block');
    })
    
    $("#test_hobbyA").mouseleave(function(){
        $('#test_cates').css('display', 'block');

        $('#test_hobby').css('display', 'none');
        $('#test_hobbyAA').css('display', 'none');
    }) 
    
    $("#test_hobbyAA").hover(function(){
        $('#test_cates').css('display', 'block');
        $('#test_hobby').css('display', 'block');
        $('#test_hobbyAA').css('display', 'block');


        $('#test_cates > h2 > span').css('display', 'block');
    })
    
    $("#test_hobbyAA").mouseleave(function(){
        $('#test_cates').css('display', 'block');

        $('#test_hobby').css('display', 'none');
        $('#test_hobbyAA').css('display', 'none');
    })
    /* 한개 소분류 끝*/    
    
    /* 소 분류 */
    $("#test_hobbyB").hover(function(){
        $('#test_cates').css('display', 'block');
        $('#test_hobby').css('display', 'block');
        $('#test_hobbyBB').css('display', 'block');


        $('#test_cates > h2 > span').css('display', 'block');
    })
    
    $("#test_hobbyB").mouseleave(function(){
        $('#test_cates').css('display', 'block');

        $('#test_hobby').css('display', 'none');
        $('#test_hobbyBB').css('display', 'none');
    }) 
    
    $("#test_hobbyBB").hover(function(){
        $('#test_cates').css('display', 'block');
        $('#test_hobby').css('display', 'block');
        $('#test_hobbyBB').css('display', 'block');


        $('#test_cates > h2 > span').css('display', 'block');
    })
    
    $("#test_hobbyBB").mouseleave(function(){
        $('#test_cates').css('display', 'block');

        $('#test_hobby').css('display', 'none');
        $('#test_hobbyBB').css('display', 'none');
    })
    /* 한개 소분류 끝*/    
    
    /* 소 분류 */
    $("#test_hobbyC").hover(function(){
        $('#test_cates').css('display', 'block');
        $('#test_hobby').css('display', 'block');
        $('#test_hobbyCC').css('display', 'block');


        $('#test_cates > h2 > span').css('display', 'block');
    })
    
    $("#test_hobbyC").mouseleave(function(){
        $('#test_cates').css('display', 'block');

        $('#test_hobby').css('display', 'none');
        $('#test_hobbyCC').css('display', 'none');
    }) 
    
    $("#test_hobbyCC").hover(function(){
        $('#test_cates').css('display', 'block');
        $('#test_hobby').css('display', 'block');
        $('#test_hobbyCC').css('display', 'block');


        $('#test_cates > h2 > span').css('display', 'block');
    })
    
    $("#test_hobbyCC").mouseleave(function(){
        $('#test_cates').css('display', 'block');

        $('#test_hobby').css('display', 'none');
        $('#test_hobbyCC').css('display', 'none');
    })
    /* 한개 소분류 끝*/    
    
    /* 소 분류 */
    $("#test_hobbyD").hover(function(){
        $('#test_cates').css('display', 'block');
        $('#test_hobby').css('display', 'block');
        $('#test_hobbyDD').css('display', 'block');


        $('#test_cates > h2 > span').css('display', 'block');
    })
    
    $("#test_hobbyD").mouseleave(function(){
        $('#test_cates').css('display', 'block');

        $('#test_hobby').css('display', 'none');
        $('#test_hobbyDD').css('display', 'none');
    }) 
    
    $("#test_hobbyDD").hover(function(){
        $('#test_cates').css('display', 'block');
        $('#test_hobby').css('display', 'block');
        $('#test_hobbyDD').css('display', 'block');


        $('#test_cates > h2 > span').css('display', 'block');
    })
    
    $("#test_hobbyDD").mouseleave(function(){
        $('#test_cates').css('display', 'block');

        $('#test_hobby').css('display', 'none');
        $('#test_hobbyDD').css('display', 'none');
    })
    /* 한개 소분류 끝*/    
    
    /* 소 분류 */
    $("#test_accsA").hover(function(){
        $('#test_cates').css('display', 'block');
        $('#test_accs').css('display', 'block');
        $('#test_accsAA').css('display', 'block');


        $('#test_cates > h2 > span').css('display', 'block');
    })
    
    $("#test_accsA").mouseleave(function(){
        $('#test_cates').css('display', 'block');

        $('#test_accs').css('display', 'none');
        $('#test_accsAA').css('display', 'none');
    }) 
    
    $("#test_accsAA").hover(function(){
        $('#test_cates').css('display', 'block');
        $('#test_accs').css('display', 'block');
        $('#test_accsAA').css('display', 'block');


        $('#test_cates > h2 > span').css('display', 'block');
    })
    
    $("#test_accsAA").mouseleave(function(){
        $('#test_cates').css('display', 'block');

        $('#test_accs').css('display', 'none');
        $('#test_accsAA').css('display', 'none');
    })
    /* 한개 소분류 끝*/    
    
    /* 소 분류 */
    $("#test_accsB").hover(function(){
        $('#test_cates').css('display', 'block');
        $('#test_accs').css('display', 'block');
        $('#test_accsBB').css('display', 'block');


        $('#test_cates > h2 > span').css('display', 'block');
    })
    
    $("#test_accsB").mouseleave(function(){
        $('#test_cates').css('display', 'block');

        $('#test_accs').css('display', 'none');
        $('#test_accsBB').css('display', 'none');
    }) 
    
    $("#test_accsBB").hover(function(){
        $('#test_cates').css('display', 'block');
        $('#test_accs').css('display', 'block');
        $('#test_accsBB').css('display', 'block');


        $('#test_cates > h2 > span').css('display', 'block');
    })
    
    $("#test_accsBB").mouseleave(function(){
        $('#test_cates').css('display', 'block');

        $('#test_accs').css('display', 'none');
        $('#test_accsBB').css('display', 'none');
    })
    /* 한개 소분류 끝*/    
    
    /* 소 분류 */
    $("#test_accsC").hover(function(){
        $('#test_cates').css('display', 'block');
        $('#test_accs').css('display', 'block');
        $('#test_accsCC').css('display', 'block');


        $('#test_cates > h2 > span').css('display', 'block');
    })
    
    $("#test_accsC").mouseleave(function(){
        $('#test_cates').css('display', 'block');

        $('#test_accs').css('display', 'none');
        $('#test_accsCC').css('display', 'none');
    }) 
    
    $("#test_accsCC").hover(function(){
        $('#test_cates').css('display', 'block');
        $('#test_accs').css('display', 'block');
        $('#test_accsCC').css('display', 'block');


        $('#test_cates > h2 > span').css('display', 'block');
    })
    
    $("#test_accsCC").mouseleave(function(){
        $('#test_cates').css('display', 'block');

        $('#test_accs').css('display', 'none');
        $('#test_accsCC').css('display', 'none');
    })
    /* 한개 소분류 끝*/    
    
    /* 소 분류 */
    $("#test_accsD").hover(function(){
        $('#test_cates').css('display', 'block');
        $('#test_accs').css('display', 'block');
        $('#test_accsDD').css('display', 'block');


        $('#test_cates > h2 > span').css('display', 'block');
    })
    
    $("#test_accsD").mouseleave(function(){
        $('#test_cates').css('display', 'block');

        $('#test_accs').css('display', 'none');
        $('#test_accsDD').css('display', 'none');
    }) 
    
    $("#test_accsDD").hover(function(){
        $('#test_cates').css('display', 'block');
        $('#test_accs').css('display', 'block');
        $('#test_accsDD').css('display', 'block');


        $('#test_cates > h2 > span').css('display', 'block');
    })
    
    $("#test_accsDD").mouseleave(function(){
        $('#test_cates').css('display', 'block');

        $('#test_accs').css('display', 'none');
        $('#test_accsDD').css('display', 'none');
    })
    /* 한개 소분류 끝*/    
    
    /* 소 분류 */
    $("#test_closA").hover(function(){
        $('#test_cates').css('display', 'block');
        $('#test_clos').css('display', 'block');
        $('#test_closAA').css('display', 'block');


        $('#test_cates > h2 > span').css('display', 'block');
    })
    
    $("#test_closA").mouseleave(function(){
        $('#test_cates').css('display', 'block');

        $('#test_clos').css('display', 'none');
        $('#test_closAA').css('display', 'none');
    }) 
    
    $("#test_closAA").hover(function(){
        $('#test_cates').css('display', 'block');
        $('#test_clos').css('display', 'block');
        $('#test_closAA').css('display', 'block');


        $('#test_cates > h2 > span').css('display', 'block');
    })
    
    $("#test_closAA").mouseleave(function(){
        $('#test_cates').css('display', 'block');

        $('#test_clos').css('display', 'none');
        $('#test_closAA').css('display', 'none');
    })
    /* 한개 소분류 끝*/    
    
    /* 소 분류 */
    $("#test_closB").hover(function(){
        $('#test_cates').css('display', 'block');
        $('#test_clos').css('display', 'block');
        $('#test_closBB').css('display', 'block');


        $('#test_cates > h2 > span').css('display', 'block');
    })
    
    $("#test_closB").mouseleave(function(){
        $('#test_cates').css('display', 'block');

        $('#test_clos').css('display', 'none');
        $('#test_closBB').css('display', 'none');
    }) 
    
    $("#test_closBB").hover(function(){
        $('#test_cates').css('display', 'block');
        $('#test_clos').css('display', 'block');
        $('#test_closBB').css('display', 'block');


        $('#test_cates > h2 > span').css('display', 'block');
    })
    
    $("#test_closBB").mouseleave(function(){
        $('#test_cates').css('display', 'block');

        $('#test_clos').css('display', 'none');
        $('#test_closBB').css('display', 'none');
    })
    /* 한개 소분류 끝*/    
    
    /* 소 분류 */
    $("#test_closC").hover(function(){
        $('#test_cates').css('display', 'block');
        $('#test_clos').css('display', 'block');
        $('#test_closCC').css('display', 'block');


        $('#test_cates > h2 > span').css('display', 'block');
    })
    
    $("#test_closC").mouseleave(function(){
        $('#test_cates').css('display', 'block');

        $('#test_clos').css('display', 'none');
        $('#test_closCC').css('display', 'none');
    }) 
    
    $("#test_closCC").hover(function(){
        $('#test_cates').css('display', 'block');
        $('#test_clos').css('display', 'block');
        $('#test_closCC').css('display', 'block');


        $('#test_cates > h2 > span').css('display', 'block');
    })
    
    $("#test_closCC").mouseleave(function(){
        $('#test_cates').css('display', 'block');

        $('#test_clos').css('display', 'none');
        $('#test_closCC').css('display', 'none');
    })
    /* 한개 소분류 끝*/    
    
})