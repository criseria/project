package org.jay.mapper;

import java.util.List;

import org.jay.domain.TourAttachDTO;

public interface TourAttachMapper {
	public void insert(TourAttachDTO tadto);
	public void delete(String uuid);
	public int deleteAll(Long tou_no);
	public List<TourAttachDTO> findBytou_no(Long tou_no);
}
