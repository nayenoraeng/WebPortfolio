package com.project.springboot.email;

import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class pwdEmailService {
	
	@Autowired
	private emailMapper emailMapper;
	@Autowired
    private final BCryptPasswordEncoder passwordEncoder;
	@Autowired
	private final JavaMailSender javaMailSender;
	@Autowired
	private final RedisUtil redisUtil;

	
	private String createdPwCode() {  
		 int leftLimit = 48; // number '0'  
		    int rightLimit = 122; // alphabet 'z'  
		    int targetStringLength = 6;  
		    Random random = new Random();  
		  
		    return random.ints(leftLimit, rightLimit + 1)  
		            .filter(i -> (i <=57 || i >=65) && (i <= 90 || i>= 97))  
		            .limit(targetStringLength)  
		            .collect(StringBuilder::new, StringBuilder::appendCodePoint, StringBuilder::append)  
		            .toString();  
	}
	
	 public MimeMessage createPwEmail(String email, String verificationCode) {
	    	 MimeMessage message = javaMailSender.createMimeMessage();
	        
	        try {
	            message.setFrom("yenoraeng_42@naver.com");
	            message.setRecipients(MimeMessage.RecipientType.TO, email);
	            message.setSubject("안녕하세요 스마일로드 인증번호 이메일입니다.");
	            String body = "";
	            body += "<h3>" + "비밀번호 찾기를 위한 인증번호 입니다." + "</h3>";
	            body += "<h1>" + "인증번호 : " + verificationCode + "</h1>";
	            body += "<h3>" + "인증번호 인증 후 비밀번호를 변경해주세요." + "</h3>";
	            body += "<h3>" + "감사합니다." + "</h3>";
	            message.setText(body,"UTF-8", "html");
	            
	            redisUtil.setDataExpire(email, verificationCode, 60 * 30L);
	            
	            
	        } catch (MessagingException e) {
	            e.printStackTrace();
	        }

	        return message;
	    }
	 
	    public void sendEmail(String toEmail,  String verificationCode) throws MessagingException {
	    	 if (redisUtil.existData(toEmail)) {  
	    	        redisUtil.deleteData(toEmail);  
	    	    }  
	    	  
	    	    MimeMessage emailForm = createPwEmail(toEmail, verificationCode);  
	    	  
	    	    javaMailSender.send(emailForm);  
	    }
	 
	    @Transactional
	    public String createTemporaryPassword(String id, String email) {
	        String verificationCode = createdPwCode(); // 임시 비밀번호 생성

	        try {
	            Integer userCount = emailMapper.findPwCheck(id, email);
	            if (userCount == null || userCount == 0) {
	                throw new IllegalStateException("User not found for the given id and email");
	            }
	            
//	            sendEmail(email, pwcode);

	        } catch (Exception e) {
	            e.printStackTrace();
	            throw new RuntimeException("Error while creating or updating the temporary password", e);
	        }

	        return verificationCode;
	    }
	 
	    @Transactional
	    public boolean verifyAndUpdatePassword(String id, String email, String verificationCode, String newPassword) throws Exception {
	        // Redis에서 인증번호 검증
	        String storedCode = redisUtil.getData(email); // 인증번호 가져오기
	        if (storedCode == null || !storedCode.equals(verificationCode)) {
	            return false; // 인증번호가 일치하지 않거나 존재하지 않음
	        }
	        
	        // 인증번호가 유효할 경우 비밀번호 변경
	        String encodedPassword = passwordEncoder.encode(newPassword);
	        emailMapper.updatePass(id, email, encodedPassword);
	        
	        // Redis에서 인증번호 삭제
	        redisUtil.deleteData(email);
	        
	        return true;
	    }

}
