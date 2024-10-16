package com.project.springboot;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.springboot.dao.IMemberDao;
import com.project.springboot.dto.AdminService;
import com.project.springboot.dto.UserDTO;

@Service
public class UserService {

	@Autowired
	private IMemberDao idao;
	@Autowired
	private PasswordEncoder passwordEncoder;
	@Autowired
	private AdminService admin;
	
	//일반로그인 비밀번호 인코딩
	public int joinDao(UserDTO user) {
		String encodedPassword = passwordEncoder.encode(user.getPass()); // 비밀번호 암호화
        user.setPass(encodedPassword);
		return idao.joinDao(user);
	}
	
	public boolean isUserIdCheck(String id) {
		
		return idao.idCheck(id) == 0;

	}
	
	public UserDTO findByUsername(@Param("id")String id) {
		
		return idao.findByUsername(id);
	};
	
	public UserDTO findBySocailrname(@Param("id")String id, @Param("providerId")String providerId) {
		
		return idao.findBySocailrname(id, providerId);
	};
	
	//권한
	public void updateUserAuth(String id, String authority) {
		Map<String, Object> params = new HashMap<>();
        params.put("id", id);
        params.put("authority", authority);
        
        int rowsAffected = admin.updateUserAuth(params);
        if (rowsAffected == 0) {
            // 처리: 업데이트된 행이 없다는 것은 사용자가 없거나 ID가 잘못된 경우일 수 있음
            throw new RuntimeException("User not found or update failed");
        }
    }
	
	//비활성화 관리
	public void updateEnabled(String id, int enabled) {
		Map<String, Object> params = new HashMap<>();
		params.put("id", id);
		params.put("enabled", enabled);
		
		int rowsAffected = admin.updateEnabled(params);
		if (rowsAffected == 0) {
			// 처리: 업데이트된 행이 없다는 것은 사용자가 없거나 ID가 잘못된 경우일 수 있음
			throw new RuntimeException("User not found or update failed");
		}
	}
	
	//계정 잠금
	public void updateLock(String id, int isLock) {
		Map<String, Object> params = new HashMap<>();
		params.put("id", id);
		params.put("isLock", isLock);
		
		int rowsAffected = admin.updateLock(params);
		if (rowsAffected == 0) {
			// 처리: 업데이트된 행이 없다는 것은 사용자가 없거나 ID가 잘못된 경우일 수 있음
			throw new RuntimeException("User not found or update failed");
		}
	}
	
	public int joinSocial(UserDTO user) {
		return idao.joinSocial(user);
	}
	
	//비밀번호 변경
	@Transactional
    public int  changePassword(String id, String currentPassword, String newPassword) {
		
        // 현재 비밀번호 확인
        String existingPasswordHash = idao.passCheckDao(id);
        
        boolean passwordMatches = passwordEncoder.matches(currentPassword, existingPasswordHash);

        if (!passwordMatches) {
            return 0; // 현재 비밀번호가 틀린 경우
        }

        // 새 비밀번호 인코딩
        String newPasswordHash = passwordEncoder.encode(newPassword);

        // 비밀번호 업데이트
        int rowsAffected = idao.passChangeDao(newPasswordHash, id);
        
        return rowsAffected;
    }
	
	//회원탈퇴처리
	public void deactivateMember(String id) {
        idao.deleteDao(id);
    }


	
	
	@Transactional
    public UserDTO handleUser(String id, String email, String password, String name, OAuth2User oAuth2User) {
        // 사용자 조회
        UserDTO user = idao.findByUsername(id);

        if (user == null) {
            // 새로운 사용자 생성
            String encodedPassword = passwordEncoder.encode(password); // 비밀번호 암호화
            user = UserDTO.builder()
                    .id(id)
                    .pass(encodedPassword) // 암호화된 비밀번호 설정
                    .name(name)
                    .email(email)
                    .authority("ROLE_GUEST") // 기본 권한
                    .enabled(1) // 계정 활성화 상태
                    .build();
            idao.joinDao(user);
        } else {
            // 기존 사용자 로그
        }

        // OAuth2User의 속성에 따라 UserDTO를 업데이트할 수 있습니다
        // 예를 들어, OAuth2User의 추가 정보를 활용할 수 있습니다
        // userEntity = updateUserFromOAuth2User(userEntity, oAuth2User);

        return user;
    }
	
}
