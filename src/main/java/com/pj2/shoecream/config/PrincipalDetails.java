package com.pj2.shoecream.config;

import java.util.ArrayList;
import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import com.pj2.shoecream.vo.MemberVO;

import lombok.Data;

@Data
public class PrincipalDetails implements UserDetails{

	private static final long serialVersionUID = 1L;
	
	private MemberVO member;
	
	public PrincipalDetails(MemberVO member) {
		this.member = member;
	}
	
//    public MemberVO getMember(MemberVO member) {
//        return member;
//    }
	
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		
		Collection<GrantedAuthority> collector = new ArrayList<>();
		collector.add(()-> { return member.getRole();}); // 코드가 더러워져서 람다식으로 써봄
		return collector;
	}

	@Override
	public String getPassword() {
		return member.getMem_passwd();
	}

	@Override
	public String getUsername() {
		return member.getMem_id();
	}
	
	// 계정이 만료되지 않았는지 리턴한다. (true: 만료안됨)
	@Override
	public boolean isAccountNonExpired() {
		return true;
	}
	
	// 계정이 잠겨있지 않았는지 리턴한다. (true: 잠기지 않음)
	@Override
	public boolean isAccountNonLocked() {
		return true;
	}
	
	// 비밀번호가 만료되지 않았는지 리턴한다. (true: 만료안됨)
	@Override
	public boolean isCredentialsNonExpired() {
		return true;
	}
	
	// 계정이 활성화 (사용가능) 인지 리턴한다.( true : 활성화)
	@Override
	public boolean isEnabled() {
		return true;
	}

}
