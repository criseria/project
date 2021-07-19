package org.jay.mapper;

import java.util.List;

import org.jay.domain.TourCatDTO;

public interface TourCatMapper {

	// 카테고리 리스트 가져오기
	public List<TourCatDTO> getCatList(); 
}
