package org.jay.service;

import java.util.List;

import org.jay.domain.TourCatDTO;
import org.jay.mapper.TourCatMapper;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class TourCatServiceImpl implements TourCatService{
	
	private TourCatMapper mapper;
	
	@Override
	public List<TourCatDTO> getcatList() {
		log.info("getList...........");
		
		return mapper.getCatList();
	}
}
