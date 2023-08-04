package com.pj2.shoecream.handler;


import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestController;

import com.pj2.shoecream.util.Script;
import com.pj2.shoecream.vo.CMRespDto;



@RestController
@ControllerAdvice
public class ControllerExcepionHandler {
	
	@ExceptionHandler(CustomValidationException.class) // RuntimeException 발동하는 모든 Exception을 이 함수가 다 가로챔
	public String validationException(CustomValidationException e, Model model) { // <?> 로 e.getErrorMap 자리에 뭘 들어가도 다 맞게 맞춰진다.
		
		if(e.getErrorMap() == null) { 
			return Script.back(e.getMessage());
		}
		return Script.back(e.getErrorMap().toString());
//        model.addAttribute("msg", e.getErrorMap().toString());
//		return "member/fail_back";
	}
	
	@ExceptionHandler(CustomValidationApiException.class)
	public ResponseEntity<?> validationApiException(CustomValidationApiException e) {
		return new ResponseEntity<>(new CMRespDto<>(-1, e.getMessage(), e.getErrorMap()), HttpStatus.BAD_REQUEST);
	}
	
	
	@ExceptionHandler(CustomApiException.class) // RuntimeException 발동하는 모든 Exception을 이 함수가 다 가로챔
	public ResponseEntity<?> apiException(CustomApiException e) { // <?> 로 e.getErrorMap 자리에 뭘 들어가도 다 맞게 맞춰진다.
		return new ResponseEntity<>(new CMRespDto<>(-1,e.getMessage(), null), HttpStatus.BAD_REQUEST);
	}
	
}
