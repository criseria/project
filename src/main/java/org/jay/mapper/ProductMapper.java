package org.jay.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.jay.domain.ProductDTO;
import org.jay.domain.BuyListDTO;
import org.jay.domain.ProductCriteria;

public interface ProductMapper {
	
	
		// 전체 검색
		public List<ProductDTO> getList();
		
		public List<ProductDTO> getListWithPaging(ProductCriteria cri);
		
		// 삽입
		public void insert(ProductDTO product);
		
		// 원하는 값 리턴 받아서 적용
		public void insertSelectKey(ProductDTO product);
		
		// 인덱스를 입력받아 데이터 출력
		public ProductDTO read(Long pno);
		
		// 인덱스를 입력받아 데이터 삭제	
		public int delete(Long pno);
		
		// 데이터 수정
		public int update(ProductDTO product);
		
		// 테이블 내 전체 데이터 개수 구하기
		public int getTotalCount(ProductCriteria cri);
		
		// 댓글 수 업데이트
		public void updateReplyCnt(@Param("pno") Long pno, @Param("amount") int amount);
		
		// 구매 목록 불러오기
		public List<BuyListDTO> buyList(BuyListDTO dto);
	}