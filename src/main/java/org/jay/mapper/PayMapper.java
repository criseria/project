package org.jay.mapper;

import org.jay.domain.BuyListDTO;

public interface PayMapper {
	
	// 상품 하나에 대한 구매 내역 insert
	public int doPay(BuyListDTO dto);
}
