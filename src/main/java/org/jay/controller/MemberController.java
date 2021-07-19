package org.jay.controller;


import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.jay.domain.UserDTO;
import org.jay.service.MemberService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.Setter;


@Controller
@RequestMapping(value = "/member/*")
public class MemberController {
	//3-1. 서비스 처리 객체를 주입(DI)
	@Inject
	private MemberService service;
	
	@Setter(onMethod_ = @Autowired)
	private PasswordEncoder pwencoder;
	
	private static final Logger l = LoggerFactory.getLogger(MemberController.class);
	
	
	@RequestMapping(value = "/insert", method = RequestMethod.GET)
	//value="/member/insert"에서 member를 빼도 됨
	public String insertGET() throws Exception {
		l.info("C: 회원가입 입력페이지 GET");
		return "/member/insertMember";
	}
	
	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	//value="/member/insertPro"에서 member를 빼도 됨
	public String insertPOST(UserDTO vo) throws Exception{
		
		//1. 한글처리 : request객체가 없다 => web.xml에서 filter태그로 인코딩해야한다.
		
		//2. 전달된 파라미터 받기
		//request.getParameter라는 내장객체가 없다. 따라서 메서드의 매개변수를 통해 가져올 수 있다.
		//l.info("C: "+ request.getParameter()); 에러발생
		l.info("C: "+ vo);
		
		// 비밀번호 암호화
		String pw = pwencoder.encode(vo.getUserpw());
		vo.setUserpw(pw);
		
		//3. 서비스객체 생성(직접생성안하고 의존주입)
		//3-2. 서비스객체호출
		service.insertMember(vo);		
		l.info("C: 회원가입 처리페이지 POST");
		
		
		//4. 로그인페이지로 이동(주소줄과 view페이지 동시에 insert->login 변경되어야함)
		return "redirect:/login/customLogin";
	}
	
	// 아이디 중복 체크
	@ResponseBody
	@RequestMapping(value="/idChk", method = RequestMethod.POST)
	public int idChk(UserDTO dto) throws Exception {
		int result = service.idChk(dto);
		return result;
	}
}