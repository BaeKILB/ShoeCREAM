package com.pj2.shoecream.util;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;
import javax.validation.Constraint;
import javax.validation.Payload;

@Target({ ElementType.METHOD, ElementType.FIELD })
@Retention(RetentionPolicy.RUNTIME)
@Constraint(validatedBy = NotEmptyDateValidator.class)
public @interface NotEmptyDate {

    String message() default "생년월일을 입력해 주세요";

    Class<?>[] groups() default {};

    Class<? extends Payload>[] payload() default {};
}

