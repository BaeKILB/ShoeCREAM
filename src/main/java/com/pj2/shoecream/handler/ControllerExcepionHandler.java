package com.pj2.shoecream.handler;

import java.util.Map;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestController;


@RestController
@ControllerAdvice
public class ControllerExcepionHandler {
	
	@ExceptionHandler(CustomValidationException.class) // RuntimeException 발동하는 모든 Exception을 이 함수가 다 가로챔
	public Map<String, String> validationException(CustomValidationException e) {
		return e.getErrorMap();
	}
}
