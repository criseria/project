package org.jay.service;

import java.util.List;

import org.jay.domain.ProductCategoryDTO;
import org.jay.mapper.ProductCategoryMapper;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class ProductCategoryServiceImpl implements ProductCategoryService {
	private ProductCategoryMapper mapper;
	
	@Override
	public List<ProductCategoryDTO> getCategoryList() {
		log.info("getcategoryList.......");
		
		return mapper.getCategoryList();
	}
}
