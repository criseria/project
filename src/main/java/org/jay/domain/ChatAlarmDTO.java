package org.jay.domain;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
@Getter
@Setter
public class ChatAlarmDTO {
	
	private String userid;
	private int chat_alarm;
	private String toWho;
	private String ranNo;
	
}
