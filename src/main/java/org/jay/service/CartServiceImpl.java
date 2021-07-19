package org.jay.service;

import java.util.List;

import org.jay.domain.CartDTO;
import org.jay.mapper.CartMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class CartServiceImpl implements CartService{
	
	@Autowired
	private CartMapper cartMapper;
	
	// 장바구니에 상품이 있는지 여부 조회
	@Override
	public CartDTO readCart(CartDTO dto) {
		return cartMapper.readCart(dto);
	}
	
	// 전체 장바구니 목록 조회
	@Override
	public List<CartDTO> getAllCartList(String userid) {
		return cartMapper.getAllCartList(userid);
	}
	
	// 장바구니 담기
	@Override
	public int addCart(CartDTO dto) {
		return cartMapper.addCart(dto);
	}
	
	// 장바구니 해제
	@Override
	public int removeCart(int cartpno) {
		return cartMapper.removeCart(cartpno);
	}
	
	// 장바구니에 담긴 상품들 가격 합 구하기
	@Override
	public int getAllPrice(String userid) {
		return cartMapper.getAllPrice(userid);
	}
	
}
