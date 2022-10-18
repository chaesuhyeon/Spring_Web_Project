package org.zerock.config;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.authentication.rememberme.JdbcTokenRepositoryImpl;
import org.springframework.security.web.authentication.rememberme.PersistentTokenRepository;
import org.zerock.security.CustomLoginSuccessHandler;
import org.zerock.security.CustomUserDetailsService;

import javax.sql.DataSource;

@Configuration
@EnableWebSecurity // 스프링 MVC와 스프링 시큐리티를 결합하는 용도로 사용
@Log4j
public class SecurityConfig extends WebSecurityConfigurerAdapter { // security-context.xml 대신 하는 설정

	@Setter(onMethod_ = @Autowired)
	private DataSource dataSource;

//	@Override
//	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
//		log.info("configure................................");
//
//		auth.inMemoryAuthentication()
//				.withUser("admin")
//				.password("{noop}admin")
//				.roles("ADMIN");
//
//		auth.inMemoryAuthentication()
//				.withUser("member")
//				.password("$2a$10$hVk6v0/RQ70PEvYBfmpZLeMyPCPwMG5AZVoU28y7xG7T/kXfMC50m")
//				.roles("MEMBER");
////		auth.inMemoryAuthentication().withUser("member").password("{noop}member").roles("MEMBER");
//
//	}

//	@Override // JDBC를 이용하는 Java 설정
//	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
//		log.info("configure JDBC ..............................");
//
//		String queryUser = "select userid, userpw, enabled from tbl_member where userid = ? ";
//		String queryDetails = "select userid, auth from tbl_member_auth where userid = ?";
//
//		auth.jdbcAuthentication()
//				.dataSource(dataSource)
//				.passwordEncoder(passwordEncoder())
//				.usersByUsernameQuery(queryUser)
//				.authoritiesByUsernameQuery(queryDetails);
//	}

	@Override // Custom UserDetailsService
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		auth.userDetailsService(customUserService()).passwordEncoder(passwordEncoder());
	}

	@Bean
	public AuthenticationSuccessHandler loginSuccessHandler(){ // 로그인이 성공한 경우의 처리
		return new CustomLoginSuccessHandler();
	}

	@Bean
	public UserDetailsService customUserService(){
		return new CustomUserDetailsService();
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

		http.rememberMe()
				.key("zerock")
				.tokenRepository(persistentTokenRepository()).tokenValiditySeconds(604800);
	}

	@Bean
	public PasswordEncoder passwordEncoder(){
		return new BCryptPasswordEncoder();
	}

	@Bean // remember-me 기능 구현시 필요
	public PersistentTokenRepository persistentTokenRepository(){
		JdbcTokenRepositoryImpl repo = new JdbcTokenRepositoryImpl();
		repo.setDataSource(dataSource);
		return repo;
	}

}
