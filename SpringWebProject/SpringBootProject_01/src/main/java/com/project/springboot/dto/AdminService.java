package com.project.springboot.dto;


import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface AdminService {

//	public List<AdminMemberDTO> select(AdminMemberDTO adminMemberDTO);
	
	public AdminMemberDTO selectOne(@Param("id") String id);
	
	public AdminMemberDTO selectOneSocial(@Param("providerId") String providerId);
	
	public int updateUserAuth(Map<String, Object> params);
	
	public int updateEnabled(Map<String, Object> params);
	
	public int updateLock(Map<String, Object> params);

	
	public List<AdminMemberDTO> userListPage(ParameterDTO parameterDTO);
	//일반
	public List<AdminMemberDTO> localMemList(ParameterDTO parameterDTO);
	public int getTotalCountLocal(ParameterDTO pDto);
	//소셜
	public List<AdminMemberDTO> SocialMemList(ParameterDTO parameterDTO);
	public int getTotalCountSocial(ParameterDTO pDto);
	//잠금
	public List<AdminMemberDTO> LockMemList(ParameterDTO parameterDTO);
	public int getTotalCountLock(ParameterDTO pDto);
	//비활성화
	public List<AdminMemberDTO> EnabledMemList(ParameterDTO parameterDTO);
	public int getTotalCountEnabled(ParameterDTO pDto);
}
