package org.jay.service;


import java.util.List;
import java.util.Map;

import org.jay.domain.TourPickDTO;

public interface TourPickService {

	public void pickPlus(TourPickDTO pdto);
	
	public TourPickDTO pickList(TourPickDTO pdto);
	
	public boolean pickRemove(TourPickDTO pdto);


	
//	public int pickCount(int tou_no);
	
	
	
}
