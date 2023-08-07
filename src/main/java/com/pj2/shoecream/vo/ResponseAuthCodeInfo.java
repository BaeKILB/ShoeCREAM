package com.pj2.shoecream.vo;

import lombok.Data;

@Data
public class ResponseAuthCodeInfo {
	private String code;
	private String scope;
	private String client_info;
	private String state;
}
