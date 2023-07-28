package com.pj2.shoecream.handler;

import java.util.Map;

public class CustomApiException extends RuntimeException{
	
	private static final long serialVersionUID = 1L;
	
	public CustomApiException(String message) {
		super(message); //message 는 중요한게 아니기때문에 부모에게 던진다.
	}
}	

