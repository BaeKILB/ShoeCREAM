package com.pj2.shoecream.vo;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import lombok.Data;

@Data
public class MemberUpdatePasswdVO {
	
//    @Pattern(regexp = "^(?=.*[a-zA-Z])(?=.*[0-9]).{8,20}$" ,message = "비밀번호는 8~20글자 이상 입력해주세요.")
//    @Pattern(regexp = "^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,20}$" ,message = "비밀번호는 영문, 숫자, 특수문자 포함 8~20글자 이상 입력해주세요.")
	private String mem_id;
	
	@Size(min = 8, max = 20, message = "비밀번호는 8자 이상 20자 이내로 입력해주세요.")
    @NotBlank(message = "비밀번호를 입력해주세요.")
	private String mem_passwd;
	@Size(min = 8, max = 20, message = "비밀번호는 8자 이상 20자 이내로 입력해주세요.")
	@Pattern(regexp = "^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,20}$" ,message = "비밀번호는 영문, 숫자, 특수문자 포함 8~20글자 이상 입력해주세요.")
    private String newPasswd1;
}
