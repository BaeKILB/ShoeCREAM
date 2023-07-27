package com.pj2.shoecream.vo;

import java.sql.Date;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import com.pj2.shoecream.valid.ValidNewPasswd;
import com.pj2.shoecream.valid.ValidNonConflictId;

import lombok.Data;

@Data
public class MemberVO {
	
	// 회원 항목 추가
	private int mem_idx;
	
	@ValidNonConflictId // 아이디 중복 검사
    @Size(min = 2, max = 20, message = "아이디는 2자 이상 20자 이내로 입력해주세요.")
    @NotBlank(message = "아이디를 입력해 주세요")
	private String mem_id;
    
    @Size(min = 2, max = 5, message = "이름은 2자 이상 5자 이내로 입력해주세요")
	@NotBlank
	private String mem_name;
    
    @Size(min = 2, max = 10, message = "별명은 2자 이상 10자 이내로 입력해주세요")
    private String mem_nickname;
    
    @Pattern(regexp = "^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,20}$" ,message = "비밀번호는 영문, 숫자, 특수문자 포함 8~20글자 이상 입력해주세요.")
	@Size(min = 8, max = 20, message = "비밀번호는 8자 이상 20자 이내로 입력해주세요.")
    @NotBlank(message = "비밀번호를 입력해주세요.")
	private String mem_passwd;
//	@Size(min = 8, max = 20, message = "비밀번호는 8자 이상 20자 이내로 입력해주세요.")
//	@Pattern(regexp = "^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,20}$" ,message = "비밀번호는 영문, 숫자, 특수문자 포함 8~20글자 이상 입력해주세요.")
    @ValidNewPasswd
    private String newPasswd1;
//	-------------------------------------------------
//	@NotBlank(message = "주소를 입력해 주세요")
	private String mem_address;
	private String sample6_address;//하고
	private String sample6_detailAddress;
	private String sample6_extraAddress;
	private String sample6_postcode;//하고
//	-------------------------------------------------
	@Email(message = "유효한 이메일 주소를 입력해주세요.")
	@NotBlank
	private String mem_email;
//	-------------------------------------------------
//	@ValidNotNullDate
//	@Past
	private Date mem_birthday;
	private	String mem_bir1;
	private	String mem_bir2;
	private	String mem_bir3;
//	-------------------------------------------------
	private String mem_interest;
//	-------------------------------------------------
//	@NotBlank
//	@Pattern(regexp = "/01[016789]-[^0][0-9]{2,3}-[0-9]{3,4}/",message = "유효한 핸드폰 번호를 입력 해 주세요.")
	@Pattern(regexp = "^01[016789]-\\d{3,4}-\\d{3,4}$", message = "유효한 핸드폰 번호를 입력 해 주세요.")
	private String mem_mtel;
	@Size(max = 3) 
	@NotBlank
	private String phone1;//ㅇ
	@Size(max = 4)
	@NotBlank
	private String phone2;//ㅇ
	@Size(max = 4)
	@NotBlank
	private String phone3;//ㅇ
//	-------------------------------------------------
	private String role; // 권한
	private String mem_account_auth;
	private String mem_status;
	private String mem_rank;
	private int mem_point;
	private int charge_point;
	private int mem_balance;
	private Date mem_sign_date; //now()
}
