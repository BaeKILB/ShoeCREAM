<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal" var="principal"/>
</sec:authorize>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 부트스트랩 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-gH2yIJqKdNHPEq0n4Mqa/HGKIhSkIHeL5AyhkYV8i59U5AR6csBvApHHNl/vI1Bx" crossorigin="anonymous">

<!-- 공통 CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/main_ex/market/common.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/main_ex/font/font.css">

<!-- 햄버거 메뉴 호버시 -->
<script src="${pageContext.request.contextPath }/resources/js/main_ex/market/jquery-3.6.0.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/main_ex/market/menu_hover.js?ver=1"></script>
<!-- 파비콘 -->
<link rel="icon" href="${pageContext.request.contextPath }/resources/img/main_ex/market/favicon.ico">
<style type="text/css">
div #test_area ul { /* 카테고리 css */
 display: none; height: 360.909px;
}
</style>
</head>
<body>
<script type="text/javascript">
	function confirmLogout(){
		let result = confirm("로그아웃 하시겠습니까?");	
		return result;
	}
	
	function pointCharge() {
		window.open("pointCharge", "포인트 충전 새창", "width=800, height=1200");
	}
	function show_name(e){
		   var code = e.code;
		   let search = $("#product_search").val();
		   console.log('검색');
		   if(code == 'Enter'){
		       location.href = 'product_searchPro?product_search='+ search;
		   }
		}
</script>

<!-- header 영역 -->
        <header>
            <div id="top_header_bot_border">
                <div id="top_header">
                        <div class="container text-center">
                            <div id="top_header_menu" class="row justify-content-between">
                                <div class="col-4 top_header_icon">
                                    <a href="#">
<%--                                         <img src="${pageContext.request.contextPath }/resources/img/market/download.svg" alt="앱 다운로드"> 앱다운로드 --%>
                                    </a>
                                    <a href="#">
<%--                                         <img src="${pageContext.request.contextPath }/resources/img/market/bookmark.svg" alt="즐겨찾기"> 즐겨찾기 --%>
                                    </a>
                                </div>
                                <div class="col-6">
                                    <div class="row justify-content-end top_header_login">
                                    	<c:choose>
                                    		<c:when test="${empty sessionScope.sId }">
		                                        <div class="col-2"><a href="login">로그인</a></div>
		                                        <div class="col-2"><a href="signup">회원가입</a></div>
		                                        <div class="col-2" style="text-align: left;"><a href="CustomerCenter.ad">고객센터</a></div>
                                    		</c:when>
                                    		<c:otherwise>
                                    			<div class="col-2"><a href="myPage.me">${member.mem_id }님</a></div>
                                    			<div class="col-2"><a href="logout" onclick="return confirmLogout()">로그아웃</a></div>
<!-- 		                                        <div class="col-2" style="text-align: left;"><a href="CustomerCenter.ad">고객센터</a></div> -->
		                                        <div class="col-2" style="text-align: left;"><a href="noticeMain.ad">고객센터</a></div>
		                                        	<c:if test="${sessionScope.sId eq 'admin' }">
			                                        	<div class="col-3" style="text-align: left;"><a href="adminMain.ad">관리자페이지</a></div>
		                                        	</c:if>
							                    <div class="col-2">
<!-- 							                    	<button type="submit" class="btn btn-primary">포인트충전</button> -->
						                            <a href=""> 
						                                <img src="${pageContext.request.contextPath }/resources/img/main_ex/market/sell.png" alt="포인트 충전" onclick="pointCharge()" style="width: 23px; height: 26px">
						                            	포인트
						                            </a>
						                        </div>
                                    		</c:otherwise>
                                    	</c:choose>
                                    </div>
                                </div>
                            </div>
                        </div>
                </div>
            </div>
        </header>
        <div id="bot_header_border">
            <div id="bot_header">
                <div class="container text-center">
                    <div class="row justify-content-start">
                        <div class="col-3 header_logo">
                            <h1 class="hidden">로고</h1>
                            <a href="./">
                                <img src="${pageContext.request.contextPath }/resources/img/main_ex/shoecream-logo.png" alt="슈크림 로고" width="130px;" height="40px;">
                            </a>
                        </div>
                        <div class="col-6 top_searh_area">
                        	<c:choose>
                        		<c:when test="${not empty product_search }">
		                            <div id="top_searh">
		                                <input type="text" value="${product_search }" id="product_search" name="product_search" placeholder="상품명 입력"  onkeypress="show_name(event)">
		                                <img src="${pageContext.request.contextPath }/resources/img/main_ex/market/search.png" alt="검색">
		                            </div>
	                            </c:when>
	                            <c:otherwise>
	                            	<div id="top_searh">
		                                <input type="text" id="product_search" name="product_search" placeholder="상품명 입력"  onkeypress="show_name(event)">
		                                <img src="${pageContext.request.contextPath }/resources/img/main_ex/market/search.png" alt="검색">
		                            </div>
	                            </c:otherwise>
                            </c:choose>
                        </div>
<!--                         <div class="col-1 b_h_left_menu"> -->
<!--                             <a href="RegisterForm">  -->
<%--                                 <img src="${pageContext.request.contextPath }/resources/img/main_ex/market/sell.png" alt="판매하기"> --%>
<!--                                 판매하기 -->
<!--                             </a> -->
<!--                         </div> -->
                        <div class="col-1 b_h_left_menu store">
                            <a href="${pageContext.request.contextPath }/mypage">
                                <img src="${pageContext.request.contextPath }/resources/img/main_ex/market/my_store.png" alt="마이페이지">
                                마이페이지
                            </a>
                        </div>
                        <div class="col-1 b_h_left_menu">
                            <a href="myChatting">
                                <img src="${pageContext.request.contextPath }/resources/img/main_ex/market/talk.png" alt="1:1문의">
                                채팅
                            </a>
                        </div>
                        <div class="col-1 b_h_left_menu">
                            <a href="${pageContext.request.contextPath }/social">
                                <img src="${pageContext.request.contextPath }/resources/img/member/social/logo2.png" alt="Social">
                                소셜
                            </a>
                        </div>
                        
<!-- 		            <nav class="navi"> -->
<!-- 						<ul class="navi-list"> -->
<!-- 							<li class="navi-item"><a href="/user/1"> -->
<!-- 									<i class="far fa-user"></i> -->
<!-- 								</a></li> -->
<!-- 						</ul> -->
<!-- 					</nav> -->
                    </div>
                </div>
                <div class="container text-center hamburger_area">
                    <div class="row">
                        <div class="col-md-1 hamburger">
                            <img id="menu" src="${pageContext.request.contextPath }/resources/img/main_ex/market/hamburger.png" alt="메뉴">
                        </div>
                        <div class="col-md-4 sell_center">
                            <p style="width: 280px">
	                            <a href="product_list" style="color: black;">중고거래　</a>
	                            <a href="auction" style="color: black;">경매하기　</a>
	                            <a href="goodsStore.ad" style="color: black;">굿즈 스토어　</a>
	                            <a href="community" style="color: black;">커뮤니티　</a>
	                        </p>
                        </div>
                         <!-- 메뉴 호버 -->
                        <div id="test_area">
                            <ul id="test_cates">
                                <h2>전체 카테고리<span> ></span></h2>
                                <li id="clothes"><a href="product_category?param=패션/의류">패션/의류</a></li>
                                <li id="acc"><a href="product_category?param=패션/잡화">패션/잡화</a></li>
                                <li id="hobby"><a href="product_category?param=취미/컬렉션">취미/컬렉션</a></li>
                                <li id="digital"><a href="product_category?param=디지털">디지털</a></li>
                                <li id="sports"><a href="product_category?param=스포츠/레저">스포츠/레저</a></li>
                                <li id="beauty"><a href="product_category?param=뷰티">뷰티</a></li>
                                <li id="life"><a href="product_category?param=생활가전">생활가전</a></li>
                                <li id="car"><a href="product_category?param=자동차/공구">자동차/공구</a></li>
                                <li id="book"><a href="product_category?param=도서/기타">도서/기타</a></li>
                            </ul>
                            <!-- 중 분류 -->
                            <ul id="test_clos">
                                <h3>패션/의류</h3>
                                <li id="test_closA"><a href="product_category?param=여성의류">여성의류</a></li>
                                <li id="test_closB"><a href="product_category?param=남성의류">남성의류</a></li>
                                <li id="test_closC"><a href="product_category?param=언더웨어">언더웨어</a></li>
                            </ul>
                            <!-- 소 분류 -->
                             <ul id="test_closAA">
                                <h3>여성의류</h3>
                                <li><a href="product_category?param=셔츠/블라우스">셔츠/블라우스</a></li>
                                <li><a href="product_category?param=티셔츠">티셔츠</a></li>
                            </ul>
                             <ul id="test_closBB">
                                <h3>남성의류</h3>
                                <li><a href="product_category?param=반팔티셔츠">반팔티셔츠</a></li>
                                <li><a href="product_category?param=바지">바지</a></li>
                            </ul>
                             <ul id="test_closCC">
                                <h3>언더웨어</h3>
                                <li><a href="product_category?param=여성 언더웨어">여성 언더웨어</a></li>
                                <li><a href="product_category?param=남성 언더웨어">남성 언더웨어</a></li>
                            </ul>
                            <!-- 중 분류 -->
                            <ul id="test_accs">
                                <h3>패션잡화</h3>
                                <li id="test_accsA"><a href="product_category?param=신발">신발</a></li>
                                <li id="test_accsB"><a href="product_category?param=가방/잡화">가방/잡화</a></li>
                                <li id="test_accsC"><a href="product_category?param=쥬얼리/시계">쥬얼리/시계</a></li>
                                <li id="test_accsD"><a href="product_category?param=수입명품">수입명품</a></li>
                            </ul>
                            <!-- 소 분류 -->
                            <ul id="test_accsAA">
                                <h3>신발</h3>
                                <li><a href="product_category?param=남성신발">남성신발</a></li>
                                <li><a href="product_category?param=여성신발">여성신발</a></li>
                            </ul>
                            <ul id="test_accsBB">
                                <h3>가방/잡화</h3>
                                <li><a href="product_category?param=남성가방">남성가방</a></li>
                                <li><a href="product_category?param=여성가방">여성가방</a></li>
                            </ul>
                            <ul id="test_accsCC">
                                <h3>쥬얼리/시계</h3>
                                <li><a href="product_category?param=악세사리">악세사리</a></li>
                                <li><a href="product_category?param=팔찌/발찌/시계">팔찌/발찌/시계</a></li>
                            </ul>
                            <ul id="test_accsDD">
                                <h3>수입명품</h3>
                                <li><a href="product_category?param=명품의류">명품의류</a></li>
                                <li><a href="product_category?param=명품 지갑/벨트">명품 지갑/벨트</a></li>
                            </ul>
                            <!-- 중 분류 -->
                            <ul id="test_hobby">
                                <h3>취미/컬렉션</h3>
                                <li id="test_hobbyA"><a href="product_category?param=반려동물용품">반려동물용품</a></li>
                                <li id="test_hobbyB"><a href="product_category?param=악기/취미">악기/취미</a></li>
                                <li id="test_hobbyC"><a href="product_category?param=문구/사무용품">문구/사무용품</a></li>
                                <li id="test_hobbyD"><a href="product_category?param=꽃/이벤트용품">꽃/이벤트용품</a></li>
                            </ul>
                            <!-- 소 분류 -->
                            <ul id="test_hobbyAA">
                                <h3>반려동물용품</h3>
                                <li><a href="product_category?param=강아지사료">강아지사료</a></li>
                                <li><a href="product_category?param=강아지간식">강아지간식</a></li>
                            </ul>
                            <ul id="test_hobbyBB">
                                <h3>악기/취미</h3>
                                <li><a href="product_category?param=악기/악기용품">악기/악기용품</a></li>
                                <li><a href="product_category?param=게임/게임용품">게임/게임용품</a></li>
                            </ul>
                            <ul id="test_hobbyCC">
                                <h3>문구/사무용품</h3>
                                <li><a href="product_category?param=보드/게시판">보드/게시판</a></li>
                                <li><a href="product_category?param=도장/스탬프">도장/스탬프</a></li>
                            </ul>
                            <ul id="test_hobbyDD">
                                <h3>꽃/이벤트용품</h3>
                                <li><a href="product_category?param=원예/식물">원예/식물</a></li>
                                <li><a href="product_category?param=이벤트/파티용품">이벤트/파티용품</a></li>
                            </ul>
                            
                            <!-- 중 분류 -->
                            <ul id="test_digital">
                                <h3>디지털</h3>
                                <li id="test_digitalA"><a href="product_category?param=노트북/데스크탑">노트북/데스크탑</a></li>
                                <li id="test_digitalB"><a href="product_category?param=모니터/프린터">모니터/프린터</a></li>
                                <li id="test_digitalC"><a href="product_category?param=PC주변기기">PC주변기기</a></li>
                                <li id="test_digitalD"><a href="product_category?param=저장장치">저장장치</a></li>
                            </ul>
                            <!-- 소 분류 -->
                            <ul id="test_digitalAA">
                                <h3>노트북/데스크탑</h3>
                                <li><a href="product_category?param=노트북">노트북</a></li>
                                <li><a href="product_category?param=데스크탑">데스크탑</a></li>
                            </ul>
                            <ul id="test_digitalBB">
                                <h3>모니터/프린터</h3>
                                <li><a href="product_category?param=모니터">모니터</a></li>
                                <li><a href="product_category?param=프린터">프린터</a></li>
                            </ul>
                            <ul id="test_digitalCC">
                                <h3>PC주변기기</h3>
                                <li><a href="product_category?param=PC용품">PC용품</a></li>
                                <li><a href="product_category?param=PC부품">PC부품</a></li>
                            </ul>
                            <ul id="test_digitalDD">
                                <h3>저장장치</h3>
                                <li><a href="product_category?param=HDD/SSD">HDD/SSD</a></li>
                                <li><a href="product_category?param=저장장치용품">저장장치용품</a></li>
                            </ul>
                            
                            <!-- 중 분류 -->
                            <ul id="test_sports">
                                <h3>스포츠/레저</h3>
                                <li id="test_sportsA"><a href="product_category?param=스포츠의류/운동화">스포츠의류/운동화</a></li>
                                <li id="test_sportsB"><a href="product_category?param=등산/아웃도어/캠핑/낚시">등산/아웃도어/캠핑/낚시</a></li>
                                <li id="test_sportsC"><a href="product_category?param=스포츠용품">스포츠용품</a></li>
                                <li id="test_sportsD"><a href="product_category?param=자전거/보드/기타레저">자전거/보드/기타레저</a></li>
                            </ul>
                            <!-- 소 분류 -->
                            <ul id="test_sportsAA">
                                <h3>스포츠의류/운동화</h3>
                                <li><a href="product_category?param=스포츠남성의류">스포츠남성의류</a></li>
                                <li><a href="product_category?param=스포츠여성의류">스포츠여성의류</a></li>
                            </ul>
                            <ul id="test_sportsBB">
                                <h3>등산/아웃도어/캠핑/낚시</h3>
                                <li><a href="product_category?param=등산의류">등산의류</a></li>
                                <li><a href="product_category?param=등산장비">등산장비</a></li>
                            </ul>
                            <ul id="test_sportsCC">
                                <h3>스포츠용품</h3>
                                <li><a href="product_category?param=스포츠아이템">스포츠아이템</a></li>
                                <li><a href="product_category?param=스포츠기구">스포츠기구</a></li>
                            </ul>
                            <ul id="test_sportsDD">
                                <h3>자전거/보드/기타레저</h3>
                                <li><a href="product_category?param=자전거">자전거</a></li>
                                <li><a href="product_category?param=보드/기타레저">보드/기타레저</a></li>
                            </ul>
                            
                            <!-- 중 분류 -->
                            <ul id="test_beauty">
                                <h3>뷰티</h3>
                                <li id="test_beautyA"><a href="product_category?param=화장품/향수">화장품/향수</a></li>
                                <li id="test_beautyB"><a href="product_category?param=바디/헤어">바디/헤어</a></li>
                            </ul>
                            <!-- 소 분류 -->
                            <ul id="test_beautyAA">
                                <h3>화장품/향수</h3>
                                <li><a href="product_category?param=스킨케어">스킨케어</a></li>
                                <li><a href="product_category?param=향수">향수</a></li>
                            </ul>
                            <ul id="test_beautyBB">
                                <h3>바디/헤어</h3>
                                <li><a href="product_category?param=바디케어">바디케어</a></li>
                                <li><a href="product_category?param=헤어케어">헤어케어</a></li>
                            </ul>
                            <!-- 중 분류 -->
                            <ul id="test_life">
                                <h3>생활/가전</h3>
                                <li id="test_lifeA"><a href="product_category?param=가구DIY">가구DIY</a></li>
                                <li id="test_lifeB"><a href="product_category?param=조명/인테리어">조명/인테리어</a></li>
                                <li id="test_lifeC"><a href="product_category?param=침대/커튼">침대/커튼</a></li>
                                <li id="test_lifeD"><a href="product_category?param=생활용품">생활용품</a></li>
                            </ul>
                            <!-- 소 분류 -->
                            <ul id="test_lifeAA">
                                <h3>가구DIY</h3>
                                <li><a href="product_category?param=침대/매트릭스">침대/매트릭스</a></li>
                                <li><a href="product_category?param=옷장/붙박이장">옷장/붙박이장</a></li>
                            </ul>
                            <ul id="test_lifeBB">
                                <h3>조명/인테리어</h3>
                                <li><a href="product_category?param=전구/형광등">전구/형광등</a></li>
                                <li><a href="product_category?param=조명기구">조명기구</a></li>
                            </ul>
                            <ul id="test_lifeCC">
                                <h3>침구/커튼</h3>
                                <li><a href="product_category?param=침구세트">침구세트</a></li>
                                <li><a href="product_category?param=토퍼/패드">토퍼/패드</a></li>
                            </ul>
                            <ul id="test_lifeDD">
                                <h3>생활용품</h3>
                                <li><a href="product_category?param=수납/정리용품">수납/정리용품</a></li>
                                <li><a href="product_category?param=선반/행거/진열대">선반/행거/진열대</a></li>
                            </ul>
                            <!-- 중 분류 -->
                            <ul id="test_car">
                                <h3>자동차/공구</h3>
                                <li id="test_carA"><a href="product_category?param=자동차용품">자동차용품</a></li>
                                <li id="test_carB"><a href="product_category?param=공구/안전/산업용품">공구/안전/산업용품</a></li>
                            </ul>
                            <!-- 소 분류 -->
                            <ul id="test_carAA">
                                <h3>자동차용품</h3>
                                <li><a href="product_category?param=자동차관리용품">자동차관리용품</a></li>
                                <li><a href="product_category?param=자동차내부용품">자동차내부용품</a></li>
                            </ul>
                            <ul id="test_carBB">
                                <h3>공구/안전/산업용품</h3>
                                <li><a href="product_category?param=공구">공구</a></li>
                                <li><a href="product_category?param=안전용품">안전용품</a></li>
                            </ul>
                            <!-- 중 분류 -->
                            <ul id="test_book">
                                <h3>도서/기타</h3>
                                <li id="test_bookA"><a href="product_category?param=도서/교육/음반">도서/교육/음반</a></li>
                                <li id="test_bookB"><a href="product_category?param=백화점/제화상품권">백화점/제화상품권</a></li>
                                <li id="test_bookC"><a href="product_category?param=여행/항공권">여행/항공권</a></li>
                                <li id="test_bookD"><a href="product_category?param=e쿠폰/모바일상품권">e쿠폰/모바일상품권</a></li>
                            </ul>
                            <!-- 소 분류 -->
                            <ul id="test_bookAA">
                                <h3>도서/교육/음반</h3>
                                <li><a href="product_category?param=중고도서">중고도서</a></li>
                                <li><a href="product_category?param=전자책">전자책</a></li>
                            </ul>
                            <ul id="test_bookBB">
                                <h3>백화점/제화상품권</h3>
                                <li><a href="product_category?param=롯데백화점">롯데백화점</a></li>
                                <li><a href="product_category?param=신세계백화점">신세계백화점</a></li>
                            </ul>
                            <ul id="test_bookCC">
                                <h3>여행/항공권</h3>
                                <li><a href="product_category?param=해외항공권">해외항공권</a></li>
                                <li><a href="product_category?param=국내항공권">국내항공권</a></li>
                            </ul>
                            <ul id="test_bookDD">
                                <h3>e쿠폰/모바일상품권</h3>
                                <li><a href="product_category?param=문화상품권">문화상품권</a></li>
                                <li><a href="product_category?param=기타상품권">기타상품권</a></li>
                            </ul>
                        </div>
                        <!-- // 메뉴 호버 -->
                    </div>
                </div>

                <div id="side_bar">
<!--                     <div id="heart"> -->
<!--                         <p>찜한 상품</p> -->
<%--                         <p><img src="${pageContext.request.contextPath }/resources/img/market/heart.png" alt="찜 하트"> 0</p> --%>
<!--                     </div> -->
<!--                     <div id="goods"> -->
<!--                         <p>여기뭐하기로했더라</p> -->
<!--                         <p id="dotted"></p> -->
<!--                         <p> -->
<%--                             <img src="${pageContext.request.contextPath }/resources/img/market/eyes.png" alt="눈표시"> --%>
<!--                             <p>최근 본 상품<br>이<br>없습니다.</p> -->
<!--                         </p> -->
<!--                     </div> -->
<!--                     <div id="QR_code"> -->
<!--                         <p>앱 다운로드</p> -->
<!--                         <p> -->
<%--                             <img src="${pageContext.request.contextPath }/resources/img/market/QR_code.png" alt="QR 코드"> --%>
<!--                         </p> -->
<!--                     </div> -->
                    <div id="top_btn">
                        <button>
                            <a href="#top_header">TOP</a>
                        </button>
                    </div>
                </div>
            </div>
        </div>
        <!-- // header 영역 -->
</body>
</html>