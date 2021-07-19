package org.jay.service;

import javax.servlet.http.HttpServletResponse;

import org.jay.domain.UserDTO;

public interface LoginService {
	// 아이디 찾기
	public String findID(UserDTO userDTO);
	
	// 비밀번호 찾기(이메일 발송)
	public void sendEmail(UserDTO userdto, String div, String pw) throws Exception;
	
	// 비밀번호 찾기
	public void findPW(HttpServletResponse response, UserDTO userdto) throws Exception;
}
