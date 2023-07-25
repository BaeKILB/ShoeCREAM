
 function update(memidx) {
    let data = $("#memberUpdate").serialize();
    console.log(data);

    $.ajax({
        type: "put",
		url: `/api/mypage/${memidx}`, // 수정된 부분: 동적 URL 생성
        data: data,
		contentType: "application/x-www-form-urlencoded; charset=utf-8",
        dataType: "json"
    }).done(res => {
        console.log("update 성공", res);
    }).fail(error => {
        console.log("update 실패", error);
    });
}