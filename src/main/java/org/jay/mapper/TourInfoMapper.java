package org.jay.mapper;

import java.util.List;

import org.jay.domain.TourInfoDTO;
import org.jay.domain.TourPickDTO;
import org.jay.domain.Criteria;

public interface TourInfoMapper {
	// 전체 검색
	public List<TourInfoDTO> getList();
	
	// 페이징 처리
	public List<TourInfoDTO> getListWithPaging(Criteria cri);

	// 데이터 삽입
	public void insert(TourInfoDTO imfor);
	
	// 데이터 삽입(selectKey)
	public void insertSelectKey(TourInfoDTO imfor);
	
	// 데이터 검색
	public TourInfoDTO read(Long tou_no);
	
	// 데이터 삭제
	public int delete(Long tou_no);
	
	// 데이터 수정
	public int update(TourInfoDTO imfor);
	
	public int getTotalCount(Criteria cri);

	public List<String> getTL(TourPickDTO pdto);
	
	public String getInterRest(String userid);
	
	

}
