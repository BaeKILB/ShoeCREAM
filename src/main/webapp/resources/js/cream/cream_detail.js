/**
 * cream_detail html 파일의 자바 스크립트 파일
 * 
 * 구현 할것
 * 체결내역 더 보기
 * 참고 사이트 
 * https://m.blog.naver.com/dasol825/220672901113
 */

function dealsListPopup() { 
	window.open("deals_list.jsp", "시세", "width=400, height=800, left=100, top=50"); }
	
	
//시세 조회 탭들 
	
$(document).ready(function() {
    // 첫 번째 탭 그룹 초기화
    $(".find_wrap").eq(0).find(".find_tab").eq(0).addClass("off");
    $(".find_wrap").eq(0).find(".find_cont").eq(0).addClass("active");
    $(".find_wrap").eq(0).find(".find_tab").click(function() {
        var index = $(this).index();
        $(".find_wrap").eq(0).find(".find_tab").removeClass("off");
        $(this).addClass("off");
        $(".find_wrap").eq(0).find(".find_cont").removeClass("active");
        $(".find_wrap").eq(0).find(".find_cont").eq(index).addClass("active");
    });

    // 두 번째 탭 그룹 초기화
    $(".find_wrap").eq(1).find(".find_tab").eq(0).addClass("off");
    $(".find_wrap").eq(1).find(".find_cont").eq(0).addClass("active");
    $(".find_wrap").eq(1).find(".find_tab").click(function() {
        var index = $(this).index();
        $(".find_wrap").eq(1).find(".find_tab").removeClass("off");
        $(this).addClass("off");
        $(".find_wrap").eq(1).find(".find_cont").removeClass("active");
        $(".find_wrap").eq(1).find(".find_cont").eq(index).addClass("active");
    });
});
    
    


