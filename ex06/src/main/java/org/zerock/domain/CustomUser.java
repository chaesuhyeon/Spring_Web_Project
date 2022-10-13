package org.zerock.domain;

import lombok.Getter;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import java.util.Collection;
import java.util.stream.Collectors;

@Getter
public class CustomUser extends User {

    private static final long serialVersionUID = 1L;

    private MemberVO member;

    public CustomUser(String username, String password , Collection<? extends GrantedAuthority> authorities){
        super(username , password , authorities); // CustomUser는 User클래스를 상속하기 때문에 부모 클래스의 생성자를 호출해야만 정상적인 객체를 생성할 수 있음
    }

    public CustomUser(MemberVO vo){
        super(vo.getUserid(), vo.getUserpw() , vo.getAuthList().stream().map(auth-> new SimpleGrantedAuthority(auth.getAuth())).collect(Collectors.toList()));
        this.member = vo;
    }
}
