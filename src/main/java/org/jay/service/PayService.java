package org.jay.service;

import org.jay.domain.BuyListDTO;

public interface PayService {
	
	// 상품 구매 insert
	public int doPay(BuyListDTO dto);
}
