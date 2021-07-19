package org.jay.service;

import java.util.List;

import org.jay.domain.BoardCriteria;
import org.jay.domain.ReplyDTO;
import org.jay.mapper.BoardMapper;
import org.jay.mapper.ReplyMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class ReplyServiceImpl implements ReplyService{

	@Setter(onMethod_ = @Autowired)
	private ReplyMapper mapper;
	
	@Setter(onMethod_ = @Autowired)
	private BoardMapper boardMapper;
	
	@Transactional
	@Override
	public int register(ReplyDTO vo) {
		log.info("register ... : " + vo);
		
		// replycnt 컬럼에 1증가(업데이트)
		boardMapper.updateReplyCnt(vo.getBno(), 1);
		
		return mapper.insert(vo);
	}

	@Override
	public ReplyDTO get(Long rno) {
		log.info("get ... : " + rno);
		return mapper.read(rno);
	}

	@Override
	public int modify(ReplyDTO vo) {
		log.info("modify ... : " + vo);
		return mapper.update(vo);
	}

	@Transactional
	@Override
	public int remove(Long rno) {
		log.info("remove ... : " + rno);
		
		ReplyDTO vo = mapper.read(rno);
		
		// replycnt 컬럼에 1감소 업데이트
		boardMapper.updateReplyCnt(vo.getBno(), -1);
		
		return mapper.delete(rno);
	}

	@Override
	public List<ReplyDTO> getList(BoardCriteria cri, Long bno) {
		log.info("get Reply List of a Board ... : " + bno);
		return mapper.getListWithPaging(cri, bno);
	}
	
}
