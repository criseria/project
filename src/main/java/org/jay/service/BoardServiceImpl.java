package org.jay.service;

import java.util.List;

import org.jay.domain.BoardAttachDTO;
import org.jay.domain.BoardDTO;
import org.jay.domain.BoardCriteria;
import org.jay.domain.ReplyDTO;
import org.jay.mapper.BoardAttachMapper;
import org.jay.mapper.BoardMapper;
import org.jay.mapper.ReplyMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class BoardServiceImpl implements BoardService{

	@Autowired
	private BoardMapper mapper;
	
	@Setter(onMethod_ = @Autowired)
	private BoardAttachMapper attachMapper;
	
	@Autowired
	private ReplyMapper replymapper;

//	@Override
//	public List<BoardVO> getList() {
//		log.info("getList.....");
//		return mapper.getList();
//	}
	// 망한 페이지
	
	@Override
	public List<BoardDTO> getList(BoardCriteria cri) {
		log.info("get List with criteria : " + cri);
		return mapper.getListWithPaging(cri);
	}
	
	@Transactional
	@Override
	public void register(BoardDTO board) {
		// 게시글 등록
		log.info("register...." + board);
		mapper.insertSelectKey(board);
		
		log.info("@@@@@@@@@@@@@@@@");
		
		// 첨부파일 등록
		if(board.getAttachList() == null || board.getAttachList().size() <= 0) {
			return;
		}
		
		for(BoardAttachDTO vo : board.getAttachList()) {
			vo.setBno(board.getBno());
			attachMapper.insert(vo);
		}
	}

	@Override
	public BoardDTO get(Long bno) {
		log.info("get...." + bno);
		return mapper.read(bno);
	}

	@Transactional
	@Override
	public boolean remove(Long bno) {
		log.info("remove--------------------" + bno);
		ReplyDTO vo = new ReplyDTO();
		
		boolean result = false;
		int mathodResult = 0;
		mathodResult = attachMapper.deleteAll(bno)
				+ replymapper.removeAll(bno)
				+ mapper.delete(bno);
		if(mathodResult > 0) {
			result = true;
		}else {
			result = false;
		}
		return result;
	}
	@Transactional
	@Override
	public boolean modify(BoardDTO board) {
		log.info("modify...." + board);
		
		// 게시글에 달린 첨부파일들 전부 삭제
		attachMapper.deleteAll(board.getBno());
		
		// 게시글을 수정한다.
		boolean modifyResult = mapper.update(board)==1;
		
		// 게시글이 수정되면 첨부파일을 추가한다.
		// 첨부파일 등록
		if(modifyResult && board.getAttachList() != null && board.getAttachList().size() > 0) {
			for(BoardAttachDTO vo : board.getAttachList()) {
				vo.setBno(board.getBno());
				attachMapper.insert(vo);
			}
		}
		
		return modifyResult;
	}

	@Override
	public int getTotal(BoardCriteria cri) {
		log.info("get Total Count...");
		return mapper.getTotalCount(cri);
	}

	@Override
	public List<BoardAttachDTO> getAttachList(Long bno) {
		log.info("get Attach List by bno : " + bno);
		return attachMapper.findByBno(bno);
	}

	@Override
	public List<String> mywriting(BoardDTO board) {
		return mapper.mywriting(board);
	}

	
	
}
