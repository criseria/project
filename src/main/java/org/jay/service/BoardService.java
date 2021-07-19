package org.jay.service;

import java.util.List;

import org.jay.domain.BoardAttachDTO;
import org.jay.domain.BoardDTO;
import org.jay.domain.BoardCriteria;

public interface BoardService {
	public List<BoardDTO> getList(BoardCriteria cri);
	public void register(BoardDTO board);
	public BoardDTO get(Long bno);
	public boolean remove(Long bno);
	public boolean modify(BoardDTO board);
	public int getTotal(BoardCriteria cri);
	
	// 내가 쓴 글 목록
	public List<String> mywriting(BoardDTO board);
	
	
	// 첨부 파일 리스트
	public List<BoardAttachDTO> getAttachList(Long bno);
}
