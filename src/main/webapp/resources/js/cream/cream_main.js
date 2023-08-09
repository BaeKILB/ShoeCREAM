let pageNum = 1;
let maxPage = 1;
let listCount = '';
let pageListLimit = '';
let orderMethod = "";


$(function() { // onload

	
    getList();
    
    // 스크롤
    $(window).on("scroll",function() {
        let scrollTop = $(window).scrollTop();
        let windowHeight = $(window).height();
        let documentHeight = $(document).height();
        
        if(scrollTop + windowHeight + 1 >= documentHeight) {
            if (pageNum < maxPage) {
                pageNum++;
                getList();
            } 
        }
    });
	
 }); // onload

function getList() {
	console.log("호출");
	
    $.ajax({
        type: "get"
        , url: "getCreamList"
        , dataType: "json"
        , data: {
            'orderMethod': orderMethod
             , 'pageNum': pageNum
//            , 'lc_code': lcCode
//            , 'mc_code': mcCode
        } 
    })
    .done(function(data) {
        doneResult(data);
    })
    .fail(function() {
        failResult();
    });
}

const doneResult = data => {
    let pageInfo = data.pop();
    let path = window.location.pathname.substring(0, window.location.pathname.indexOf("/",2));
    maxPage = pageInfo.maxPage;
    listCount = pageInfo.listCount;
    pageListLimit = pageInfo.pageListLimit;
    
//    let index = 0;
    for (let item of data) {
        // 입찰내역이 있을경우 가격을 입찰가로 바꿔야함 가져올때 bid_list 도 같이 가져오자
  
        let result = 
                "<div class='card col-lg-3 col-md-4 col-6'>"
                +"  <a href='CreamDetail?cream_idx="+ item.cream_idx +"'>"
                +"      <img src='"+ path + item.image_path + "/" + item.image1 +"' class='card-img-top' alt='productImage'>"
                +"      <div class='card-body'>"
                +"        <h5 class='card-title'>"+item.cream_title+"</h5>"
                +"      </div>"
                +"      <ul class='list-group list-group-flush'>"
                +"        <li class='list-group-item'>가격 "+item.size220+"~ 원</li>"
                +"        <li class='list-group-item'>"
                +"          <div class='row'>"
                +"              <div class='col'>"
                +"                  <svg xmlns = 'http://www.w3.org/2000/svg' width = '16' height = '16' fill = 'currentColor' class='bi bi-eye' viewBox = '0 0 16 16' >"
                +"                      <path d='M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8zM1.173 8a13.133 13.133 0 0 1 1.66-2.043C4.12 4.668 5.88 3.5 8 3.5c2.12 0 3.879 1.168 5.168 2.457A13.133 13.133 0 0 1 14.828 8c-.058.087-.122.183-.195.288-.335.48-.83 1.12-1.465 1.755C11.879 11.332 10.119 12.5 8 12.5c-2.12 0-3.879-1.168-5.168-2.457A13.134 13.134 0 0 1 1.172 8z'/>"
                +"                      <path d='M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5zM4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0z'/>"
                +"                  </svg >" 
                +                   item.cream_readcount
                +"              </div>"
                +"              <div class='col'>"
                +"                  <svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-heart-fill' viewBox='0 0 16 16'>"
                +"                      <path fill-rule='evenodd' d='M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z'/>"
                +"                  </svg>" 
                +                   item.dibs_count
                +"              </div>"
                +"          </div>"
                +"        </li>"
                +"    </ul>"
                +"  </a>"
                +"</div>";
        $("#itemList").append(result);
//        index++;
    }
};

const failResult = () => {
    console.log("fail");
};

