package com.pj2.shoecream.vo;

import java.sql.Date;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import lombok.Data;

@Data
public class MemberVO {
//	@Unique(field = "mem_id", message = "이미 사용 중인 ID입니다.")
    @Size(min = 2, max = 20, message = "아이디는 2자 이상 20자 이내로 입력해주세요.")
    @NotBlank(message = "아이디를 입력해 주세요")
	private String mem_id;
    @Size(min = 2, max = 5, message = "이름은 2자 이상 5자 이내로 입력해주세요")
//    @Unique(field = "mem_name", message = "이미 사용 중인 이름입니다.")
	@NotBlank
	private String mem_name;
	@Size(min = 8, message = "비밀번호는 최소 8자 이상이어야 합니다.")
	@NotBlank(message = "비밀번호를 입력해주세요.") @Pattern(regexp = "^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,20}$" ,message = "비밀번호는 영문, 숫자, 특수문자 포함 8~20글자 이상 입력해주세요.")
	private String mem_passwd;
//	@Unique(field = "mem_email", message = "이미 사용 중인 이메일입니다.")
	@NotBlank(message = "이메일을 입력해주세요.")
	private String mem_email;
	
//    @NotNull(message = "생년월일을 입력해 주세요")
	private Date mem_birthday;
	private	String mem_bir1;
	private	String mem_bir2;
	private	String mem_bir3;
	
//	@NotBlank @Pattern(regexp = "/01[016789]-[^0][0-9]{2,3}-[0-9]{3,4}/",message = "유효한 핸드폰 번호를 입력 해 주세요.")
//    @Unique(field = "mem_mtel", message = "이미 사용 중인 전화번호입니다.")
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
