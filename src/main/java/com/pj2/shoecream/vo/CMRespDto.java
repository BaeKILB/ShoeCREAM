package com.pj2.shoecream.vo;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class CMRespDto<T> { // 응답 공통 Dto
	private int code; // 1(성공) , -1(실패)
	private String message;
	private T data; // 제네릭 타입에 다양한 값들을 넣기 위해 
	
}
