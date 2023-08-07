package com.pj2.shoecream.handler;

import java.security.SecureRandom;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

// 핀테크 요청 작업에 사용할 다양한 값을 생성하는 클래스 정의
// => 다른 클래스에서 @Autowired 어노테이션으로 관리하기 위해 스프링 Bean 으로 등록 
//    (@Component 어노테이션 적용)
@Component
public class BankValueGenerator {
	@Value("${client_use_code}")
	private String client_use_code; // 이용기관코드
	
	// 거래고유번호 자동 생성 - getBankTranId() 메서드 정의
	// 형식 : 이용기관코드(10자리) + 생성주체구분코드("U")*+ 이용기관 부여번호(9자리)
	//        예) F123456789U4BC34239Z
	//  => 생성주체구분코드는 U 고정, 이용기관부여번호 9자리는 GenerateRandomCode - getRandomCode() 재사용
	public String getBankTranId() {
		 String bank_tran_id = "";
		 
		 // 이용기관부여번호를 정수형 난수로만 생성할 경우
//		 SecureRandom sr = new SecureRandom();
//		 int rNum = sr.nextInt(1000000000); // 0 ~ 999999999
		 // 단, 9자리보다 적은 난수는 9자리 난수 문자열로 활용이 불가능하므로 문자열 처리 작업 추가 필요
		 // => 추출된 난수를 String 클래스의 format() 메서드를 통해 9자리 문자열로 고정하되
		 //    부족한 자릿수는 0으로 채우기
//		 String strNum = String.format("%09d", rNum);
		 // ---------------------------------------------------------------------------------------------
		 // GenerateRandomCode - getRandomCode() 메서드 재사용 => 파라미터로 난수 길이 전달
		 bank_tran_id = client_use_code + "U" + GenerateRandomCode.getRandomCode(9).toUpperCase();
		 
		 return bank_tran_id;
	}
	
	// 요청일시(거래시간 등) 자동 생성 - getTranDTime() 메서드 정의
	// => 현재 시스템의 날짜 및 시각을 기준으로 값 설정(yyyyMMddHHmmss 형식으로 변경 필요)
	// => java.time.LocalDateTime 클래스 활용
	public String getTranDTime() {
		LocalDateTime localDateTime = LocalDateTime.now(); // 시스템의 현재 날짜 및 시각 정보 리턴
		
		// java.time.DateTimeFormatter 클래스를 활용하여 포맷 변경
		DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyyMMddHHmmss");
		
		// LocalDateTime 객체에 포맷을 적용하여 문자열로 리턴되는 날짜 및 시각을 리턴
		return localDateTime.format(dateTimeFormatter);
	}
	
}
















