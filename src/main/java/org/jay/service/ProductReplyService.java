package org.jay.service;

import java.util.List;

import org.jay.domain.ProductCriteria;
import org.jay.domain.ProductReplyDTO;
import org.jay.domain.StarRatingDTO;

public interface ProductReplyService {
	public int register(ProductReplyDTO vo);
	public ProductReplyDTO get(Long rno);
	public int modify(ProductReplyDTO vo);
	public int remove(Long rno);
	
	public List<ProductReplyDTO> getList(ProductCriteria cri, Long pno);
	
	// 별점 테이블에 insert
	public int insertRating(StarRatingDTO dto);
	
	// 상품 리뷰의 별점 합산 구하기
	public int totalScore(Long pno);
	
	// 댓글 작성자가 매긴 별점 구해오기
	public int userScore(StarRatingDTO dto);
}
