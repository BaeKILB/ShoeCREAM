<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="ko_KR" />
<!-- 원본 파일 이름 4-3 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>거래상세</title>
<!-- 부트스트랩 -->
<link href="${pageContext.request.contextPath }/resources/css/etc/bootstrap.min.css" rel="stylesheet">
<script	src="${pageContext.request.contextPath }/resources/js/etc/bootstrap.bundle.min.js"></script>
<link href="${pageContext.request.contextPath }/resources/css/etc/common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/resources/css/inc/pay/trans_form.css" rel="stylesheet">
<%-- <link href="${pageContext.request.contextPath }/resources/css/inc/top.css" rel="styleSheet"> --%>
<%-- <link href="${pageContext.request.contextPath }/resources/css/inc/footer.css" rel="styleSheet"> --%>
<!-- jQuery -->
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<!-- 아임포트 -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.8.js"></script>




</head>
<body>
	<header>
<%-- 		<jsp:include page="../../inc/top1.jsp"></jsp:include> --%>
	</header>
	<section id="sec_con" class="inr res_page">
<!-- 		<form action="resInfoPro" method="post"> -->
		<form action="payPro" method="post">
			<input type="hidden" name="product_selector" value="${map.product_selector }">
			<input type="hidden" name="product_idx" value="${map.product_idx }">
			<input type="hidden" name="pay_total" class="pay_total" value="${map.product_price }">
			<input type="hidden" name="merchant_uid">
			<input type="hidden" name="imp_uid">
			<!-- 결제 상태 임시지정 -->
			<input type="hidden" name="pay_status" class="pay_status">
			
			<fieldset class="img_sec_wrap">
				<div class="img_sec_p">
					
					<img src="${pageContext.request.contextPath}/${map.image_path}/${map.image1}" alt="">
				</div>
				<div class="txt_sec_p">
					<p>
						<span>상품 이름</span>
						<span class="productName">${map.product_title}</span>
					</p>
					<p class="pay_total_p">
						<span>상품 가격</span>
						<span><b id="productPrice">${map.product_price}</b>원</span>
					</p>
					<p>
						<span>상품 설명</span>
						<span class="resTotalAmount">${map.product_info}</span>
					</p>
				</div>
			</fieldset>
			<fieldset class="img_sec_wrap">
				<b>판매자 정보</b>
				<div class="txt_sec_p">
					<p>
						<span>닉네임</span>
						<span class="sellerNickname">${map.mem_nickname}</span>
					</p>
					<p>
						<span>유저 점수</span>
						<span><b id="sellerRank"></b>${map.mem_rank}</span>
					</p>
					<p >
						<span>판매 횟수</span>
						<span class="sellerSellCount">${map.mem_seller_sellCount}</span>
					</p>
				</div>
			</fieldset>
			<ul class="res_page_wrap">
				
				<li>
					<div class="menu_tit ">
						<span>거래 완료 전 유의사항</span>
					</div>
									<ul class="side_sub">
						<li>
							<textarea name="tos">
1. 중고 물품을 받으셨나요? 
중고 물품을 받지않고 거래 완료시 문제가 발생하게되면 처리가 어려울 수 있습니다

2. 받으신 물품은 사진, 설명과 동일한 상태인가요 ?

3. 거래 완료를 처리후 문제가 발생시 분쟁신고를 할 수 있으나 처리가 어려울 수 있으므로
문제가 없는지 상세히 살펴주세요

                            </textarea>
							</li>
					</ul>		
				</li>
				
				<li class="agreement_p">
					<div class="menu_tit">
						<span>이용약관</span>
					</div>
					<ul class="side_sub">
						<li>
							<textarea name="tos">
슈크림 상품판매 서비스 이용약관
제1조    (목적)
이 슈크림 상품판매 시범 서비스 이용약관(이하 “이 약관”)은, 주식회사 슈크림(이하 “슈크림” 또는 “회사”라 함)과 회사가 제공하는 슈크림 상품 판매 시범 서비스(이하 “상품 판매 시범 서비스" 또는 “이 서비스”)를 이용하고자 하는 사업자(이하 “판매자"라 함)간의 권리와 의무 및 기타 제반사항을 명확히 하는 것을 목적으로 합니다.
제2조    (용어의 정의)
본 약관에서 사용하는 용어의 정의는 다음과 같습니다.
“슈크림 서비스”란 이용자가 회사의 서비스를 이용할 수 있도록 회사가 제공하는 중고거래 및 지역생활 정보 공유를 위한 웹/앱 플랫폼 서비스 일체를 의미합니다.
“이용자”란 슈크림 서비스에 가입하여 고유번호를 부여 받은 후 이를 이용하는 사람을 의미합니다.
“판매자”란 슈크림의 이용자로서 비즈프로필을 생성하고 상품판매 서비스를 이용하는데 있어 이 약관을 준수하기로 동의한 사업자를 의미합니다.
“비즈프로필"이란 슈크림 서비스 내에서 판매자의 사업자 정보를 이용자에게 제공하고 재화 또는 용역에 관한 정보를 노출할 수 있는 서비스를 의미합니다.
“상품 판매 시범 서비스"란 회사가 비즈프로필에 판매자가 등록한 재화 또는 용역을 이용자에게 판매할 수 있도록 중개하는 서비스를 의미합니다.
“슈페이”란 이용자가 파트너의 서비스를 구매하는 데에 있어 회사가 대신하여 지급결제정보를 송신하거나 수신하는 것 또는 그 대가의 정산을 대행하거나 매개하는 전자지급결제대행 서비스를 말합니다.
제3조    (약관의 효력)
회사는 본 약관을 슈크림 서비스 화면에 게시하여, 상품 판매 시범 서비스를 이용하고자 하는 판매자가 본 약관을 확인할 수 있도록 하여야 합니다.
본 약관에 의해 상품 판매 시범 서비스를 이용하고자 하는 자는 이 약관의 내용을 숙지하고 판매자와 회사간의 권리, 의무관계에 대해 동의함을 확인합니다.
회사는 필요한 경우 관련 법령을 위배하지 않는 범위 내에서 이 약관을 개정할 수 있으며, 이 경우 개정 내용과 적용 일자를 명시하여 슈크림 서비스를 통해 그 적용일자 7일 전부터 적용일자 전일까지 공지합니다. 다만 변경 내용이 판매자에게 불리한 변경의 경우, 개정약관의 적용일자 30일 전부터 적용일자까지 공지합니다.
판매자가 개정약관에 동의하지 않는 경우 개정 약관의 적용일 이전에 거부 의사를 표시하고 이 약관에 대한 이 약관을 해지할 수 있습니다.
회사가 본 조 3항에 따라 개정약관을 공지하면서 판매자에게 적용일 전까지 의사표시를 하지 않으면 의사 표시가 표명된 것으로 본다는 뜻을 명확하게 공지하였음에도 판매자가 명시적으로 거부 의사를 표명하지 아니한 경우 개정약관에 동의한 것으로 봅니다.
회사가 영업양도 등의 방법으로 이 약관의 내용 중 슈페이를 이용한 업무처리 및 관련 계약관계를 관련 법률에서 정한 절차에 따라 포괄적으로 이전하고자 하는 경우, 그 사실을 판매자에게 개별적으로 통지하고 판매자가 이에 대하여 30일간 동의 또는 승낙을 거부하는 의사표시를 하지 아니하는 경우 이에 대하여 판매자가 동의 또는 승낙한 것으로 봅니다.
제4조    (이 약관의 성립)
이 약관은 판매 서비스를 이용하고자하는 자가 이 약관에 동의하고 회사가 정한 절차에 따라 서비스 이용 신청을 하며, 이에 대해 회사가 심사를 거쳐 승낙함으로써 성립합니다. 회사는 이용승낙의 의사표시를 해당 서비스 화면에 게시하거나 전자우편 또는 기타 방법으로 할 수 있습니다.
이용신청자는 등록신청의 정확성을 확인하기 위하여 회사가 별도로 요청하는 증빙서류가 있을 경우 신속히 제출하여야 하며, 회사는 해당 서류를 징구하는 시점까지 가입 신청에 대한 승낙을 보류하거나 거부할 수 있습니다.
판매서비스 이용 신청은 19세 이상의 개인사업자 또는 법인사업자가 할 수 있습니다.
회사는 제1항에 따라 판매 서비스 이용을 신청한 자 중에 아래 각호에 해당하는 경우에는 승인을 거부할 수 있으며, 등록이 된 이후에도 아래 각호의 사유가 확인된 경우 승낙을 취소할 수 있습니다.
실명이 아니거나 타인의 정보(사업자 번호 등)를 이용한 경우
허위의 정보를 기재하거나, 회사가 제시하는 내용을 기재하지 않은 경우
회사로부터 판매 중단 조치 등을 받은 판매자가 그 조치 기간 중에 이 약관을 임의 해지하고 재이용신청을 하는 경우
가입을 신청한 자의 귀책사유로 인하여 승인이 불가능하거나 필수 서류 또는 회사가 요청하는 서류를 제출하지 않는 등 기타 제반 사항을 위반하여 신청하는 경우
기타 이 약관에 위배되거나 위법 또는 부당한 이용신청 등 회사가 합리적인 판단에 의하여 필요하다고 인정하는 경우
판매자는 이용신청시 제공한 정보가 변경되는 경우 즉시 회사에게 변경된 정보를 제공하여야 하며, 회사는 판매자가 정당한 사유 없이 변경된 정보를 제공하지 않는 경우 약관의 해지, 이 서비스 이용 제한 또는 결제 금액의 지급 또는 정산 보류를 포함하여 필요한 조치를 취할 수 있습니다. 이 경우 판매자는 회사의 조치에 따라 제3자에게 발생할 수 있는 사항에 대한 모든 책임을 부담합니다.
제5조    (각 당사자의 역할과 의무)
회사와 판매자는 서로 독립적인 사업자이며, 이 약관에 대한 동의 또는 승낙에 따라 회사와 판매자 사이에 고용, 도급, 대리, 가맹(프랜차이즈), 납품, 위탁판매, 모자회사, 합작, 동업, 조합 등 어떠한 다른 관계도 성립하지 않음을 상호 명확히 확인합니다. 판매자는 어떠한 경우에도 자신이 슈크림과 위와 같은 관계에 있음을 표시, 암시하거나 이용자가 위와 같은 관계가 있는 것 같이 오인할 수 있는 행위를 하여서는 아니됩니다.
회사는 이 서비스를 위하여 비즈프로필에 판매자가 재화 또는 서비스를 등록하여 판매할 수 있는 기능을 제공하고 시스템을 운영, 관리하며, 회사가 통신판매의 당사자가 아니라는 사실을 이용자에게 고지합니다.
판매자는 이 서비스를 통해 스스로 정한 판매 조건(상품의 종류, 서비스 조건, 배송 또는 설치 조건, 보증 또는 할인 등)에 따라 재화 또는 서비스를 자신의 상호로 판매하며, 이용자가 구매를 신청한 재화 또는 서비스에 대하여 판매가 확정된 경우 이를 이용자에게 배송, 전달하거나 서비스를 제공하여야 합니다. 판매자는 이 서비스를 통해 자신이 등록한 상품 정보의 이미지, 영상, 텍스트 등 모든 내용, 자신과 이용자 사이에 이루어지는 모든 거래행위 자체와 등록한 상품에 대하여 품질의 적합성, 완전성, 안전성, 합법성 또는 제3자 권리를 침해하지 않는다는 점 등 거래에 관한 모든 책임을 스스로 부담하며, 거래에 관하여 이용자와 분쟁이 발생하는 경우 자신의 비용과 책임으로 이를 모두 해결하여야 합니다.
제6조    (수수료의 책정 및 정산)
슈크림은 판매자의 이 서비스 이용에 대해 서비스이용료 및 결제대행수수료를 부과할 수 있으며, 서비스이용료의 구체적인 사항 및 요율은 서비스 안내 페이지를 통해 공지합니다.
이 서비스를 통해 상품이 구매확정되는 경우, 회사는 판매자를 대신하여 모든 판매대금을 수령하며 회사의 정산 일정 및 정책에 따라 유상결제액 기준 판매대금에서 서비스이용료 및 결제대행수수료를 공제한 나머지 금액을 판매자에게 지급합니다.
제7조    (계약의 해지 및 손해배상)
당사자 일방은 다음 각 호에 해당하는 귀책사유가 있는 상대방에게 10 영업일의 기간을 정하여 시정을 최고한 후 그 기간 동안 시정되지 않은 경우 이 약관을 해지할 수 있습니다.
상대방이 이 약관상의 의무를 불이행하는 경우
상대방이 일방 당사자의 명예 또는 신용을 훼손한 경우
상대방에게 통보한 월 정산금액 등이 허위인 경우
기타 이 약관의 목적을 달성하는 것이 객관적으로 불가능한 경우
당사자는 다음의 경우 상대방에 대한 통보로써 즉시 이 약관을 해지할 수 있습니다.
상대방이 이 약관에 따른 권리의무 및 데이터를 일방 당사자의 사전 동의 없이 제3자에게 양도, 전매하거나 질권 기타 담보의 목적물로 제공하는 경우
상대방이 중요한 재산에 대하여 강제집행(가압류, 가처분포함)을 받거나 경매신청을 받았을 경우
상대방에게 부도, 파산, 워크아웃, 회생 또는 파산절차개시 신청 등 사유가 발생한 경우
본 조에 의해 이 약관이 해지되는 경우 귀책사유가 있는 당사자는 상대방이 입은 손해를 모두 배상해야 합니다. 단, 천재지변 또는 클라우드 서비스의 장애 등 불가항력에 의한 경우는 예외로 합니다.
제8조    (비밀유지의무)
이 약관과 관련하여 상대방으로부터 제공받은 모든 정보는 다음 각 호 어느 하나에 해당하는 경우를 제외하고는 비밀로 하고, 이 약관상의 권리 또는 의무를 이행하기 위한 목적 이외에 이를 사용하거나 제3자에게 제공할 수 없습니다.
당사자들이 공개하기로 합의한 사항
공지된 정보
정보를 제공받은 당사자가 제3자로부터 이미 적법하게 취득한 정보
법률에 특별한 규정이 있거나 법령을 준수하기 위하여 불가피하게 정보를 제공하여야 하는 경우
본 조의 비밀유지의무는 이 약관이 이행되지 않거나 해지 기타 사유로 종료된 경우에도 그 때로부터 2년간 유효합니다.
제9조    (취득한 개인정보의 보호)
판매자는 판매 서비스의 이용에 따라 취득한 이용자 등 타인의 개인정보를 상품의 배송 또는 전달을 위한 목적 이외의 용도로 사용하거나 제3자에게 제공하는 등 외부에 유출할 수 없으며, 관련 법령 등에 따라 철저히 보호하여야 합니다.
슈크림은 배송 등의 목적으로 판매자에게 공개되어 있는 이용자의 개인정보를 슈크림의 정책에 따라 상당 기간이 경과한 후 비공개 조치할 수 있습니다.
판매자가 본 조를 위반하여 이용자와 분쟁이 발생하는 경우 자신의 노력과 비용으로 슈크림을 면책시켜야 하며, 민/형사 상 일체의 법적 책임을 부담하여야 합니다.
제10조    (양도금지)
당사자는 이 약관상의 권리의무를 제3자에게 양도 및 이전하거나 담보로 제공할 수 없습니다.
제11조    (면책)
슈크림은 이용자들과 판매자 사이의 거래를 위한 시스템만을 제공할 뿐, 파트너가 등록한 상품 등에 관한 정보 또는 거래에 관하여 분쟁이 발생한 경우, 그 분쟁의 결과로 인한 책임은 판매자가 부담합니다. 제3자가 슈크림을 상대로 민/형사상 등의 문제를 제기하는 경우 판매자는 문제의 해결을 위하여 필요한 정보를 제공하는 등 적극 협조하여야 하며, 이와 관련하여 슈크림에 손해 또는 비용이 발생하는 경우 이를 배상 또는 보상합니다.
슈크림은 적법한 권리자의 요구가 있거나, 컴퓨터 등 정보통신설비의 보수, 점검, 교체 및 고장, 통신의 두절 등의 사유가 발생한 경우 슈크림 서비스 제공을 일시적으로 중단할 수 있으며, 이와 관련하여 슈크림은 고의 또는 중대한 과실이 없는 한 책임을 부담하지 않습니다.
제12조    (약관 개정)
약관 변경시 회사는 슈크림 서비스를 통해 공지하며, 공지일로부터 7일 후 적용됩니다. 판매자가 변경되는 약관 내용에 대해 이의가 있는 경우 7일 이내에 제기할 수 있으며, 회사가 약관 변경을 명확하게 알리거나 통지하였음에도 불구하고 7일 이내에 판매자가 거부 의사를 명시적으로 나타내지 않는 경우에는, 판매자는 약관의 개정에 동의하는 것으로 간주됩니다.
제13조    (분쟁의 해결)
이 약관으로 인하여 또는 이 약관과 관련하여 분쟁이 발생하는 경우 당사자들은 일차적으로 협의를 통한 원만한 해결을 도모합니다.
제1항에 의한 협의가 이루어지지 않는 경우 이 약관으로 인하여 또는 이 약관과 관련하여 발생하는 모든 분쟁의 해결은 서울중앙지방법원을 제1심의 합의관할로 하는 소송에 의합니다.
적용 일자
2023년 8월 15일
                            </textarea>
                            <br>
                            <p class="terms_p">
	                             <input type="checkbox" name="agreeBtn" class="agreeBtns">이용약관에 동의합니다.
	                             <br>
                            </p>
							</li>
					</ul>
				</li>
			</ul>


			<input type="button" class="res_p" value="거래완료" onclick="requestTrans()">
<!-- 			<button class="res_p" onclick="requestPay()">결제하기</button> -->
		</form>
		
			<input type="button" id="btnHidden" name="btnHidden" onclick="tranSuccess()"/>
	</section>
	
	<script type="text/javascript">
	
	
	// url 에서 파라미터 받아오기
	let getParams = new URL(location.href).searchParams;
	let chat_area = ${map.product_selector } 
	
	$('.menu_tit').click(function() {
		$(this).children('span').addClass('on');
		if ($(this).siblings('.side_sub').is(':hidden')) {
			$(this).siblings('.side_sub').slideDown();
			$(this).children('span').removeClass('on');
		} else {
			$(this).siblings('.side_sub').slideUp();
		}
	});
	
	// 결제 금액 계산
	var totalAmount = 0; // 총 결제 금액 초기값
	
	
	document.addEventListener('DOMContentLoaded', function() {
		  totalAmount = ${map.product_price};
	});


	// 유효성 검사 함수
	function validateForm() {

		var agreeBtn = document.querySelector('input[name="agreeBtn"]');

		// 이용 약관
		if (!agreeBtn.checked) {
		   alert('이용약관에 동의해야 합니다.');
		   agreeBtn.checked = true;
		   return false;
		}

		return true;
	}
	// 결제하기 버튼 누를떄 동작
	function requestTrans() {
		
		// 결제 API 실행 전 유효성 검사
		if(!validateForm()) {
			return false;
		}
		location.href = "${pageContext.request.contextPath }/transComPro?chat_room_idx="
				+ getParams.get("chat_room_idx")
				+ "&chat_area=" 
				+ getParams.get("chat_area");
	}
	

	const tranSuccess = () => {
		location.href = '${pageContext.request.contextPath }/tradeComplete' + "?chat_area=" + chat_area + "&chat_room_idx=" + getParams.get("chat_room_idx") + "&product_idx=${map.product_idx }";
	}
	</script>

	<!-- footer 추가 -->
	<footer>
<%-- 		<jsp:include page="../../inc/footer.jsp"></jsp:include> --%>
	</footer>
	
	
</body>
</html>