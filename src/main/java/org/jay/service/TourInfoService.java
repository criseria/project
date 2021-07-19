package org.jay.service;

import java.util.List;

import org.jay.domain.TourInfoDTO;
import org.jay.domain.TourPickDTO;
import org.jay.domain.Criteria;
import org.jay.domain.TourAttachDTO;

public interface TourInfoService {

	public void register(TourInfoDTO imfor);
	
	public TourInfoDTO detail(Long tou_no);
	
	public boolean update(TourInfoDTO imfor);

	public boolean remove(Long tou_no);
	
//	public List<ImforVO> getList();
	
	public List<TourInfoDTO> getList(Criteria cri);
	
	public int getTotal(Criteria cri);
	
	// 첨부 파일 리스트
	public List<TourAttachDTO> gettourAttachList(Long tou_no);

	public List<String> getTL(TourPickDTO pdto);
	
	public String getInterRest(String userid);
	
}
