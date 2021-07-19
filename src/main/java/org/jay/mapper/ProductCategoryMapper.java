package org.jay.mapper;

import java.util.List;

import org.jay.domain.ProductCategoryDTO;

public interface ProductCategoryMapper {
	// 카테고리 리스트로 불러오기
	public List<ProductCategoryDTO> getCategoryList();
}
