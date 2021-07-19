package org.jay.service;

import java.util.List;

import org.jay.mapper.TourAttachMapper;
import org.jay.mapper.TourInfoMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.jay.domain.Criteria;
import org.jay.domain.TourAttachDTO;
import org.jay.domain.TourInfoDTO;
import org.jay.domain.TourPickDTO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class TourInfoServiceImpl implements TourInfoService{
	
	@Autowired
	private TourInfoMapper mapper;
	
	@Autowired
	private TourAttachMapper tamapper;

	@Override
	public void register(TourInfoDTO tourInfo) {
		log.info("register......" +  tourInfo);
		
		mapper.insertSelectKey(tourInfo);
		
		// 첨부파일 등록
		if(tourInfo.getTourAttachList() == null || tourInfo.getTourAttachList().size() <= 0) {
			return;
		}
				
		for(TourAttachDTO tadto : tourInfo.getTourAttachList()) {
			tadto.setTou_no(tourInfo.getTou_no());
			tamapper.insert(tadto);
		}
	}

	
	@Override
	public List<TourInfoDTO> getList(Criteria cri) {
		log.info("get List with criteria: " +cri);
		return mapper.getListWithPaging(cri);
	}
	
	
	@Override
	public TourInfoDTO detail(Long tou_no) {
	
		log.info("detail : " + tou_no);
		return mapper.read(tou_no);
	}
	
	
	@Override
	public boolean update(TourInfoDTO tourInfo) {
		log.info("update : " + tourInfo);
		
		return mapper.update(tourInfo) == 1;
	}
	
	
	@Override
	public boolean remove(Long tou_no) {
		log.info("remove : " + tou_no);
		
		return mapper.delete(tou_no) == 1; 
	}
	
	
	@Override
	public int getTotal(Criteria cri) {
		log.info("get total count");
		return mapper.getTotalCount(cri);
	}

	

	@Override
	public List<TourAttachDTO> gettourAttachList(Long tou_no) {
		log.info("get Attach List by pno : " + tou_no);
		return tamapper.findBytou_no(tou_no);
	}


	@Override
	public List<String> getTL(TourPickDTO pdto) {
		log.info("get getTL");
		return mapper.getTL(pdto);
	}


	@Override
	public String getInterRest(String userid) {
		log.info("get interest" + userid);
		return mapper.getInterRest(userid);
	}
	
	
	
}
