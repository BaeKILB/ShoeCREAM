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
            });            
        })
        .fail(function() {
        	console.log("fail");    
        });
    });
});

// 이미지 관련
let count = 0;
$(function() {
	// 숨김 처리
	$(".imageView").each(function(index) {
		count = index + 1;
	})
	
	$("input[type=file]").each(function(index) {
		if (index+1 <= count) {
		$(this).addClass("hidden");
		return;
		}
	});
	
	if(count < 4) {
		$(".image_box").removeClass("hidden");
	} else {
		$(".image_box").addClass("hidden");
	}
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
				"<button type='button' onclick='imgDelete(this.value)' value='"+currentId+"'>"
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

// 경매시간
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
			let temp = new Date(startDate.val());
			
			let sttTemp = startTime.val().split(":");
			temp.setHours(sttTemp[0]);
			temp.setMinutes(sttTemp[1]);
			
			if (ctdTemp.getDate() == stdTemp.getDate()) {
				endTime.datetimepicker('setOptions', {minTime: temp.getTime()+(1000*60*60*1), defaultTime: temp.getTime()+(1000*60*60*1)});
			} else {
				endTime.datetimepicker('setOptions', {minTime: '00:00', defaultTime: '00:00'});
			}
			endTime.removeClass('hidden').focus();
		},
	});
});