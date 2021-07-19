package org.jay.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.jay.domain.BoardCriteria;
import org.jay.domain.ReplyDTO;

public interface ReplyMapper {
	// 댓글 등록
	public int insert(ReplyDTO vo);
	// 댓글 조회
	public ReplyDTO read(Long rno);
	// 댓글 삭제
	public int delete(Long rno);
	// 댓글 수정
	public int update(ReplyDTO vo);

	//게시판에 삭제 시 
	public int removeAll(Long bno);

	// 댓글 목록
	public List<ReplyDTO> getListWithPaging(@Param("cri") BoardCriteria cri,
										 @Param("bno") Long bno);
}