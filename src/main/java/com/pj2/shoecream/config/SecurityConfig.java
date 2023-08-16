package com.pj2.shoecream.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

@EnableWebSecurity
@Configuration
public class SecurityConfig {
	
	@Bean
	public BCryptPasswordEncoder encode() {
		return new BCryptPasswordEncoder();
	}
	
    @Bean
    public UserDetailsService userDetailsService() {
        return new PrincipalDetailsService();
    }
	
	@Bean
	public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception{
		http.csrf().disable(); // 이제 csrf 토큰 검사 안함
		http.authorizeRequests()
			.antMatchers("/mypage/**","/social/**","/api/**" ,"/store/**", "/regist**", "/modify**", "/pay**", "/trade**", "/Jung**" , "/start**"
					, "/trans**", "/shoe**", "/authorize**", "/charge**", "/withdraw**", "/Auction**", "/bidding**", "/auction**", "/Auc**", "/delivery**"
					, "/tracking**" , "/acquisition", "/tracking**", "/shipping**").authenticated() // 인증(로그인)한 유저만 갈 수 있는 페이지
			.antMatchers("/Admi**", "/Inquiry**", "/QstModifyForm", "/creamInsert**", "/creamApply**" , "/AccountCheck**", "/noticeWriteForm**", "/NoticeList**"
					, "/adminProduct**", "/noticeDetail**" , "/noticeModify**", "/noticeDelete**", "/auctionProduct**", "/DeleteProAuction**", "/creamProduct**", "/auctionReport**", "/adminPointAccount**").hasRole("ADMIN") // "/AdminMain" 페이지는 ROLE_ADMIN 권한이 있는 사용자만 접근 가능
			.anyRequest().permitAll()
	    .and()
	    .formLogin()
		    .usernameParameter("mem_id") // 시큐리티 설정된 username 을 mem_id 로 바꿈
		    .passwordParameter("mem_passwd") // 시큐리티 설정된 password 을 mem_passwd 로 바꿈
		    .loginPage("/login") // GET 방식 : 로그인 페이지는 매핑을 "/login" 이다 라고 지정 
		    .loginProcessingUrl("/login") // POST 로 요청된 login(내가 지정한 매핑주소) -> 스프링 시큐리티가 로그인 프로세스 진행
		    .defaultSuccessUrl("/", true)
	    .and()
	    .exceptionHandling()
	        .accessDeniedPage("/"); // 팅길때 메인페이지로 이동
	    return http.build();
	}
}
