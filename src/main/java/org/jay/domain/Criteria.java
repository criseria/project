package org.jay.domain;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data	// setter / getter 및 toString() 메소드 등
@AllArgsConstructor	// 모든 필드를 입력받는 생성자
@NoArgsConstructor	// 기본 생성자(필드 x)
public class Criteria {
	private int pageNum;
	private int amount;
	private String type;
	private String keyword;
	private int loc_no;
	private String userid;
	private List<String> touNoList;
	private String interest;
	   
	public String[] getTypeArr() {
	   return type == null? new String[] {}:type.split("");
	}
}
