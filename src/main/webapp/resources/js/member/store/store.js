//$(document).ready(function() {
//  // 경매 참가 내역 셀렉트 박스 이벤트 핸들러
//  $("#auctionbid_menu_area select.form-select").on("change", function() {
//    const selectedFilter = $(this).val();
//
//    function toggleItemList(itemList, condition) {
//      if (condition)
//        itemList.show();
//      else
//        itemList.hide();
//    }
//
//    $("#auctionbid_menu_area .goods").each(function(index, item) {
//      const status = $(item).data("status");
//
//      switch (selectedFilter) {
//        case "전체":
//          toggleItemList($(item), true);
//          break;
//
//        case "2":
//          toggleItemList($(item), status === "거래중");
//          break;
//
//        case "3":
//          toggleItemList($(item), status === "거래완료");
//          break;
//      }
//    });
//  });
//
//  // 내 커스텀 셀렉트 박스 이벤트 핸들러
//  $("#secondhandLike_menu_area select.form-select").on("change", function() {
//    const selectedFilter = $(this).val();
//
//    function toggleItemList(itemList, condition) {
//      if (condition)
//        itemList.show();
//      else
//        itemList.hide();
//    }
//
//    $("#secondhandLike_menu_area .goods").each(function(index, item) {
//      const status = $(item).data("status");
//
//      switch (selectedFilter) {
//        case "전체":
//          toggleItemList($(item), true);
//          break;
//
//        case "2":
//          toggleItemList($(item), status === "거래중");
//          break;
//
//        case "3":
//          toggleItemList($(item), status === "거래완료");
//          break;
//      }
//    });
//  });
//});
