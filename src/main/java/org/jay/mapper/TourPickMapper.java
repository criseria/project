package org.jay.mapper;


import org.jay.domain.TourPickDTO;

public interface TourPickMapper {
	
	public void pickInsert(TourPickDTO pdto);
	
	// 찜
	public TourPickDTO getPick(TourPickDTO pdto);
	
	// 찜 취소
	public int pickDelete(TourPickDTO pdto);
	
//	// 찜 카운트
//	public int pickCount(int tou_no);

}
