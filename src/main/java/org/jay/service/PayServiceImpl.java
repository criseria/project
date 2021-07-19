package org.jay.service;

import org.jay.domain.BuyListDTO;
import org.jay.mapper.PayMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class PayServiceImpl implements PayService{
	
	@Autowired
	private PayMapper payMapper;
	
	// 상품 구매 insert
	@Override
	public int doPay(BuyListDTO dto) {
		return payMapper.doPay(dto);
	}
}
