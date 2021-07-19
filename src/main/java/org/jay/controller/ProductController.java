package org.jay.controller;

import java.io.File;
import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.jay.domain.ProductDTO;
import org.jay.domain.BuyListDTO;
import org.jay.domain.CartDTO;
import org.jay.domain.ProductCriteria;
import org.jay.domain.ProductPageDTO;
import org.jay.domain.StarRatingDTO;
import org.jay.domain.UserDTO;
import org.jay.service.CartService;
import org.jay.service.MemberService;
import org.jay.service.PayService;
import org.jay.service.ProductCategoryService;
import org.jay.service.ProductReplyService;
import org.jay.service.ProductService;
import org.jay.utils.UploadFileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@AllArgsConstructor
@Controller
@Log4j
@RequestMapping("/product/*")
public class ProductController {
	
	@Autowired
	private ProductService service;
	
	@Autowired
	private String uploadPath;
	
	@Autowired
	private ProductCategoryService ProductCategoryService;
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private PayService payService;
	
	@Autowired
	private CartService cartService;
	
	@Autowired
	private ProductReplyService prService;
	
	
	@GetMapping("/list")
	public void list(Model model, ProductCriteria cri) {
		log.info("list : " + cri);
		model.addAttribute("list", service.getList(cri));
		
		int total = service.getTotal(cri);
		log.info("total : " + total);
		
		model.addAttribute("pageMaker", new ProductPageDTO(cri, total));
		model.addAttribute("category", ProductCategoryService.getCategoryList());
	}
	
	@PostMapping("/register")
	public String register(ProductDTO product, RedirectAttributes rttr, MultipartFile file, ProductCriteria cri) throws Exception{
		
		String imgUploadPath = uploadPath + File.separator + "imgUpload";
		String ymdPath = UploadFileUtils.calcPath(imgUploadPath);
		String fileName = null;

		if(file != null) {
		 fileName =  UploadFileUtils.fileUpload(imgUploadPath, file.getOriginalFilename(), file.getBytes(), ymdPath); 
		}else {
		 fileName = uploadPath + File.separator + "images" + File.separator + "none.png";
		}
		
		product.setP_Img(File.separator + "imgUpload" + ymdPath + File.separator + fileName);
		product.setPThumbImg(File.separator + "imgUpload" + ymdPath + File.separator + "s" + File.separator + "s_" + fileName);
		
		log.info("register...." + product);
		
		// 실제 데이터 삽입 완료
		service.register(product);
		rttr.addFlashAttribute("result", product.getPno());
		
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
    	rttr.addAttribute("keyword", cri.getKeyword());
    	rttr.addAttribute("catenum", cri.getCatenum());
		
		return "redirect:/product/list";
	}
	
	@PreAuthorize("isAuthenticated() and (principal.username == 'admin01')")
	@GetMapping("/register")
	public void register(ProductCriteria cri, Model model) {
		model.addAttribute("cri", cri);
	}
	
	@GetMapping({"/get", "/modify"})
	public void modify(Model model, @RequestParam("pno") Long pno, @ModelAttribute("cri") ProductCriteria cri, Principal principal) {
		log.info("/get or /modify");
		// 상품 정보
		ProductDTO product = service.get(pno);
		
		// 리뷰 수
		int reviewCnt = product.getReplyCnt();
		
		// score 변수 선언
		String score ="";
		
		// score 값 담기
		if(reviewCnt == 0) {
			score = "0";
		}else {
			// 리뷰 별점 합산
			int totalScore = prService.totalScore(pno);
			
			log.info(reviewCnt);
			log.info(totalScore);
			
			// 별점의 평점
			double avg = (totalScore / (double)reviewCnt);
			log.info(avg);
			
			if(avg > 0 && avg <= 1) {score = "1";}
			else if(avg > 1 && avg <= 1.5) {score = "1.5";}
			else if(avg > 1.5 && avg <= 2) {score = "2";}
			else if(avg > 2 && avg <= 2.5) {score = "2.5";}
			else if(avg > 2.5 && avg <= 3) {score = "3";}
			else if(avg > 3 && avg <= 3.5) {score = "3.5";}
			else if(avg > 3.5 && avg <= 4) {score = "4";}
			else if(avg > 4 && avg <= 4.9) {score = "4.5";}
			else if(avg > 4.9) {score = "5";}
		}
		
		log.info("이 상품의 별점 : " + score);
		
		// 상품 전체 별점
		model.addAttribute("score", score);
		
		// 상품 정보
		model.addAttribute("product", product); 
	}
	
	@PostMapping("/modify")
	public String modify(ProductDTO product, RedirectAttributes rttr, ProductCriteria cri, MultipartFile file, HttpServletRequest req ) throws Exception {
		log.info("/modify..." + product);
		
		// 새로운 파일이 등록되었는지 확인
		 if(file.getOriginalFilename() != null && file.getOriginalFilename() != "") {
		  // 기존 파일을 삭제
		  new File(uploadPath + req.getParameter("gdsImg")).delete();
		  new File(uploadPath + req.getParameter("gdsThumbImg")).delete();
		  
		  // 새로 첨부한 파일을 등록
		  String imgUploadPath = uploadPath + File.separator + "imgUpload";
		  String ymdPath = UploadFileUtils.calcPath(imgUploadPath);
		  String fileName = UploadFileUtils.fileUpload(imgUploadPath, file.getOriginalFilename(), file.getBytes(), ymdPath);
		  
		  product.setP_Img(File.separator + "imgUpload" + ymdPath + File.separator + fileName);
		  product.setPThumbImg(File.separator + "imgUpload" + ymdPath + File.separator + "s" + File.separator + "s_" + fileName);
		  
		 } else {  // 새로운 파일이 등록되지 않았다면
		  // 기존 이미지를 그대로 사용
			 product.setP_Img(req.getParameter("gdsImg"));
			 product.setPThumbImg(req.getParameter("gdsThumbImg"));
		  
		 }
		 
		service.modify(product);
		
		
		if(service.modify(product)) {
			rttr.addFlashAttribute("result", "success");
		}
		
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword" , cri.getKeyword());
		rttr.addAttribute("catenum", cri.getCatenum());
		
		return "redirect:/product/list";
	}
	
	// 삭제는 반드시 POST 방식으로만 처리한다!!!!!!!!
	@PostMapping("/remove")
	public String remove(@RequestParam("pno") Long pno,
						RedirectAttributes rttr, ProductCriteria cri) {
		log.info("/remove..." + pno);
		
		if(service.remove(pno)) {
			rttr.addFlashAttribute("result", "success");
		}
		
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword" , cri.getKeyword());
		rttr.addAttribute("catenum", cri.getCatenum());
		
		return "redirect:/product/list";
	}
	
	@PostMapping("/payment")
	public void payment(Principal principal, Model model, Long pno, int prodAmount) {
		log.info("회원 정보 : " + principal.getName());
		
		// 구매 회원 정보 가져오고 저장
		String userid = principal.getName();
		UserDTO dto = memberService.readMember(userid);
		model.addAttribute("uInfo", dto);
		
		// 구매 상품 정보 가져오고 저장
		model.addAttribute("prodInfo", service.get(pno));
		
		// 구매 상품 수량 저장
		model.addAttribute("prodAmount", prodAmount);
	}
	
	@PostMapping("/payAll")
	public void payAll(String userid, Model model) {
		
		// 구매 회원 정보 가져오고 저장
		UserDTO userDTO = memberService.readMember(userid);
		model.addAttribute("uInfo", userDTO);
		
		// 장바구니 정보 가져오고 저장
		List<CartDTO> cartDTO = cartService.getAllCartList(userid);
		model.addAttribute("cartList", cartDTO);
		
		// 전체 상품 가격 구해오고 저장
		int totalPrice = cartService.getAllPrice(userid);
		model.addAttribute("totalPrice", totalPrice);
	}
	
	@PostMapping("/paySuccess")
	public void paySuccess(Model model, BuyListDTO buyDTO) {
		
		log.info(buyDTO.getRecvAddr());
		log.info(buyDTO.getAmount());
		
		int result = payService.doPay(buyDTO);
		if(result == 1) {
			log.info("-----구매 및 결제를 성공했습니다------");
		}else {
			log.info("@@@@ 에러 발생 @@@@");
		}
		
		// 구매 상품 정보 가져오고 저장
		model.addAttribute("prodInfo", service.get(buyDTO.getPno()));
		
		// 구매 수량 저장
		model.addAttribute("amount", buyDTO.getAmount());
	}
	
	@PostMapping("/payAllSuccess")
	public void payAllSuccess(Model model, String allInfo, String allCartpno, String user) {
		// 받아온 insert 정보들
		log.info(allInfo);
		
		// 마지막 구분자 (!) 제거
		String allBuyInfo = allInfo.substring(0, allInfo.length()-1);
		log.info(allBuyInfo);
		
		// 배열로 쪼개서 for문으로 insert문 날리기
		// tuple(row)로 나누기
		String[] spTuple = allBuyInfo.split("!");
		
		// 넘길 변수들 선언
		String userid;
		Long pno;
		int amount;
		String recvName;
		String recvPhone;
		String recvAddr;
		String shipRequest;
		
		// 넘길 변수 중 총 가격
		int totalPrice = 0;
		
		// 선언한 변수들에 값 split으로 넣고 tuple 하나씩 insert
		for(int i = 0; i < spTuple.length; i++) {
			userid = spTuple[i].split(",")[0];
			pno = Long.parseLong(spTuple[i].split(",")[1]);
			amount = Integer.parseInt(spTuple[i].split(",")[2]);
			recvName = spTuple[i].split(",")[3];
			recvPhone = spTuple[i].split(",")[4];
			recvAddr = spTuple[i].split(",")[5];
			shipRequest = spTuple[i].split(",")[6];
			
			// 구매하는 상품들의 전체 합산 가격 구하기
			int price = Integer.parseInt(service.get(pno).getPrice());
			totalPrice += price;
			
			BuyListDTO dto = new BuyListDTO();
			dto.setUserid(userid);
			dto.setPno(pno);
			dto.setAmount(amount);
			dto.setRecvName(recvName);
			dto.setRecvPhone(recvPhone);
			dto.setRecvAddr(recvAddr);
			dto.setShipRequest(shipRequest);
			
			int result = payService.doPay(dto);
			if(result == 1) {
				log.info("장바구니의" + i + "번째 상품 구매 완료!!!!");
			};
		};
		
		// 장바구니 정보 가져오고 구매 확정 내용 보여주기 위해 저장
		List<CartDTO> cartDTO = cartService.getAllCartList(user);
		model.addAttribute("buyList", cartDTO);
		model.addAttribute("totalPrice", totalPrice);
		
		// 장바구니에 있던 값 delete하기
		String[] spCartPno = allCartpno.split(",");
		for(int i = 0; i < spCartPno.length; i++) {
			int cartpno = Integer.parseInt(spCartPno[i]);
			
			int result = cartService.removeCart(cartpno);
			if(result == 1) {
				log.info(cartpno + "상품 장바구니에서 delete!!!!");
			}
		}
	}
	
	@PreAuthorize("isAuthenticated()")
	@RequestMapping(value = "/buyList", method = RequestMethod.GET)
	public void buyList(Principal principal, Model model) {
		
		log.info("@ProductController / userid : " + principal.getName());
		
		// 로그인 계정의 id를 파라미터로 구매목록 불러오기
		BuyListDTO dto = new BuyListDTO();
		dto.setUserid(principal.getName());
		
		// 구매목록이 복수일 경우가 있으므로 List형태로 return값 받는다 (여기에 지금 amount / buyDate 있음)
		List<BuyListDTO> buyDTO = service.buyList(dto);
		log.info("@ProductController / buyDTO의 길이 : " + buyDTO.size());
		
		// buyDTO의 pno 리스트를 기준으로 값을 다시 리스트 형태로 담을 것이기 때문에 List형태
		List<ProductDTO> prodDTOList = new ArrayList<ProductDTO>();
		
		for(int i = 0; i < buyDTO.size(); i++) {
			Long pno = buyDTO.get(i).getPno();
			log.info("@ProductController / pno : " + pno);
			
			ProductDTO prodDTO = service.get(pno);
			prodDTOList.add(prodDTO);
		}
		
		// ProductDTO를 기준으로 image / pname / price를 넘겨줌
		model.addAttribute("buyList1", prodDTOList);
		
		// BuyListDTO를 기준으로 amount / buyDate를 넘겨줌
		model.addAttribute("buyList2", buyDTO);
	}
	
	// 리뷰 작성 페이지
	@RequestMapping(value = "/writeReview", method = RequestMethod.GET)
	public void writeReview(Model model, Long pno, String pname, Principal principal) {
		model.addAttribute("pno", pno);
		model.addAttribute("pname", pname);
		model.addAttribute("userid", principal.getName());
	}
	
	
	
	
	
	
	
	
	
	
}