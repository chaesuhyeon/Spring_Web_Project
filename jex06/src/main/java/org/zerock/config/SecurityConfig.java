package org.zerock.config;

import lombok.extern.log4j.Log4j;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;

@Configuration
@EnableWebSecurity // 스프링 MVC와 스프링 시큐리티를 결합하는 용도로 사용
@Log4j
public class SecurityConfig extends WebSecurityConfigurerAdapter { // security-context.xml 대신 하는 설정

	@Override // <security:http> 관련 설정들을 대신
	public void configure(HttpSecurity http) throws Exception {
		http.authorizeRequests()
				.antMatchers("/sample/all").permitAll()
				.antMatchers("/sample/admin").access("hasRole('ROLE_ADMIN')")
				.antMatchers("/sample/member").access("hasRole('ROLE_MEMBER')");
	}

}
