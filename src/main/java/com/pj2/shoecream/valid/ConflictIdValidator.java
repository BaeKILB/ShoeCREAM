package com.pj2.shoecream.valid;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;

import com.pj2.shoecream.service.MemberService;

public class ConflictIdValidator implements ConstraintValidator<ValidNonConflictId, String> {

    private MemberService memberService;

    public ConflictIdValidator(MemberService memberService) {
        this.memberService = memberService;
    }

    @Override
    public void initialize(ValidNonConflictId constraintAnnotation) {
    }

    @Override
    public boolean isValid(String mem_id, ConstraintValidatorContext context) {
        if (mem_id == null || mem_id.isEmpty()) {
            return true;
        }
        return !memberService.isMemberIdDuplicated(mem_id);
    }
}

