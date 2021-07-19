package org.jay.service;

import java.util.List;

import org.jay.domain.ChatAlarmDTO;
import org.jay.mapper.ChatAlarmMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class ChatAlarmServiceImpl implements ChatAlarmService{
	
	@Autowired
	ChatAlarmMapper caMapper;
	
	@Override
	public int insertChatAlarm(ChatAlarmDTO dto) {
		return caMapper.insertChatAlarm(dto);
	}

	@Override
	public List<ChatAlarmDTO> selectChatAlarm(String admin) {
		return caMapper.selectChatAlarm(admin);
	}

	@Override
	public int removeAlarm(String userid) {
		return caMapper.removeAlarm(userid);
	}
}
