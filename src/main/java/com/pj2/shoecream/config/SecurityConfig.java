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
//			.antMatchers("/","/admin/**").authenticated()
	        .anyRequest().permitAll()
	    .and()
	    .formLogin()
		    .usernameParameter("mem_id") // 시큐리티 설정된 username 을 mem_id 로 바꿈
		    .passwordParameter("mem_passwd") // 시큐리티 설정된 password 을 mem_passwd 로 바꿈
		    .loginPage("/login") // GET
		    .loginProcessingUrl("/MemberLoginPro") // POST -> 스프링 시큐리티가 로그인 프로세스 진행
		    .defaultSuccessUrl("/", true);
	    return http.build();
	}
}
