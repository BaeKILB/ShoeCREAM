//package com.pj2.shoecream.util;
//
//import javax.validation.ConstraintValidator;
//import javax.validation.ConstraintValidatorContext;
//
//import org.springframework.beans.factory.annotation.Autowired;
//
//import com.pj2.shoecream.service.MemberService;
//
//public class UniqueValidator implements ConstraintValidator<Unique, String> {
//    String field;
//
//    @Autowired
//    MemberService memberService;
//
//    @Override
//    public void initialize(Unique unique) {
//        this.field = unique.field();
//    }
//
//    @Override
//    public boolean isValid(String value, ConstraintValidatorContext context) {
//        boolean isUnique;
//        switch (field) {
//            case "mem_id":
//                isUnique = memberService.isIdUnique(value);
//                break;
//            case "mem_name":
//                isUnique = memberService.isNameUnique(value);
//                break;
//            case "mem_email":
//                isUnique = memberService.isEmailUnique(value);
//                break;
//            case "mem_mtel":
//                isUnique = memberService.isMtelUnique(value);
//                break;
//            default:
//                isUnique = true;
//        }
//        return isUnique;
//    }
//}
