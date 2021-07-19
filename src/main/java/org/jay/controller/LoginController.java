package org.jay.controller;

import java.security.Principal;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jay.domain.UserDTO;
import org.jay.service.LoginService;
import org.jay.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@AllArgsConstructor
@Controller
@Log4j
@RequestMapping("/login/*")
public class LoginController {
	
	@Setter(onMethod_ = @Autowired)
	private PasswordEncoder pwencoder;
	
	@Autowired
	LoginService loginService;
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	BCryptPasswordEncoder pwEncoder = new  BCryptPasswordEncoder();
	
	// 로그인 페이지
	@GetMapping("/customLogin")
	public void login(String error, String logout, Model model) {
		log.info("------Go Login Page------");
		log.info("error : " + error);
		log.info("logout : " + logout);
		
		if(error != null) {
			model.addAttribute("error", "잘못된 아이디 또는 비밀번호입니다.");
		}
		
		if(logout != null) {
			model.addAttribute("logout", "Logout!!!");
		}
	}
	
	// 아이디 찾기 입력 정보 이동
	@GetMapping("/goFindID")
	public void goFindID() {
		log.info("------ GoFindID Page------");
	}

	// 아이디 찾기 결과 이동
	@RequestMapping(value = "/login/findID", method = {RequestMethod.POST})
	public void findID(@RequestParam("username") String username, @RequestParam("email") String email, Model model) {
		log.info("------ findID Page------");
		log.info("username : " + username);
		log.info("email : " + email);
		
		// 컨트롤러에서 서비스로 객체를 넘길 때는 하나만 넘긴다. 둘 이상이면 오류난다
		UserDTO userDTO = new UserDTO();
		userDTO.setUsername(username);
		userDTO.setEmail(email);
		
		String userid = loginService.findID(userDTO);
		
		log.info("user id : " + userid);
		
		model.addAttribute("userid", userid);
	}
	
	// 비밀번호 찾기(GET으로 비밀번호 찾기 페이지 접근, 실제 비밀번호 찾을 때는 POST로 접근)
	@RequestMapping(value = "/login/findPW", method = {RequestMethod.GET})
	public void findPWGET() throws Exception{
		log.info("----- 비밀번호 찾기 페이지로 이동 -----");
	}
	
	// 비밀번호 찾기 (이메일로 발송, 임시 비밀번호 생성 및 업데이트)
	@RequestMapping(value = "/login/findPW", method = {RequestMethod.POST})
	@ResponseBody
	public void findPWPOST(@ModelAttribute UserDTO userdto, HttpServletResponse response) throws Exception{
		log.info("------ findPW Page------");
		loginService.findPW(response, userdto);
	}
	
	@GetMapping("/signup")
	public void signup() {
		log.info("------ Signup Page------");
	}
	
	@RequestMapping(value = "/userinfo", method = RequestMethod.GET)
	public void infoGET(Principal principal, Model model) throws Exception{
		//세션 객체 안에 있는 ID정보 저장
		String userid = principal.getName();
		log.info("C: 회원정보보기 GET의 아이디 "+userid);
		//서비스안의 회원정보보기 메서드 호출
		UserDTO dto = memberService.readMember(userid);
		//정보저장 후 페이지 이동
		model.addAttribute("UserDTO", dto);
		log.info("C: 회원정보보기 GET의 VO "+ dto);
	}
	
	// 회원정보 수정
	@RequestMapping(value="/usermodify", method = RequestMethod.GET)
	public String updateGET(Principal principal, Model model) throws Exception{
		String userid = principal.getName();
		model.addAttribute("UserDTO", memberService.readMember(userid));
		return "/login/usermodify";
	}

	@RequestMapping(value="/usermodify", method = RequestMethod.POST)
	public String updatePOST(UserDTO dto, Principal principal, Model model) throws Exception{
		memberService.usermodify(dto);
	
		String userid = principal.getName();
		model.addAttribute("UserDTO", memberService.readMember(userid));
		
		return "/login/usermodify";
	}
	
	// 비밀번호 변경
	@RequestMapping(value="/pwmodify", method = RequestMethod.GET)
	public String pwmodifyGET(Principal principal, Model model) throws Exception{
		String userid = principal.getName();
		model.addAttribute("UserDTO", memberService.readMember(userid));
		return "/login/pwmodify";
	}
	
	// 비밀번호 변경
	@ResponseBody
	@RequestMapping(value="/pwmodify", method = RequestMethod.POST, produces = "text/html; charset=UTF-8")
	public String confirmId(UserDTO dto, HttpServletRequest httpServletRequest, Model model){
		String result = "";
		String userid = httpServletRequest.getParameter("userid");
		String userpw1 = httpServletRequest.getParameter("userpw1");
		
		model.addAttribute("userid", userid);
		model.addAttribute("userpw1", userpw1);
		
		UserDTO userDTO = memberService.readMember(userid);
		// 비밀번호 암호화
		String pw = pwencoder.encode(dto.getUserpw1());
		dto.setUserpw1(pw);
		// true or false 반환
		if(pwEncoder.matches(dto.getUserpw(), userDTO.getUserpw())) {
			log.info("비밀번호가 일치");
			result="<script> location.href='/login/userinfo'</script>";
			memberService.pwmodify(dto);
		}else {
			log.info("비밀번호가 불일치");
			result="<script>alert('비밀번호가 일치하지않습니다'); location.href='/login/pwmodify'</script>";
		}
		return result;
	}
	
	// 회원정보삭제 
	@RequestMapping(value = "/deleteForm", method = RequestMethod.GET)
	public String deleteGET(Principal principal, Model model) throws Exception{
		String userid = principal.getName();
		model.addAttribute("UserDTO", memberService.readMember(userid));
		if(userid == null) {
			return "redirect:/main";
		}
		return "/login/deleteForm";			
	}
	@ResponseBody
	@RequestMapping(value = "/deleteForm", method = RequestMethod.POST, produces = "text/html; charset=UTF-8")
	public String deletePOST(UserDTO dto, Principal principal) throws Exception{
		String result = "";
		String userid = principal.getName();
		UserDTO userDTO = memberService.readMember(userid);
		
		if(pwEncoder.matches(dto.getUserpw(), userDTO.getUserpw())) {
			int resultDeleteAuth = memberService.deleteAuth(userid);
			
			if(resultDeleteAuth == 1) {
				memberService.deleteMember(dto);
				// 세션초기화
				SecurityContextHolder.clearContext();
				result="<script> location.href='/main'</script>";
			};
		}else {
			log.info("암호가 일치하지 않습니다.");
			result="<script>alert('비밀번호가 일치하지않습니다'); location.href='/login/deleteForm'</script>";
		}
			
		// 페이지 이동
		return result;			
	}
}