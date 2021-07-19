package org.jay.service;

import java.util.List;

import org.jay.domain.ProductCriteria;
import org.jay.domain.ProductReplyDTO;
import org.jay.domain.StarRatingDTO;
import org.jay.mapper.ProductMapper;
import org.jay.mapper.ProductReplyMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class ProductReplyServiceImpl implements ProductReplyService{

	@Setter(onMethod_ = @Autowired)
	private ProductReplyMapper mapper;
	
	@Setter(onMethod_ = @Autowired)
	private ProductMapper productMapper;
	
	@Transactional
	@Override
	public int register(ProductReplyDTO vo) {
		log.info("register ... : " + vo);
		
		// replycnt 컬럼에 1증가(업데이트)
		productMapper.updateReplyCnt(vo.getPno(), 1);
		
		return mapper.insert(vo);
	}

	@Override
	public ProductReplyDTO get(Long rno) {
		log.info("get ... : " + rno);
		return mapper.read(rno);
	}

	@Override
	public int modify(ProductReplyDTO vo) {
		log.info("modify ... : " + vo);
		return mapper.update(vo);
	}

	@Transactional
	@Override
	public int remove(Long rno) {
		log.info("remove ... : " + rno);
		
		ProductReplyDTO vo = mapper.read(rno);
		
		// replycnt 컬럼에 1감소 업데이트
		productMapper.updateReplyCnt(vo.getPno(), -1);
		
		return mapper.delete(rno);
	}

	@Override
	public List<ProductReplyDTO> getList(ProductCriteria cri, Long pno) {
		log.info("get Reply List of a Product ... : " + pno);
		return mapper.getListWithPaging(cri, pno);
	}
	
	// 별점 테이블에 insert
	@Override
	public int insertRating(StarRatingDTO dto) {
		return mapper.insertRating(dto);
	}
	
	// 상품 리뷰의 별점 합산 구하기
	@Override
	public int totalScore(Long pno) {
		return mapper.totalScore(pno);
	}
	
	// 댓글 작성자가 매긴 별점 구해오기
	@Override
	public int userScore(StarRatingDTO dto) {
		return mapper.userScore(dto);
	}
	
	
	
}
