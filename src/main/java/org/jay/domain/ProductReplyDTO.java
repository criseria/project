package org.jay.domain;

import java.sql.Date;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
@Getter
@Setter
public class ProductReplyDTO {
	private Long rno;
	private Long pno;
	private String reply;
	private String replyer;
	private Date replyDate;
	private Date updateDate;
}
