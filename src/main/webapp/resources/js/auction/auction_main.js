let pageNum = 1;
let orderMethod = "";

$(function() { // onload
	
	getList();
	
	function getList() {
		$.ajax({
			type: "get"
			, url: "getAucList"
			, dataType: "json"
			, data: {
				'orderMethod': orderMethod
				, 'pageNum': pageNum
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
		console.log(pageInfo)
		for (let item of data) {
			let result =
				"<a href='auctionDetail?code="+ item.auction_idx +"'>"
					+ "<div class='auctionItem'>"
						+"<img alt='테스트이미지' src='"+ path + item.image_path + "/" + item.image1 +"'>" 
							+"<div>" 
								+ "상품명"
								+ item.auction_title
							+"</div>"
							+"<div>" 
								+ "상품가격"
								+ item.auc_start_price
							+"</div>"
							+"<div>"
								+ "등록일"
								+ item.auc_regist_date
							+"</div>"
						+"</div>"
					+"</a>";		
			$("#itemList").append(result);
		}
		//
		console.log(JSON.stringify(data));
	};
	
	const failResult = () => {
		console.log("fail");
	};
	
	$("#orderMethod").on("change",function() {
		orderMethod = $("#orderMethod").val();
		$("#itemList").empty();
		getList();
	});
	
}); // onload