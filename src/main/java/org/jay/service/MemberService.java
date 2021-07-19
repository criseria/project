package org.jay.service;

import org.jay.domain.UserDTO;

public interface MemberService {
	
	public void insertMember(UserDTO dto);
	
	public int idChk(UserDTO dto);
	
	public UserDTO loginMember(UserDTO dto);
	
	public UserDTO readMember(String userid);
	
	//회원정보 수정
	public void usermodify(UserDTO dto);
	
	// 권한 테이블에서 회원 정보 삭제
	public int deleteAuth(String userid);
	
	//회원정보 삭제
	public void deleteMember(UserDTO dto);
	
	//비밀번호 변경
	public void pwmodify(UserDTO dto);
	
	//비밀번호 db와 맞는지 체크
	public int pwChk(UserDTO dto);
}