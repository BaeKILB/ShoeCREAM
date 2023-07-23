package com.pj2.shoecream.util;

import java.util.Date;
import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;

public class NotEmptyDateValidator implements ConstraintValidator<NotEmptyDate, Date> {

    @Override
    public void initialize(NotEmptyDate notEmptyDate) {
    }

    @Override
    public boolean isValid(Date date, ConstraintValidatorContext context) {
        return date != null;
    }
}

