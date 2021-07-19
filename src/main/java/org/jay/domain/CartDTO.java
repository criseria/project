package org.jay.domain;


import java.util.List;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
@Getter
@Setter
public class CartDTO{
	private String userid; // 사용자 아이디
	private int cartpno; // 카트에 담긴 상품 분류 목적
	private Long pno; // 상품 번호
	private String image;
	private String pname;
	private int price;
	private int amount; // 구매 수량
	
	private List<CartDTO> cartList;
}
