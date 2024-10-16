package com.project.springboot.dao;

import java.sql.Timestamp;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.project.springboot.dto.ParameterDTO;
import com.project.springboot.dto.UserDTO;

@Mapper
public interface IMemberDao {
	
	//일반로그인 회원가입
	int joinDao(UserDTO user);
	
	//소셜로그인 회원가입
	int joinSocial(UserDTO user);

	//아이디중복체크
	int idCheck(String id);
	
	//로그인 등 아이디찾기
	UserDTO findByUsername(@Param("id")String id);
	
	//마이페이지 소셜로그인 일반로그인 구분하여 찾기용
	UserDTO findBySocailrname(@Param("id")String id, @Param("providerId")String providerId);
	
	//일반로그인 마이페이지수정 
	public int editDao(@Param("name") String name, @Param("phoneNum") String phoneNum,
			@Param("email") String email, @Param("postcode")String postcode,
			@Param("address") String address, @Param("detailaddress") String deailaddress, @Param("id") String id);
	
	//회원탈퇴
	void deleteDao(String id);
	
	//소셜로그인 정보수정
	public int socialeditDao(@Param("name") String name, @Param("phoneNum") String phoneNum,
			@Param("email") String email, @Param("postcode")String postcode,
			@Param("address") String address, @Param("detailaddress") String deailaddress, @Param("providerId") String providerId);
	
	//로그인실패카운트
	public void updateFailCount(@Param("failCount")int failCount, @Param("id")String id);
	
	//계정 잠금할 때
	public void updateUserLockStatus(@Param("isLock")int isLock, @Param("failCount")int failCount, 
									@Param("lockTime")Timestamp lockTime, @Param("id")String id);
	
	//실패 카운트가 5번 이하일때 로그인 성공시 리셋
	public void updateCountReset(String id);
	
	//계정 잠금 풀때
	public void updateUnLock(@Param("isLock")int isLock, @Param("failCount")int failCount, @Param("id")String id);
	
	//관리자페이지 회원목록 카운트용
	public int getTotalCount(ParameterDTO pDto);
	
	//마이페이지 비밀번호 확인
	String passCheckDao(String id);
	
	//마이페이지 비밀번호 수정
	int passChangeDao(@Param("pass")String pass, @Param("id")String id);
 	
}
