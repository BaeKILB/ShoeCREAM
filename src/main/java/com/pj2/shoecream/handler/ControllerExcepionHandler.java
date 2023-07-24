package com.pj2.shoecream.handler;


import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestController;

import com.pj2.shoecream.util.Script;



@RestController
@ControllerAdvice
public class ControllerExcepionHandler {
	
	@ExceptionHandler(CustomValidationException.class) // RuntimeException 발동하는 모든 Exception을 이 함수가 다 가로챔
	public String validationException(CustomValidationException e) { // <?> 로 e.getErrorMap 자리에 뭘 들어가도 다 맞게 맞춰진다.
		
		if(e.getErrorMap() == null) { 
			return Script.back(e.getMessage());
		}
		return Script.back(e.getErrorMap().toString());
	}

}
