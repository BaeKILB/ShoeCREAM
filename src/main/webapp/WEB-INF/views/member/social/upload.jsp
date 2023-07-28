<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	
<%@ include file="../layout/header.jsp"%>

    <!--사진 업로드페이지 중앙배치-->
        <main class="uploadContainer">
           <!--사진업로드 박스-->
            <section class="upload">
               
               <!--사진업로드 로고-->
                <div class="upload-top">
                    <a href="home.html" class="">
                        <img src="${pageContext.request.contextPath }/resources/img/member/social/jodan.jpg" alt="">
                    </a>
                    <p>사진 업로드</p>
                </div>
                <!--사진업로드 로고 end-->
                
                <!--사진업로드 Form-->
                <form class="upload-form" action="${pageContext.request.contextPath }/ImageUploadPro" method="post" enctype="multipart/form-data"> <!-- 파일과 www-form 데이터 두개를 전송하고 싶을때 사용  -->
                    <input  type="file" name="file1"  onchange="imageChoose(this)" />
                    <div class="upload-img">
                        <img src="${pageContext.request.contextPath }/resources/img/member/social/jodan.jpg" alt="" id="imageUploadPreview" />
                    </div>
                    
                    <!--사진설명 + 업로드버튼-->
                    <div class="upload-form-detail">
                   		 <input type="text" placeholder="사진설명" name="posts_content"/>
                        <button class="cta blue">업로드</button>
                    </div>
                    <!--사진설명end-->
                    
                </form>
                <!--사진업로드 Form-->
            </section>
            <!--사진업로드 박스 end-->
        </main>
        <br/><br/>
	<script src="${pageContext.request.contextPath }/resources/js/member/social/upload.js"></script>
	
