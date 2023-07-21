package com.pj2.shoecream.vo;

import java.sql.Date;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.Data;

@Data
public class MemberVO {
	@Size(min = 2, max = 20)
	@NotBlank
	private String mem_id;
	@NotBlank
	private String mem_name;
	@NotBlank
	private String mem_passwd;
	@NotBlank
	private String mem_email;
	@NotBlank
	private Date mem_birthday;
	private	String mem_bir1;
	private	String mem_bir2;
	private	String mem_bir3;
	
//	@NotBlank @Pattern(regexp = "/01[016789]-[^0][0-9]{2,3}-[0-9]{3,4}/",message = "유효한 핸드폰 번호를 입력 해 주세요.")
	private String mem_mtel;
//	@Size(max = 3) 
	private String phone1;//ㅇ
//	@Size(max = 4)
	private String phone2;//ㅇ
//	@Size(max = 4)
	private String phone3;//ㅇ
	
	private String mem_address;
//	@NotBlank(message = "주소를 입력해 주세요")
	private String sample6_address;//하고
	private String sample6_detailAddress;
	private String sample6_extraAddress;
//	@NotBlank(message = "주소를 입력해 주세요")
	private String sample6_postcode;//하고
	private Date mem_sign_date; //now()
	
	private String role; // 권한
}
