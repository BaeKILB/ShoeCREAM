package com.pj2.shoecream.valid;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;

public class NewPasswdValidator implements ConstraintValidator<ValidNewPasswd, String> {

    private static final String PASSWORD_PATTERN = "^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,20}$";

    @Override
    public void initialize(ValidNewPasswd constraintAnnotation) {
    }

    @Override
    public boolean isValid(String newPassword, ConstraintValidatorContext context) {
        if (newPassword == null || newPassword.length() == 0) {
            return true;
        }
        return newPassword.matches(PASSWORD_PATTERN);
    }
}