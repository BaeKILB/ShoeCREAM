//package com.pj2.shoecream.config;
//
//import org.springframework.context.annotation.Bean;
//import org.springframework.context.annotation.Configuration;
//import org.springframework.security.config.annotation.web.builders.HttpSecurity;
//import org.springframework.security.config.annotation.web.builders.WebSecurity;
//import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
//import org.springframework.security.core.userdetails.UserDetailsService;
//import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
//import org.springframework.security.web.SecurityFilterChain;
//
//@EnableWebSecurity
//@Configuration
//public class SecurityConfig {
//	
//	@Bean
//	public BCryptPasswordEncoder encode() {
//		return new BCryptPasswordEncoder();
//	}
//	
//    @Bean
//    public UserDetailsService userDetailsService() {
//        return new PrincipalDetailsService();
//    }
//	
//    @Bean
//    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
//        http.csrf().disable();
//        http.authorizeRequests()
//            .antMatchers("/resources/css/**", "/resources/js/**", "/resources/img/**").permitAll() // css, js, img 접근 허용
//            .antMatchers("/", "/auth/kakao/callback", "/login", "/signup", "/social/**").permitAll() // 로그인 안한 회원이 접근 할 수 있는 페이지
//            .antMatchers("/logout", "/mypage/**", "/store/**", "/Auction", "/regist**", "/Register**", "/product**").authenticated() // 로그인한 회원이 접근 할 수 있는 페이지
//            .antMatchers("/**").hasRole("ADMIN") // role 이 ROLE_ADMIN 인 유저는 모든 페이지 다 허용
//            .anyRequest().denyAll() // 이 조건 외의 주소는 다 팅김
//        .and()
//        .formLogin()
//            .usernameParameter("mem_id")  
//            .passwordParameter("mem_passwd") 
//            .loginPage("/login") // 로그인 페이지 매핑 주소
//            .loginProcessingUrl("/login") // 실제로 로그인 하는 매핑 주소
//            .defaultSuccessUrl("/", true)
//        .and()
//        .exceptionHandling()
//            .accessDeniedPage("/"); // 팅길때 메인페이지로 이동
//
//        return http.build();
//    }
//
//}
