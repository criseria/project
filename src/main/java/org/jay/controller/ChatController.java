package org.jay.controller;

import org.jay.domain.ChatAlarmDTO;
import org.jay.security.domain.CustomUser;
import org.jay.service.ChatAlarmService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/message/*")
public class ChatController {

	@Autowired
	ChatAlarmService csService;
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/chatAdmin")
	public void chatAdmin(Model model) {
		
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		
		log.info("================================");
		log.info("@ChatController, GET Chat / Admin : " + user.getUsername());
		
		model.addAttribute("userid", user.getUsername());
	}

	@PreAuthorize("isAuthenticated()")
	@GetMapping("/chatUser")
	public void chatUser(Model model) {
		
		// 채팅하기
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		
		log.info("================================");
		log.info("@ChatController, GET Chat / User : " + user.getUsername());
		
		model.addAttribute("userid", user.getUsername());
	}
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/chatAlarm")
	public String chatAlarm(Model model, String userid, String towho) {
		
		// chatAlarm db값 넣기
		ChatAlarmDTO dto = new ChatAlarmDTO();
		dto.setUserid(userid);
		dto.setChat_alarm(1);
		dto.setToWho(towho);
		
		// 랜덤값 만들어서 delete할 때 사용하기
		String ranNo = "";
		for(int i = 0; i < 12; i++) {
			ranNo += (char)((Math.random() * 26) + 97);
		}
		dto.setRanNo(ranNo);
		
		csService.insertChatAlarm(dto);
		
		log.info("#ChatController userid : " + dto.getUserid());
		log.info("#ChatController ranNo : " + dto.getRanNo());
		
		return "redirect:/main";
	}
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/endChat")	
	public void removeAlarm(Model model, String userid) {
		log.info("delete문 날리는 userid : " + userid);
		csService.removeAlarm(userid);
	};
	
	
	
	

	
}
