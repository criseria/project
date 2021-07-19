package org.jay.service;

import java.util.List;
import java.util.Map;

import org.jay.mapper.TourInfoMapper;
import org.jay.mapper.TourPickMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.jay.domain.Criteria;
import org.jay.domain.TourInfoDTO;
import org.jay.domain.TourPickDTO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class TourPickServiceImpl implements TourPickService{
	
	@Autowired
	private TourPickMapper pickmapper;

	@Override
	public void pickPlus(TourPickDTO pdto) {
		log.info("pickPlus....." + pdto);
		
		pickmapper.pickInsert(pdto);
		
	}

	@Override
	public TourPickDTO pickList(TourPickDTO pdto) {
		return pickmapper.getPick(pdto);
	}

	@Override
	public boolean pickRemove(TourPickDTO pdto) {
		log.info("pickRemove...." + pdto);
		return pickmapper.pickDelete(pdto) == 1;
	}
	
	





//	@Override
//	public int pickCount(int tou_no) {
//		log.info(tou_no);
//		return mapper.pickCount(tou_no);
//	}
	
	

	
}
