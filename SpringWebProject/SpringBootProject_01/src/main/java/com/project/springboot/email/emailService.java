package com.project.springboot.email;

import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import com.project.springboot.dto.UserDTO;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class emailService {
	@Autowired
	private emailMapper emailMapper;
	@Autowired
	private final JavaMailSender javaMailSender;
	@Autowired
	private final RedisUtil redisUtil;

	
	private String createdCode() {  
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
	
    public MimeMessage createEmail(String email) {
    	String code = createdCode();
        MimeMessage message = javaMailSender.createMimeMessage();

        try {
            message.setFrom("yenoraeng_42@naver.com");
            message.setRecipients(MimeMessage.RecipientType.TO, email);
            message.setSubject("안녕하세요 스마일로드 인증번호 이메일입니다.");
            String body = "";
            body += "<h3>" + "요청하신 아이디 찾기 인증 번호입니다." + "</h3>";
            body += "<h1>" + code + "</h1>";
            body += "<h3>" + "감사합니다." + "</h3>";
            message.setText(body,"UTF-8", "html");
            
            redisUtil.setDataExpire(email, code, 60 * 30L);
            
        } catch (MessagingException e) {
            e.printStackTrace();
        }

        return message;
    }

    public void sendMail(String toEmail) throws MessagingException {
    	 if (redisUtil.existData(toEmail)) {  
    	        redisUtil.deleteData(toEmail);  
    	    }  
    	  
    	    MimeMessage emailForm = createEmail(toEmail);  
    	  
    	    javaMailSender.send(emailForm);  
    }
    
    public Boolean verifyEmailCode(String email, String code) {  
        String codeFoundByEmail = redisUtil.getData(email);  
        if (codeFoundByEmail == null) {  
            return false;  
        }  
        return codeFoundByEmail.equals(code);  
    }
    
    
    public UserDTO findMemberId(String name, String email) {
        if (emailMapper == null) {
            throw new IllegalStateException("emailMapper is not initialized");
        }
        return emailMapper.findMemberId(name, email);
    }
    


}
