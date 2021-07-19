package org.jay.domain;

import lombok.Data;
import lombok.ToString;

@Data
@ToString
//검색기능 추가
public class ProductCriteria {
	
	private int pageNum;
	private int amount;
	
	private String type;
	private String keyword;
	
	private int catenum;
	
	public ProductCriteria() {
		this(1,9);
	}
	
	public ProductCriteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
	public String[] getTypeArr() {
		return type == null? new String[] {} : type.split("");
	}
	
	
}
