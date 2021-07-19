package org.jay.controller;

import org.springframework.beans.factory.annotation.Autowired;
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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.jay.domain.Criteria;
import org.jay.domain.TourAttachDTO;
import org.jay.domain.TourInfoDTO;
import org.jay.domain.TourPageDTO;
import org.jay.domain.TourPickDTO;
import org.jay.domain.UserDTO;
import org.jay.service.TourInfoService;
import org.jay.service.TourPickService;
import org.jay.service.TourCatService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/tourInfo/*")
@AllArgsConstructor
public class TourInfoController {
	
	@Autowired
	private TourInfoService tourInfoService;
	
	@Autowired
	private TourCatService tourCatService;
	
	@Autowired
	private TourPickService tourPickSevice;
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/list")
	public void list(Principal principal, Criteria cri, Model model, HttpServletRequest request, TourPickDTO pdto, TourInfoDTO tdto) {
		
		String userid = principal.getName();
		
		pdto.setUserid(userid);
		List<String> list = tourInfoService.getTL(pdto);

		String interest = tourInfoService.getInterRest(userid);
		
		cri.setUserid(userid);
		cri.setTouNoList(list);
		cri.setInterest(interest);
		
		
		log.info("list: " + cri);
		model.addAttribute("list", tourInfoService.getList(cri));
		
		int total = tourInfoService.getTotal(cri);
		log.info("total: " + total);
		
		model.addAttribute("pageMaker", new TourPageDTO(cri, total));
		model.addAttribute("cat", tourCatService.getcatList());
	}
	
	@PostMapping("/register")
	public String register(TourInfoDTO tourInfo, RedirectAttributes rttr, @ModelAttribute("cri") Criteria cri) {
		log.info("register: " + tourInfo);
		tourInfoService.register(tourInfo);
		
		rttr.addFlashAttribute("result", tourInfo.getTou_no());
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
	    rttr.addAttribute("keyword", cri.getKeyword());
		rttr.addAttribute("loc_no", cri.getLoc_no());
		
		return "redirect:/tourInfo/list";
	}
	
	@PreAuthorize("isAuthenticated() and (principal.username == 'admin01')")
	@GetMapping("/register")
	public void register(Criteria cri, Model model) {
		model.addAttribute("cri", cri);
	}
	
	@GetMapping({"/detail", "/update"})
	public void update(@RequestParam("tou_no") Long tou_no, Criteria cri, Model model,TourPickDTO pdto) {
		log.info("/detail or update");
		model.addAttribute("cri", cri);
		model.addAttribute("tourInfo", tourInfoService.detail(tou_no));
		model.addAttribute("cat", tourCatService.getcatList());
		model.addAttribute("pick", tourPickSevice.pickList(pdto));
	}
	
	@PreAuthorize("isAuthenticated() and (principal.username == 'admin01')")
	@PostMapping("/update")
	public String update(TourInfoDTO tourInfo, RedirectAttributes rttr,
							@ModelAttribute("cri") Criteria cri) {
		log.info(tourInfo);
		
		if(tourInfoService.update(tourInfo)) {
			rttr.addFlashAttribute("result", "success");
		}
		
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
	    rttr.addAttribute("keyword", cri.getKeyword());
	    rttr.addAttribute("loc_no", cri.getLoc_no());
		return "redirect:/tourInfo/list";
	}
	
	@PostMapping("remove")
	public String remove(@RequestParam("tou_no") Long tou_no, RedirectAttributes rttr,
							Criteria cri) {
		log.info(tou_no);
		
		if(tourInfoService.remove(tou_no)) {
			rttr.addFlashAttribute("result", "success");
		}
		
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
	    rttr.addAttribute("keyword", cri.getKeyword());
	    rttr.addAttribute("loc_no", cri.getLoc_no());
		return "redirect:/tourInfo/list";
	}
	
	@GetMapping(value = "/gettourAttachList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<TourAttachDTO>> getAttachList(Long tou_no) {
		log.info("getAttachList : " + tou_no);
		return new ResponseEntity<>(tourInfoService.gettourAttachList(tou_no), HttpStatus.OK);
	}
	
//	@GetMapping("pickPlus")
//	public String pickPlus(TourPickDTO pdto, RedirectAttributes rttr, Criteria cri, Model model) {
//		log.info("pickplus......." + pdto);
//		tourPickSevice.pickPlus(pdto);
//		
//		model.addAttribute("cri", cri);
//		rttr.addAttribute("tou_no", pdto.getTou_no());
//	    rttr.addAttribute("pageNum", cri.getPageNum());
//		rttr.addAttribute("amount", cri.getAmount());
//		rttr.addAttribute("type", cri.getType());
//	    rttr.addAttribute("keyword", cri.getKeyword());
//	    rttr.addAttribute("loc_no", cri.getLoc_no());
//	    
//		return "redirect:/tourInfo/detail";
//	}
	
//	@GetMapping("pickDelete")
//	public String pickRemove(TourPickDTO pdto, RedirectAttributes rttr, Criteria cri, Model model) {
//		log.info(pdto);
//		
//		if(tourPickSevice.pickRemove(pdto)) {
//			rttr.addFlashAttribute("result", "success");
//		}
//		
//		model.addAttribute("cri", cri);
//		rttr.addAttribute("tou_no", pdto.getTou_no());
//		rttr.addAttribute("pageNum", cri.getPageNum());
//		rttr.addAttribute("amount", cri.getAmount());
//		rttr.addAttribute("type", cri.getType());
//	    rttr.addAttribute("keyword", cri.getKeyword());
//	    rttr.addAttribute("loc_no", cri.getLoc_no());
//		return "redirect:/tourInfo/detail";
//	}
	
	@RequestMapping(value= "/pickPlus", method = RequestMethod.POST)
	@ResponseBody
	public int pickPlus(HttpServletRequest request, TourPickDTO pdto){
		if(pdto.getCheckpick() == 0) {
			tourPickSevice.pickPlus(pdto);
			return 1;
		} else {
			tourPickSevice.pickRemove(pdto);
			return 0;
		}
	}
	@GetMapping("/pickList")
	public void pickList(Principal principal, Criteria cri, Model model, HttpServletRequest request, TourPickDTO pdto) {
		
		String userid = principal.getName();
		
		pdto.setUserid(userid);
		List<String> list = tourInfoService.getTL(pdto);

		String interest = tourInfoService.getInterRest(userid);
		
		cri.setUserid(userid);
		cri.setTouNoList(list);
		cri.setInterest(interest);
		
		
		log.info("list: " + cri);
		model.addAttribute("list", tourInfoService.getList(cri));
		
		int total = tourInfoService.getTotal(cri);
		log.info("total: " + total);
		
		model.addAttribute("pageMaker", new TourPageDTO(cri, total));
		model.addAttribute("cat", tourCatService.getcatList());
	}
	
	
}
