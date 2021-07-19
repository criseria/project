package org.jay.domain;

import java.sql.Date;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
@Getter
@Setter
public class BuyListDTO {

	private String userid;
	private Long pno;
	private int amount;
	private Date buyDate;
	private String recvName;
	private String recvPhone;
	private String recvAddr;
	private String shipRequest;
	
}
