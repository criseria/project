package org.jay.service;

import java.util.List;

import org.jay.domain.BoardCriteria;
import org.jay.domain.ReplyDTO;

public interface ReplyService {
	public int register(ReplyDTO vo);
	public ReplyDTO get(Long rno);
	public int modify(ReplyDTO vo);
	public int remove(Long rno);
	public List<ReplyDTO> getList(BoardCriteria cri, Long bno);
}
