package com.pj2.shoecream.valid;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;
import java.util.Date;

public class NotNullDateValidator implements ConstraintValidator<ValidNotNullDate, Date> {

    @Override
    public void initialize(ValidNotNullDate constraintAnnotation) {
    }

    @Override
    public boolean isValid(Date date, ConstraintValidatorContext context) {
        return date != null;
    }
}

