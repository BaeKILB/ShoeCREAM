$(function() { // onload
	$("#orderMethod").on("change",function() {
		$.ajax({
			type: "get"
			, url: ""
			, dataType: "json"
			, data: {
				orderMethod:$("#orderMethod").val()
			}
		})
		.done(function(data) {
			console.log("성공"+data);
		})
		.fail(function() {
			console.log("실패");
		})
	});
}); // onload