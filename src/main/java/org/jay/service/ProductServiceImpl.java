package org.jay.service;

import java.util.List;


import org.jay.domain.ProductDTO;
import org.jay.domain.BuyListDTO;
import org.jay.domain.ProductCriteria;
import org.jay.mapper.ProductMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class ProductServiceImpl implements ProductService{
	

	@Autowired
	private ProductMapper mapper;

	@Override
	public List<ProductDTO> getList(ProductCriteria cri) {
		log.info("get List with criteria : " + cri);
		return mapper.getListWithPaging(cri);
	}

	@Transactional
	@Override
	public void register(ProductDTO product) {
		// 게시글 등록
		log.info("register...." + product);
		mapper.insertSelectKey(product);
		
		log.info("@@@@@@@@@@@@@@@@");
		
	}

	@Override
	public ProductDTO get(Long pno) {
		log.info("get...." + pno);
		return mapper.read(pno);
	}

	@Transactional
	@Override
	public boolean remove(Long pno) {
		log.info("remove--------------------" + pno);
		
		boolean result = false;
		int mathodResult = 0;
		
		mathodResult =	mapper.delete(pno);
		
		if(mathodResult > 0) {
			result = true;
		}else {
			result = false;
		}
		return result;
	}
	@Transactional
	@Override
	public boolean modify(ProductDTO product) {
		log.info("modify...." + product);
		
		
		// 게시글을 수정한다.
		boolean modifyResult = mapper.update(product)==1;
		
		
		return modifyResult;
	}
	
	@Override
	public int getTotal(ProductCriteria cri) {
		log.info("get Total Count...");
		return mapper.getTotalCount(cri);
	}

	@Override
	public List<BuyListDTO> buyList(BuyListDTO dto) {
		
		log.info("@ProductController / userid : " + dto.getUserid());
		
		return mapper.buyList(dto);
	}
}
