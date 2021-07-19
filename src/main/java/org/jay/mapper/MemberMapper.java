package org.jay.mapper;

import org.jay.domain.UserDTO;
import org.springframework.stereotype.Service;

@Service
public interface MemberMapper {
	// 회원가입
	public void insertMember(UserDTO dto);
	
	// 아이디 중복체크(있으면 1 없으면 0)
	public int idChk(UserDTO dto);
	
	// 비밀번호 확인체크(있으면 1 없으면 0)
	public int pwChk(UserDTO dto);
	
	// 회원정보 불러오기
	public UserDTO readMember(String userid);
	
	//회원정보수정
	public void usermodify(UserDTO dto) throws Exception;
	
	//비밀번호수정
	public void pwmodify(UserDTO dto) throws Exception;
	
	// 권한 테이블에서 회원 정보 삭제
	public int deleteAuth(String userid);
			
	//회원탈퇴
	public void deleteMember(UserDTO dto) throws Exception;
	
}