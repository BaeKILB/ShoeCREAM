package com.pj2.shoecream.vo;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.Data;

@Data
public class SignupVO {
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

