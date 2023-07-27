/*본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.*/
function sample4_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            /*팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.*/

            /*도로명 주소의 노출 규칙에 따라 주소를 표시한다.
            내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.*/
            var roadAddr = data.roadAddress; // 도로명 주소 변수
            var extraRoadAddr = ''; // 참고 항목 변수

            /*법정동명이 있을 경우 추가한다. (법정리는 제외)
            법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.*/
            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                extraRoadAddr += data.bname;
            }
            /*건물명이 있고, 공동주택일 경우 추가한다.*/
            if(data.buildingName !== '' && data.apartment === 'Y'){
               extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
            }
            /*표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.*/
            if(extraRoadAddr !== ''){
                extraRoadAddr = ' (' + extraRoadAddr + ')';
            }

          /*우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('sample4_postcode').value = data.zonecode;
            document.getElementById("sample4_roadAddress").value = roadAddr;*/
         	document.getElementById("sample4_jibunAddress").value = data.jibunAddress;
            
          /*참고항목 문자열이 있을 경우 해당 필드에 넣는다.
            if(roadAddr !== ''){
                document.getElementById("sample4_extraAddress").value = extraRoadAddr;
            } else {
                document.getElementById("sample4_extraAddress").value = '';
            }

            var guideTextBox = document.getElementById("guide");
             사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
            if(data.autoRoadAddress) {
                var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                guideTextBox.style.display = 'block';

            } else if(data.autoJibunAddress) {
                var expJibunAddr = data.autoJibunAddress;
                guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                guideTextBox.style.display = 'block';
            } else {
                guideTextBox.innerHTML = '';
                guideTextBox.style.display = 'none';
            }*/
        }
    }).open();
}
// 중고, 경매 선택
$(function() {
    $(".methodSpan").on("click",function() {
        let page = $(this).children('input').val();
    location.href = "RegisterForm?page="+page;
    });
});

// 브랜드 선택
function sellectBrand(selBrand){
   $(".brand").val(selBrand);
}

// 카테고리 선택
$(function() {
    // 중분류 추가
    const mrAdd = (data) => {
        $(".mcRecord").remove();
        $(".scRecord").remove();
        for(let item of data) {
            let result = (
              "<li class='mcRecord' value='"+item.mc_code+"'>"+item.mc_name+"</li>"  
            );
            $("#mcList").append(result);
        };
    };
    // 소분류 추가
//    const srAdd = (data) => {
//        $(".scRecord").remove();
//        for(let item of data) {
//            let result = (
//              "<li class='scRecord' value='"+item.sc_code+"'>"+item.sc_name+"</li>"  
//            );
//            $("#scList").append(result);
//        };     
//    };
    // 카테고리 클릭 이벤트
    $(".lcRecord").on("click",function() {
		let lc_code = $(this).val();
		$("input[name=lc_code]").val(lc_code);
		$("input[name=mc_code]").val('');
//		$("input[name=sc_code]").val('');
		let lc_name = $(this).text();
		$("#selectLcn").text(lc_name);
		$("#selectMcn").text('');
//		$("#selectScn").text('');
        $.ajax({
            type: "get",
            url: "getMcList",
            data: {
                lc_code : lc_code
            },
            dataType: "json"
        })
        .done(function(data) {
            mrAdd(data);
            $(".mcRecord").on("click",function() {
				let mc_code = $(this).val();
				$("input[name=mc_code]").val(mc_code);
				$("input[name=sc_code]").val('');
				let mc_name = $(this).text();
				$("#selectMcn").text(" > " + mc_name);
//				$("#selectScn").text('');
//                $.ajax({
//                    type: "get",
//                    url: "getScList",
//                    data: {
//                        mc_code : mc_code
//                    },
//                    dataType: "json"
//                })
//                .done(function(data) {
//                    srAdd(data);
//                    $(".scRecord").on("click",function() {
//						let sc_code = $(this).val();
//						$("input[name=sc_code]").val(sc_code);
//						let sc_name = $(this).text();
//						$("#selectScn").text(" > "+sc_name);
//		            }); 
//                })
//                .fail(function() {
                    
//                });
            });            
        })
        .fail(function() {
            
        });
    });
});

// 이미지 관련
let count = 0;
$(function() {
	// 숨김 처리
	$("input[type=file]").not("input[name=image1]").each(function(index) {
		$(this).addClass("hidden");
	})
});
// 추가된 이미지 삭제
const imgDelete = (currentId) => {
	$("button[value="+currentId+"]").remove();
	$("#"+currentId).removeClass("hidden").val('');	
	count--;
	if(count < 4) {
		$(".image_box").removeClass("hidden");
	};
};
// 이미지 등록시 사진출력
const setImages = (e) => {
	let currentId = e.target.name;
	$("#"+currentId).next().removeClass("hidden");
	$("#"+currentId).addClass("hidden");
	
	let reader = new FileReader();
	for(let image of e.target.files) {
		reader.onload = function (event) {
			let result = (
				"<button type='button' class='imgDelete' onclick='imgDelete(this.value)' value='"+currentId+"'>"
				+"<img class='imageView' src='"+event.target.result+"'>"
				+"</button>"
			);
			$(".ivBox").append(result);
		};
		reader.readAsDataURL(image);
	}; 
	count ++;
	if(count >= 4) {
		$(".image_box").addClass("hidden");
	};
};
// 경매
const selectSize = (size) => {
	let inputBox = $("input[name=product_size]"); 
	if (size == "") {
		inputBox.attr('disabled',false);
	} else {
		inputBox.attr('disabled',true);
	}
	inputBox.val(size);
};

// 시간
$(function() {
    $.datetimepicker.setLocale('kr');
    let today = new Date();
    $("#dateStart").datetimepicker({
        changeMonth: true,
        changeYear: true,
        showButtonPanel: true,
        format:'Y-m-d H:i',
        step: 60,
        defaultSelect: false,
        defaultDate: today,
        defaultTime: today,
        minDate: today,
        minTime: today,
        onSelectDate: function(ct){
            $("#dateEnd").datetimepicker('setOptions', { minDate: ct });
            $("#dateEnd").datetimepicker('setOptions', { minTime: ct });
        },
        onSelectTime: function(ct){
            $("#dateEnd").datetimepicker('setOptions', { minDate: ct });
            $("#dateEnd").datetimepicker('setOptions', { minTime: ct });
            $("#et_wrap").removeClass("hidden");
        }
    });
    $("#dateEnd").datetimepicker({
        changeMonth: true,
        changeYear: true,
        showButtonPanel: true,
        format:'Y-m-d H:i', // 포맷 형식 지정
        step: 60, // 분 단위
        defaultSelect: false,
        onClose: function(ct) { // 창 종료시 실행함수
            let startDateInput = $("#dateStart");
            if($("#dateStart").val() != ''){
                let tempStartDate = new Date(startDateInput.val());
                let tempEndDate = new Date(ct);
                if(tempStartDate > tempEndDate){
                    startDateInput.val(getFormatDateTime(ct));
                }
            }else {
                startDateInput.val(getFormatDateTime(ct));
            }
        },
        onSelectDate:function(ct){
            $("#dateStart").datetimepicker('setOptions', { maxDate: ct });
            $("#dateStart").datetimepicker('setOptions', { maxTime: ct });
        },
        onSelectTime:function(ct){
            $("#dateStart").datetimepicker('setOptions', { maxDate: ct });
            $("#dateStart").datetimepicker('setOptions', { maxTime: ct });
        },
    });
});