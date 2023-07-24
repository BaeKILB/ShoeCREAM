package com.pj2.shoecream.config;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
public class PrincipalDetailsService implements UserDetailsService{

	@Override
	public UserDetails loadUserByUsername(String mem_id) throws UsernameNotFoundException {
		System.out.println("나 실행되냐" + mem_id);
		return null;
	}

}
