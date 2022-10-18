package org.zerock.config;

import lombok.extern.log4j.Log4j;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.zerock.security.CustomLoginSuccessHandler;

@Configuration
@EnableWebSecurity // 스프링 MVC와 스프링 시큐리티를 결합하는 용도로 사용
@Log4j
public class SecurityConfig extends WebSecurityConfigurerAdapter { // security-context.xml 대신 하는 설정

	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		log.info("configure................................");

		auth.inMemoryAuthentication()
				.withUser("admin")
				.password("{noop}admin")
				.roles("ADMIN");

		auth.inMemoryAuthentication()
				.withUser("member")
				.password("$2a$10$hVk6v0/RQ70PEvYBfmpZLeMyPCPwMG5AZVoU28y7xG7T/kXfMC50m")
				.roles("MEMBER");
//		auth.inMemoryAuthentication().withUser("member").password("{noop}member").roles("MEMBER");

	}

	@Bean
	public AuthenticationSuccessHandler loginSuccessHandler(){ // 로그인이 성공한 경우의 처리
		return new CustomLoginSuccessHandler();
	}

	@Bean
	public PasswordEncoder passwordEncoder(){
		return new BCryptPasswordEncoder();
	}

	@Override // <security:http> 관련 설정들을 대신
	public void configure(HttpSecurity http) throws Exception {
		http.authorizeRequests()
				.antMatchers("/sample/all").permitAll()
				.antMatchers("/sample/admin").access("hasRole('ROLE_ADMIN')")
				.antMatchers("/sample/member").access("hasRole('ROLE_MEMBER')");

		http.formLogin()
				.loginPage("/customLogin")
				.loginProcessingUrl("/login")
				.successHandler(loginSuccessHandler());

		http.logout()
				.logoutUrl("/customLogout")
				.invalidateHttpSession(true)
				.deleteCookies("remember-me", "JSESSION_ID");
	}


}
