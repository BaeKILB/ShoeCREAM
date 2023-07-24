package com.pj2.shoecream.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.pj2.shoecream.mapper.MemberMapper;
import com.pj2.shoecream.vo.MemberVO;

@Service
public class PrincipalDetailsService implements UserDetailsService {

    @Autowired
    private MemberMapper memberMapper;
    
    // 패스워드는 알아서 체킹하니깐 신경 ㄴ
    // 리턴이 잘되면 자동으로 세션을 만듬
    @Override
    public UserDetails loadUserByUsername(String mem_id) throws UsernameNotFoundException {
        MemberVO member = memberMapper.findMemberById(mem_id);
        System.out.println("로그인 아이디 오니 ? " + mem_id);
        if (member == null) {
//            throw new UsernameNotFoundException("회원 정보를 찾을 수 없습니다.");
        	return null;
        } else {
        	return new PrincipalDetails(member);
        }

        // 권한 설정
//        List<GrantedAuthority> authorities = new ArrayList<>();
//        authorities.add(new SimpleGrantedAuthority(member.getRole()));
//
//        return new User(member.getMem_id(), member.getMem_passwd(), authorities);
    }
}
