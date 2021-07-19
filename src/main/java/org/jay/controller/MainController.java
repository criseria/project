package org.jay.controller;

import java.util.ArrayList;
import java.util.List;

import org.jay.domain.ChatAlarmDTO;
import org.jay.service.ChatAlarmService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.ui.Model;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@AllArgsConstructor
@Controller
@Log4j
public class MainController {

	@Autowired
	ChatAlarmService csService;
	
	@RequestMapping("/main")
	public void main(Model model) {
		log.info("------Go Main Page------");
		
		List<ChatAlarmDTO> dto = new ArrayList<ChatAlarmDTO>();
		List<ChatAlarmDTO> dto2 = new ArrayList<ChatAlarmDTO>();
		
		dto = csService.selectChatAlarm("admin01");
		
		log.info("dto >>>>>>> " + dto);
		log.info("dto2 >>>>>>> " + dto2);
		
		if(dto.equals(dto2)) {
			log.info("-----Q&A 문의가 없었습니다-----");
			
			model.addAttribute("check", "no");
		}else {
			log.info("-----사용자의 문의가 있습니다.-----");
			
			model.addAttribute("check", "yes");
		}
		
	}
}
