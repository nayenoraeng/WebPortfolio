package com.project.springboot.email;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.project.springboot.dto.UserDTO;

@Mapper
public interface emailMapper {

	UserDTO findMemberId(@Param("name")String name, @Param("email")String email);
	
	Integer findPwCheck(@Param("id")String id, @Param("email")String email);
	
	void updatePass(@Param("id")String id, @Param("email")String email, @Param("pass")String pass)throws Exception;
}
