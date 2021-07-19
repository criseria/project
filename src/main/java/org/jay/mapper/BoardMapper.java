package org.jay.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.jay.domain.BoardDTO;
import org.jay.domain.BoardCriteria;

public interface BoardMapper {
	
		// 전체 검색
		public List<BoardDTO> getList();
		
		public List<BoardDTO> getListWithPaging(BoardCriteria cri);
		
		// 삽입
		public void insert(BoardDTO board);
		
		// 원하는 값 리턴 받아서 적용
		public void insertSelectKey(BoardDTO board);
		
		// 인덱스를 입력받아 데이터 출력
		public BoardDTO read(Long bno);
		
		// 인덱스를 입력받아 데이터 삭제	
		public int delete(Long bno);
		
		// 데이터 수정
		public int update(BoardDTO board);
		
		// 테이블 내 전체 데이터 개수 구하기
		public int getTotalCount(BoardCriteria cri);
		
		// 댓글 수 업데이트
		public void updateReplyCnt(@Param("bno") Long bno, @Param("amount") int amount);
		
		// 마이페이지 내가 쓴 글 목록
		public List<String> mywriting(BoardDTO board);
		
	}