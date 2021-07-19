package org.jay.service;

import java.util.List;

import org.jay.domain.ChatAlarmDTO;

public interface ChatAlarmService {
	
	public int insertChatAlarm(ChatAlarmDTO dto);
	public List<ChatAlarmDTO> selectChatAlarm(String admin);
	public int removeAlarm(String userid);
}
