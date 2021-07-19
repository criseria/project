package org.jay.domain;

import java.sql.Date;

import lombok.Data;

@Data
public class ReplyDTO {
	private Long rno, bno;
	private String reply, replyer;
	private Date replyDate, updateDate;
}
