package org.jay.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.jay.domain.ProductCriteria;
import org.jay.domain.ProductReplyDTO;
import org.jay.domain.StarRatingDTO;

public interface ProductReplyMapper {
	// 댓글 등록
	public int insert(ProductReplyDTO vo);
	
	// 댓글 조회
	public ProductReplyDTO read(Long rno);
	
	// 댓글 삭제
	public int delete(Long rno);
	
	// 댓글 수정
	public int update(ProductReplyDTO vo);

	//게시판에 삭제 시 
	public int removeAll(Long pno);

	// 댓글 목록
	public List<ProductReplyDTO> getListWithPaging(@Param("cri") ProductCriteria cri,
										 @Param("pno") Long pno);
	
	// 별점 테이블에 insert
	public int insertRating(StarRatingDTO dto);
	
	// 상품 리뷰의 별점 합산 구하기
	public int totalScore(Long pno);
	
	// 댓글 작성자가 매긴 별점 구해오기
	public int userScore(StarRatingDTO dto);
}