<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp"%>
<script>
  let posts_idx = ${posts_idx};
</script>
    <!--사진 업로드페이지 중앙배치-->
        <main class="uploadContainer">
        <input type="hidden" id="posts_idx" value="${posts_idx}" />
           <!--사진업로드 박스-->
            <section class="upload">
               
               <!--사진업로드 로고-->
                <div class="upload-top">
                    <a href="home.html" class="">
                        <img src="${pageContext.request.contextPath }/resources/img/member/social/social.png" alt="">
                    </a>
                    <p>사진 업로드</p>
                </div>
                <!--사진업로드 로고 end-->
                
                <!--사진업로드 Form-->
                <form class="upload-form" action="${pageContext.request.contextPath }/ImageUpdatePro" method="post" enctype="multipart/form-data"> <!-- 파일과 www-form 데이터 두개를 전송하고 싶을때 사용  -->
             				<c:choose>
								<c:when test="${empty image[0].posts_image1 }">
                    				<input  type="file" name="file1" onchange="imageChoose(this)" value="${image[0].posts_image1}"  />
									<div class="upload-img">
				                        <img src="${pageContext.request.contextPath }/resources/img/member/social/social.png"  alt="" id="imageUploadPreview" />
				                    </div>
								</c:when>
								<c:otherwise>
									<div class="upload-form-detail" id="imageBtnArea">
										<input type="button" class="btn btn-light btn-sm" value="삭제" onclick="deleteFile('${image[0].posts_image1}')">
									
	<%-- 									<c:set var="length" value="${fn:length(car.car_file1) }" /> --%>
	<%-- 									<c:set var="index" value="${fn:indexOf(car.car_file1, '_') }" /> --%>
	<%-- 									<c:set var="fileName" value="${fn:substring(car.car_file1, index + 1, length) }" /> --%>
	<%-- 									<a href="${pageContext.request.contextPath}/resources/upload/car/${car.car_file_path}/${car.car_file1}">${car.car_file1 }</a> --%>
										<div class="upload-img">
											<img src="${pageContext.request.contextPath }/resources/upload/social/${image[0].posts_image1}" alt="Car Image" class="car-image">
										</div>
										<%-- 삭제버튼 클릭 시 deleteFile() 함수 호출(파라미터로 글번호, 파일명 전달) --%>
									</div>
								</c:otherwise>
							</c:choose>
							
                    
                    
<%--                     <input  type="file" name="file1" onchange="imageChoose(this)" value="${image[0].posts_image1}"  /> --%>
<!--                     <div class="upload-img"> -->
<%--                         <img src="${pageContext.request.contextPath }/resources/upload/social/${image[0].posts_image1}"  alt="" id="imageUploadPreview" /> --%>
<!--                     </div> -->
                    
                    <!--사진설명 + 업로드버튼-->
                    <div class="upload-form-detail">
						<input type="text" placeholder="글 내용을 입력하세요" name="posts_content" value="${image[0].posts_content}"/>
                        <button class="cta blue">수정하기</button>
                    </div>
                    <!--사진설명end-->
                    
                </form>
                <!--사진업로드 Form-->
            </section>
            <!--사진업로드 박스 end-->
        </main>
        <br/><br/>
	<script src="${pageContext.request.contextPath }/resources/js/member/social/update.js"></script>
	
