package org.jay.domain;

import java.util.List;

import lombok.Data;
import lombok.ToString;

@ToString
@Data
//검색기능 추가
public class BoardCriteria {
	private int pageNum;
	private int amount;
	
	private String type;
	private String keyword;
	
	private int bno_no;
	private List<String> bnolist;
	
	public BoardCriteria() {
		this(1,10);
	}
	public BoardCriteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
	public String[] getTypeArr() {
		return type == null? new String[] {} : type.split("");
	}
	
	
}
