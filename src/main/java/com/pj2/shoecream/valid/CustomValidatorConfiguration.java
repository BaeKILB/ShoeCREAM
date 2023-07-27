package com.pj2.shoecream.valid;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import com.pj2.shoecream.service.MemberService;

@Configuration
public class CustomValidatorConfiguration {

    @Bean
    public ConflictIdValidator conflictIdValidator(MemberService memberService) {
        return new ConflictIdValidator(memberService);
    }
}

