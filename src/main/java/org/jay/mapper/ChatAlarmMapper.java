package org.jay.mapper;

import java.util.List;

import org.jay.domain.ChatAlarmDTO;

public interface ChatAlarmMapper {

	public int insertChatAlarm(ChatAlarmDTO dto);
	public List<ChatAlarmDTO> selectChatAlarm(String admin);
	public int removeAlarm(String userid);
}
