package com.pj2.shoecream.valid;

import javax.validation.Constraint;
import javax.validation.Payload;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Target({ElementType.FIELD, ElementType.PARAMETER})
@Retention(RetentionPolicy.RUNTIME)
@Constraint(validatedBy = ConflictIdValidator.class)
public @interface ValidNonConflictId {
    String message() default "이미 사용 중인 아이디입니다.";

    Class<?>[] groups() default {};

    Class<? extends Payload>[] payload() default {};
}

