package org.jay.mapper;

import java.util.List;

import org.jay.domain.BoardAttachDTO;

public interface BoardAttachMapper {
	public void insert(BoardAttachDTO vo);
	public void delete(String uuid);
	public int deleteAll(Long bno);
	public List<BoardAttachDTO> findByBno(Long bno);
}
