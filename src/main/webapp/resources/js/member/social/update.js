// (1) 스토리 이미지 업로드를 위한 사진 선택 로직
	function deleteFile(postsImage) {
		console.log(postsImage);
//		let posts_idx = ${image.posts_idx};
	
		$.ajax({
			type: "POST",
			url: "ImageFileDelet",
			data: {
				"posts_idx": posts_idx,
				"posts_image1": postsImage
			},
		    dataType: "text",
		    success: function(result) {
			  console.log("Result from server:", result);
		        if ($.trim(result) === "true") {
		            alert("파일 삭제 성공");
		            // 인덱스 번호로 fileBtnArea 엘리먼트를 선택
		            $("#imageBtnArea").html("<input  type='file' name='file1' onchange='imageChoose(this)' value='${image[0].posts_image1}' /><div class='upload-img'><img src='${pageContext.request.contextPath }/resources/img/member/social/social.png'  alt='' id='imageUploadPreview' /></div>");
		        } else {
		            alert("파일 삭제 실패!", result);
		        }
		    }
		});
	}

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