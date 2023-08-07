package com.pj2.shoecream.handler;

import org.apache.commons.lang3.RandomStringUtils;

// 특정 난수를 생성하는 클래스 정의
public class GenerateRandomCode {
	// 지정한 길이에 해당하는 난수 생성
	// => 파라미터로 전달받은 길이에 맞는 영문자, 숫자 조합한 난수 생성 후 리턴하는 getRandomCode() 메서드 정의
	// => RandomStringUtils 클래스 활용(commons-lang3-3.12.0.jar 라이브러리 필요)
	// => 공통 메서드로 활용(메모리에 상주)하기 위해 static 메서드로 선언
	public static String getRandomCode(int length) {
		// RandomStringUtils 클래스의 static 메서드 randomAlphanumeric() 메서드 활용(숫자, 문자 조합 난수 생성)
		// => 생성한 난수 리턴
		return RandomStringUtils.randomAlphanumeric(length); // 전달받은 length 에 해당하는 길이의 난수 리턴
	}
}
















