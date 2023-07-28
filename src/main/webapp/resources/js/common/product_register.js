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
// 신발
const selectSize = (size) => {
	let inputBox = $("input[name=auction_size]"); 
	if (size == "") {
		inputBox.attr('required',false);
	} else {
		inputBox.attr('required',true);
	}
	inputBox.val(size);
};

// 시간
const dateFormat = (date) => {
    let month = date.getMonth() + 1;
    let day = date.getDate();
    let hour = date.getHours();
    let minute = date.getMinutes();
    let second = date.getSeconds();

    month = month >= 10 ? month : '0' + month;
    day = day >= 10 ? day : '0' + day;
    hour = hour >= 10 ? hour : '0' + hour;
    minute = minute >= 10 ? minute : '0' + minute;
    second = second >= 10 ? second : '0' + second;

    return date.getFullYear() + '-' + month + '-' + day + ' ' + hour + ':' + minute;
}

$(function() {
    $.datetimepicker.setLocale('kr');
    let today = new Date();
	let startDate = $("#dateStart");
	let startTime = $("#timeStart");
	let endDate = $("#dateEnd");
	let endTime = $("#timeEnd");
	
	startTime.datetimepicker({
		datepicker: false,
		format: 'H:i',
		step: 60,
		timepickerScrollbar: false,
		onSelectTime: function(ct) {
			let ctTemp = new Date(ct);
			let stdTemp = new Date(startDate.val());
			if (ctTemp.getHours() == '23') {
				endDate.datetimepicker('setOptions',{ minDate: stdTemp.getTime()+(1000*60*60*1*24) });
			} else {
				endDate.datetimepicker('setOptions',{ minDate: stdTemp.getTime() });
				endTime.datetimepicker('setOptions',{ minTime: '00:00', defaultTime: '00:00' });
			}
			$("input[name=auc_regist_date]").removeClass('hidden').val(startDate.val()+" "+startTime.val());
			$("#sdtw").addClass('hidden');
		},
		onClose: function() {
			$("#et_wrap").removeClass("hidden");
		} 
	});
	
	endTime.datetimepicker({
		datepicker: false,
		format: 'H:i',
		step: 60,
		timepickerScrollbar: false,
		onSelectTime: function() {
			$("input[name=auc_close_date]").removeClass('hidden').val(endDate.val()+" "+endTime.val());
			$("#edtw").addClass('hidden');
		}
	});
	
	startDate.datetimepicker({
		timepicker: false,
	    changeMonth: true,
	    changeYear: true,
	    showButtonPanel: true,
	    format:'Y-m-d',
	    minDate: today,
	    scrollMonth : false,
	    onSelectDate: function(ct) {
			let ctTemp = new Date(ct);
			if (ctTemp.getDate() == today.getDate()) {
				startTime.datetimepicker('setOptions', {minTime: ct ,defaultTime: ct});
			} else {
				startTime.datetimepicker('setOptions', {minTime: '00:00', defaultTime: '00:00'});
			}
		},
		onClose: function() {
			startTime.removeClass('hidden').focus();
		}
	});
	
	endDate.datetimepicker({
		timepicker: false,
	    changeMonth: true,
	    changeYear: true,
	    showButtonPanel: true,
	    format:'Y-m-d',
	    scrollMonth : false,
	    onSelectDate: function(ct) {
			let ctdTemp = new Date(ct);
			let stdTemp = new Date(startDate.val());
			let sttTemp = new Date(startTime.val());
			if (ctdTemp.getDate() == stdTemp.getDate()) {
				endTime.datetimepicker('setOptions', {minTime: sttTemp.getTime()+(1000*60*60*1)});
			} else {
				endTime.datetimepicker('setOptions', {minTime: '00:00', defaultTime: '00:00'});
			}
			endTime.removeClass('hidden').focus();
		},
	});
});