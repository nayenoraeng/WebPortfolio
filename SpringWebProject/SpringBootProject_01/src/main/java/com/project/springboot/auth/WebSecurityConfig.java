package com.project.springboot.auth;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.web.servlet.ServletListenerRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.core.session.SessionRegistry;
import org.springframework.security.core.session.SessionRegistryImpl;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.firewall.DefaultHttpFirewall;
import org.springframework.security.web.firewall.HttpFirewall;
import org.springframework.security.web.session.HttpSessionEventPublisher;

import com.project.springboot.oauth2.CustomOAuth2UserService;

import jakarta.servlet.DispatcherType;
import lombok.RequiredArgsConstructor;
@RequiredArgsConstructor
@Configuration
@EnableWebSecurity
public class WebSecurityConfig {
	
	private final AuthenticationFailureHandler myAuthFailureHandler;
	private final AuthenticationSuccessHandler myAuthSucceessHandler;
	private final CustomSessionExpiredStrategy customSessionExpiredStrategy;
	private final CustomOAuth2UserService customOAuth2UserService;

	@Value("${spring.security.debug:false}")
	boolean securityDebug;
	
	@Bean
	public PasswordEncoder getPasswordEncoder() {
		return new BCryptPasswordEncoder();
	}
	
	
	
	@Bean
	protected SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
		http.csrf((csrf) -> csrf.disable())
			.cors((cors) -> cors.disable())
	    	.authorizeHttpRequests(request -> request
	    		.dispatcherTypeMatchers(DispatcherType.FORWARD).permitAll()
	    		.requestMatchers("/").permitAll()
	    		.requestMatchers("/guest/joinform").permitAll()
	    		.requestMatchers("/error").permitAll()
	    		.requestMatchers("/static/**").permitAll()
	    		.requestMatchers("/assets/**", "/carousel/**","/css/**", "/js/**", "/img/**","/images/**", "/files/**").permitAll()
	            .requestMatchers("/guest/**", "/layout/**").permitAll()  // 모두에게 허용.
	            .requestMatchers("/security/**").permitAll() 
	            .requestMatchers("/member/**").hasAnyRole("USER", "ADMIN")
	            .requestMatchers("/admin/**").hasAnyRole("ADMIN")

	            .anyRequest().authenticated() // 어떠한 요청이라도 인증 필요 없음 ( anonymous() )  //authenticated()
	        );
    
		http.formLogin((formLogin) -> formLogin
				.loginPage("/security/loginform")
				.permitAll()
				.loginProcessingUrl("/security/login")
				.successHandler(myAuthSucceessHandler)
		        .failureHandler(myAuthFailureHandler)
		        .usernameParameter("id")
		        .passwordParameter("pass")
		        .permitAll()
				);
		
		http.logout((logout) -> logout
			.logoutUrl("/logout")
			.logoutSuccessUrl("/")
			.invalidateHttpSession(true) // 세션 무효화
            .deleteCookies("JSESSIONID")
			.permitAll());
		
		//권한 요청 실패시 페이지 처리
		http.exceptionHandling((expHandling) -> expHandling
				.accessDeniedPage("/denied"));
		
		http.headers((headers) -> headers
	    		.frameOptions(frameOptions -> frameOptions.disable())
	    		);
		
		//소셜로그인
	    http.oauth2Login((oauth) -> oauth
	    		.userInfoEndpoint(endPoint -> endPoint
	    			.userService(customOAuth2UserService)
	    			)
	    		);
  
	    //중복로그인 방지
	    http.sessionManagement((sessionManagement)-> sessionManagement
	    		.sessionFixation().changeSessionId() //세션고정 방식 
	    		.maximumSessions(1) //세션 허용수 
	    		.expiredSessionStrategy(customSessionExpiredStrategy)
	    		.maxSessionsPreventsLogin(false) //허용수를 넘길시 기존로그인 사용자 로그아웃 (true 는 현재 요청을 처리)
	    		.expiredUrl("/security/loginform")//세션 만료시 넘어갈 홈페이지
	    		.sessionRegistry(sessionRegistry()) //로그인 한 사용자 기억
	    		);
	    
    return http.build(); 
		
	}
	
	
	public void configure(WebSecurity web) throws Exception {
	    web.httpFirewall(defaultHttpFirewall());
//	    web.ignoring().requestMatchers(PathRequest.toStaticResources().atCommonLocations());
	}
	 
	//매핑 중 슬래시가 두개 이상들어갔을 때 처리해주는 것.
	@Bean
	public HttpFirewall defaultHttpFirewall() {
	    return new DefaultHttpFirewall();
	}
	
	
	@Bean
	public SessionRegistry sessionRegistry() {
	    return new SessionRegistryImpl();
	}
	
	// HttpSession 이벤트를 Spring 이벤트로 변환
	@Bean
	public static ServletListenerRegistrationBean<HttpSessionEventPublisher> httpSessionEventPublisher() {
	    return new ServletListenerRegistrationBean<>(new HttpSessionEventPublisher());
	}
	
//    @Bean
//    public WebSecurityCustomizer webSecurityCustomizer() {
//        return (web) -> web.debug(securityDebug);
//    }
    
}
