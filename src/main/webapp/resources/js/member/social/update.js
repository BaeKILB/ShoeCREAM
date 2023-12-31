// (1) 스토리 이미지 업로드를 위한 사진 선택 로직
function imageChoose(obj) {
	let f = obj.files[0];

	if (!f.type.match("image.*")) {
		alert("이미지를 등록해야 합니다.");
		return;
	}

	let reader = new FileReader();
	reader.onload = (e) => {
		$("#imageUploadPreview").attr("src", e.target.result);
	}
	reader.readAsDataURL(f); // 이 코드 실행시 reader.onload 실행됨.
}


 function deleteFile(postsImage, posts_idx) {
    console.log(postsImage);
	console.log(posts_idx);
    $.ajax({
        type: "POST",
//        url: "ImageFileDelet",
		url: `${contextPath}/social/${posts_idx}/ImageFileDelete`,
        data: {
            "posts_idx": posts_idx,
            "posts_image1": postsImage
        },
        dataType: "text",
        success: function(result) {
            console.log("Result from server:", result);
            if ($.trim(result) === "true") {
                alert("파일 삭제 성공");
        $("#imageBtnArea").html("<input type='file' name='file1' onchange='imageChoose(this)' value='${image[0].posts_image1}' /><div class='upload-img'><img src='https://bappeda.bolmongkab.go.id/storage/assets/profile/mUxHSe5A28TNnVnb4m8L4KMj54EA6Ls5TDrs8rer.jpg'  alt='' id='imageUploadPreview'/></div>");
        
        // 이미지를 설정한 이미지로 변경
        $("#imageUploadPreview").attr("src", "https://us.123rf.com/450wm/telmanbagirov/telmanbagirov1708/telmanbagirov170800101/84993079-prise-de-photo-non-autoris%C3%A9e.jpg");
            } else {
                alert("파일 삭제 실패!", result);
            }
        }
    });
}

