package org.jay.service;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.mail.HtmlEmail;
import org.jay.domain.UserDTO;
import org.jay.mapper.LoginMapper;
import org.jay.mapper.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class LoginServiceImpl implements LoginService{

	@Autowired
	LoginMapper loginMapper;
	
	@Autowired
	UserMapper userMapper;
	
	@Autowired
	PasswordEncoder pwencoder;
	
	// 이메일 찾기
	@Override
	public String findID(UserDTO userDTO) {
		return loginMapper.findID(userDTO);
	}

	// 비밀번호 찾기(이메일 발송)
	@Override
	public void sendEmail(UserDTO userdto, String div, String pw) throws Exception {
		// Mail Server 설정
		String charSet = "utf-8";
		String hostSMTP = "smtp.gmail.com";
		String hostSMTPid = "testemailsender0908@gmail.com";			// 보내는 사람 이메일 주소
		String hostSMTPpwd = "testemailsender12";						// 보내는 사람 이메일 비번
		
		// 보내는 사람 Email, 제목, 내용
		String fromEmail = "admin@travelmaker.co.kr";	// 보내는 사람 이메일 주소 (받는 사람 이메일에 표시됨)
		String fromName = "TravelMaker_관리자";			// 보내는 사람 이름
		String subject = "";
		String msg = "";
		
		if(div.equals("findPW")) {
			subject = "TravelMaker 임시 비밀번호 입니다.";
			msg += "<div align='center' style='border:1px solid black; font-family:verdana'>";
			msg += "<h3 style='color:blue;'>";
			msg += userdto.getUserid() + "님의 임시 비밀번호 입니다. 비밀번호를 변경하여 사용하세요.</h3>";
			msg += "<p>임시 비밀번호 : ";
			msg += pw + "</p></div>";	//userdto.getUserpw()
		}
		
		// 받는 사람 email 주소
		String mail = userdto.getEmail();
		try {
				HtmlEmail email = new HtmlEmail();
				email.setDebug(true);
				email.setCharset(charSet);
				email.setSSL(true);
				email.setHostName(hostSMTP);
				email.setSmtpPort(465);
				email.setAuthentication(hostSMTPid, hostSMTPpwd);
				email.setTLS(true);
				email.addTo(mail, charSet);
				email.setFrom(fromEmail, fromName, charSet);
				email.setSubject(subject);
				email.setHtmlMsg(msg);
				email.send();
		} catch (Exception e) {
			System.out.println("메일 발송 실패 : " + e);
		}
	}
	
	// 비밀번호 찾기
	@Override
	public void findPW(HttpServletResponse response, UserDTO userdto) throws Exception {
		response.setContentType("text/html;charset=utf-8");
		UserDTO check = userMapper.read(userdto.getUserid());
		PrintWriter out = response.getWriter();
		
		// 가입된 아이디가 없는 경우
		if(!userdto.getUserid().equals(check.getUserid())) {
			out.print("등록되지 않은 아이디입니다.");
			out.close();
		}
		
		// 가입된 이메일이 없는 경우
		else if(!userdto.getEmail().equals(check.getEmail())) {
			out.print("등록되지 않은 이메일입니다.");
			out.close();
		}else {
			// 임시 비밀번호 생성
			String pw = "";
			for(int i = 0; i < 6; i++) {
				pw += (char)((Math.random() * 26) + 97);
			}
			// 새로 생성한 임시 비밀번호(암호화 전)
			log.warn(pw);
			
			String encodedPW = pwencoder.encode(pw);
			
			// 암호화 후 임시 비밀번호
			log.warn(encodedPW);
			
			// 암호화 전 후의 비밀번호 두개가 매칭되는지 확인
			log.warn(pwencoder.matches(pw, encodedPW));

			userdto.setUserpw(encodedPW);
			
			// 비밀번호 변경
			loginMapper.updatePW(userdto);
			
			// 비밀번호 변경 메일 발송
			sendEmail(userdto, "findPW", pw);
			
			out.print("이메일로 임시 비밀번호를 발송하였습니다.");
			out.close();
		}
	}
}
