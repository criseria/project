package org.jay.controller;

import java.security.Principal;
import java.util.List;

import org.jay.domain.BoardAttachDTO;
import org.jay.domain.BoardDTO;
import org.jay.domain.BoardCriteria;
import org.jay.domain.BoardPageDTO;
import org.jay.domain.Criteria;
import org.jay.service.BoardService;
import org.jay.service.BoardServiceImpl;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@AllArgsConstructor
@Controller
@Log4j
@RequestMapping("/board/*")
public class BoardController {
	
	private BoardService service;
	
	@GetMapping("/list")	//			/board/list
	public void list(Model model, BoardCriteria cri , BoardDTO board) {
	/*	
		String writer = principal.getName();
		board.setWriter(writer);
		List<String> list = service.mywriting(board);
		cri.setBnolist(list);
	*/	
		log.info("list : " + cri);
		model.addAttribute("list", service.getList(cri));
		
		int total = service.getTotal(cri);
		log.info("total : " + total);
		model.addAttribute("pageMaker", new BoardPageDTO(cri, total));
	}
	
	@PostMapping("/register") // 		/board/register
	public String register(BoardDTO board, RedirectAttributes rttr, BoardCriteria cri) {
		log.info("register...." + board);
		
		// 실제 데이터 삽입 완료
		service.register(board);
		rttr.addFlashAttribute("result", board.getBno());
		
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		
		return "redirect:/board/list";
	}
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/register")
	public void register(BoardCriteria cri, Model model , String writer , Principal principal) {
		writer = principal.getName();
		log.info("현재 로그인 ID : " + writer);
		model.addAttribute("cri", cri);
	}
	
	// @ModelAttribute는 자동으로 model 객체에 지정한 이름으로 담아준다.
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/get")
	public void get(Model model, @RequestParam("bno") Long bno,
						@ModelAttribute("cri") BoardCriteria cri) {
		log.info("/get");
		model.addAttribute("board", service.get(bno)); 
	}
	
	@PreAuthorize("isAuthenticated() and (( principal.username == #writer ) or principal.username == 'admin01')") // 일단 관리자 계정으로 설정했다. 하지만 권한을 사용해야 한다.
	@GetMapping("/modify")
	public void modify(Model model, @RequestParam("bno") Long bno, String writer,
						@ModelAttribute("cri") BoardCriteria cri) {
		log.info("/modify");
		
		model.addAttribute("board", service.get(bno)); 
	}
	
	@PostMapping("/modify")
	public String modify(BoardDTO board, RedirectAttributes rttr, BoardCriteria cri) {
		log.info("/modify..." + board);
		
		if(service.modify(board)) {
			rttr.addFlashAttribute("result", "success");
		}
		
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword" , cri.getKeyword());
		
		return "redirect:/board/list";
	}
	
	// 삭제는 반드시 POST 방식으로만 처리한다!!!!!!!!
	@PostMapping("/remove")
	public String remove(@RequestParam("bno") Long bno,
						RedirectAttributes rttr, BoardCriteria cri) {
		log.info("/remove..." + bno);
		
		if(service.remove(bno)) {
			rttr.addFlashAttribute("result", "success");
		}
		
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword" , cri.getKeyword());
		
		return "redirect:/board/list";
	}
	
	@GetMapping(value = "/getAttachList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<BoardAttachDTO>> getAttachList(Long bno) {
		log.info("getAttachList : " + bno);
		return new ResponseEntity<>(service.getAttachList(bno), HttpStatus.OK);
	}
	
	
	@GetMapping("/mywriting")	//			/board/mywriting
	public void mywriting(Principal principal, Model model, BoardCriteria cri,BoardDTO board) {
		
		String writer = principal.getName();
		board.setWriter(writer);
		List<String> list = service.mywriting(board);
		cri.setBnolist(list);
		
		
		log.info("writer :" + writer);
		
		log.info("list : " + cri);
		
		
		model.addAttribute("list", service.getList(cri));
		
		
		int total = service.getTotal(cri);
		log.info("total : " + total);
		model.addAttribute("pageMaker", new BoardPageDTO(cri, total));
	}
	
	
	
}
