package com.project.springboot.auth;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.springboot.dao.IMemberDao;
import com.project.springboot.dto.UserDTO;

@Service("userDetailsService")
public class AccountDetailService implements UserDetailsService {
	
	@Autowired
    private IMemberDao idao;
	private static final long LOCK_TIME_DURATION = 15 * 60 * 1000; // 15분 동안 계정 잠김
	
	@Override
    public UserDetails loadUserByUsername(@RequestParam("id") String id) throws UsernameNotFoundException {
//		System.out.println("user detail method called");
        UserDTO dto = idao.findByUsername(id);
        
        //계정 잠금 확인
        if (dto != null) {
            long currentTime = System.currentTimeMillis();
            long lockTimeMillis = dto.getLockTime() != null ? dto.getLockTime().getTime() : 0;

            // 계정 잠금 해제 로직
            if (dto.getIsLock() == 0 && (currentTime - lockTimeMillis) > LOCK_TIME_DURATION) {
                // 잠금 해제
                idao.updateUnLock(1, 0, id); // 잠금 해제 및 실패 횟수 리셋
                dto.setIsLock(1);
                dto.setFailCount(0);
                dto.setLockTime(null);
                
            }
            // 사용자 객체 반환
            return new AccountDetails(dto);
        }

        throw new UsernameNotFoundException("아이디나 비밀번호를 확인해주세요");
    }
}


