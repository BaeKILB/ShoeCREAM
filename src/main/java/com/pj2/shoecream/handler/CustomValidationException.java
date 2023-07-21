package com.pj2.shoecream.handler;

import java.util.Map;

public class CustomValidationException extends RuntimeException{

	private static final long serialVersionUID = 1L;
	
	private Map<String, String> errorMap;
	
	public CustomValidationException(String message, Map<String, String>errorMap) {
		super(message); //message 는 중요한게 아니기때문에 부모에게 던진다.
		this.errorMap = errorMap;
	}
	
	public Map<String, String> getErrorMap() {
		return errorMap;
	}
}	
