//package com.pj2.shoecream.config;
//
//import org.springframework.context.annotation.Configuration;
//import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
//import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
//import org.springframework.web.servlet.resource.PathResourceResolver;
//
//
//@Configuration
//public class WebMvcConfig implements WebMvcConfigurer { // web 설정 파일
//	
////	@Value("${file.path}")
////	private String uploadFolder;
//	
//    private String uploadDir = 
//    		"C:/Users/kikir/Documents/itwill/workspace_spring5/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/ShoeCREAM/resources/upload/social/";
//	
//    @Override
//	public void addResourceHandlers(ResourceHandlerRegistry registry) {
//		WebMvcConfigurer.super.addResourceHandlers(registry);
//		
////		C:/workspace/springbootwork_new/upload/
//		registry
//			.addResourceHandler("/upload/**") // jsp 페이지에서 /upload/** 이런 주소 패턴이 나오면 발동
//			.addResourceLocations("file:///"+ uploadDir)
//			.setCachePeriod(60*10*6) // 1시간동안 이미지 패싱
//			.resourceChain(true)
//			.addResolver(new PathResourceResolver());
//	}
//	
//}
