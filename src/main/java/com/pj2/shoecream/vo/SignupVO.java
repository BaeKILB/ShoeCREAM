package com.pj2.shoecream.vo;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;
import lombok.Data;

@Data
public class SignupVO { // 혹시 가입할때 여러개의 조건이 달리면 여기서 처리하자
    @Size(min = 2, max = 20, message = "아이디는 2자 이상 20자 이내로 입력해주세요.")
    @NotBlank(message = "아이디를 입력해주세요")
    private String mem_id;

    @NotBlank
    private String mem_passwd;

    @NotBlank
    private String mem_email;

    @NotBlank
    private String mem_name;

    public MemberVO toMemberVO() {
        MemberVO member = new MemberVO();
        member.setMem_id(mem_id);
        member.setMem_passwd(mem_passwd);
        member.setMem_email(mem_email);
        member.setMem_name(mem_name);
        return member;
    }
}

