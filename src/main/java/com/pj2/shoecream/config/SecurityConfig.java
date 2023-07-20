package com.pj2.shoecream.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
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
	public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception{
		http.csrf().disable(); // 이제 csrf 토큰 검사 안함
		http.authorizeRequests()
//			.antMatchers("/","/admin/**").authenticated()
	        .anyRequest().permitAll()
	    .and()
	    .formLogin()
	    	.loginPage("/login")
	        .loginProcessingUrl("/login")
	        .defaultSuccessUrl("/", true);
	    return http.build();
	}
}
