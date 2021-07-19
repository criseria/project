package org.jay.controller;

import java.security.Principal;
import java.util.List;

import org.jay.domain.ProductCriteria;
import org.jay.domain.ProductDTO;
import org.jay.domain.ProductReplyDTO;
import org.jay.domain.StarRatingDTO;
import org.jay.service.ProductReplyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RestController
@Log4j
@RequestMapping("/reply/")
public class ProductReplyController {
	@Setter(onMethod_ = @Autowired)
	private ProductReplyService service;

	// 댓글 등록
	@RequestMapping(value = "/regReply", method = RequestMethod.POST)
	@ResponseBody
	public int regReply(Model model, ProductReplyDTO dto, int score) {
		
		// 리뷰 테이블에 값 insert
		int resultReview = service.register(dto);
		if(resultReview == 1) {
			log.info("댓글 작성 성공!");
		}else {
			log.info("댓글 작성 실패");
		}
		
		// 별점 테이블에 값 insert
		StarRatingDTO ratingDTO = new StarRatingDTO();
		ratingDTO.setPno(dto.getPno());
		ratingDTO.setScore(score);
		ratingDTO.setUserid(dto.getReplyer());
		
		int resultRating = service.insertRating(ratingDTO);
		if(resultRating == 1) {
			log.info("별점 등록 성공!");
		}else {
			log.info("별점 등록 실패");
		}
		
		if(resultReview == 1 && resultRating ==1) {
			return 1;
		}else {
			return 0;
		}
	}
	
	// 댓글 목록
	@GetMapping(value = "/pages/{pno}/{page}",
			produces = {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<List<ProductReplyDTO>> getList(@PathVariable("pno") Long pno,
												@PathVariable("page") int page){
		log.info("getList...");
		ProductCriteria cri = new ProductCriteria(page, 10);
		log.info(cri);
		
		return new ResponseEntity<>(service.getList(cri, pno), HttpStatus.OK);
	}
	
	// 댓글 조회
	@GetMapping(value = "/{rno}", produces = {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<ProductReplyDTO> get(@PathVariable("rno") Long rno){
		
		log.info("get..." + rno);
		
		return new ResponseEntity<>(service.get(rno), HttpStatus.OK);
	}
	
	
	// 댓글 삭제
	@DeleteMapping(value = "/{rno}", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> remove(@PathVariable("rno") Long rno){
		log.info("remove..." + rno);
		
		return service.remove(rno) == 1 ?
				new ResponseEntity<>("success", HttpStatus.OK) :
					new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	// 댓글 수정
	@RequestMapping(method = {RequestMethod.PUT, RequestMethod.PATCH},
			value = "/{rno}", consumes = "application/json", 
			produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> modify(@RequestBody ProductReplyDTO vo, @PathVariable("rno") Long rno){
		vo.setRno(rno);
		log.info("rno : " + rno);
		log.info("modify : " + vo);
		
		return service.modify(vo) == 1 ?
				new ResponseEntity<>("success", HttpStatus.OK) :
					new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	// 리뷰 작성자의 별점 조회
	@RequestMapping(value = "/getScore", method = RequestMethod.GET)
	@ResponseBody
	public String getScore(StarRatingDTO dto) {
		
		String score = Integer.toString(service.userScore(dto));
		log.info(score);
		
		return score;
	}
	
	
	
	
	
	
	
	
	
	
	
}