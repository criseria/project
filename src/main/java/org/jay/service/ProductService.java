package org.jay.service;

import java.util.List;

import org.jay.domain.ProductDTO;
import org.jay.domain.BuyListDTO;
import org.jay.domain.ProductCriteria;

public interface ProductService {
	public List<ProductDTO> getList(ProductCriteria cri);
	public void register(ProductDTO product);
	public ProductDTO get(Long pno);
	public boolean remove(Long pno);
	public boolean modify(ProductDTO product);
	public int getTotal(ProductCriteria cri);
	
	// 구매 목록 불러오기
	public List<BuyListDTO> buyList(BuyListDTO dto);
	
}
