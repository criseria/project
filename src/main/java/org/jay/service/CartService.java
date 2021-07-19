package org.jay.service;

import java.util.List;

import org.jay.domain.CartDTO;

public interface CartService {
	
	// 장바구니에 상품이 있는지 여부 조회
	public CartDTO readCart(CartDTO dto);
	
	// 전체 장바구니 목록 조회
	public List<CartDTO> getAllCartList(String userid);
	
	// 장바구니에 담기
	public int addCart(CartDTO dto); 
	
	// 장바구니 해제
	public int removeCart(int cartpno);
	
	// 장바구니에 담긴 상품들 가격 합 구하기
	public int getAllPrice(String userid);
}
