package org.jay.controller;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.jay.domain.CartDTO;
import org.jay.service.CartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@AllArgsConstructor
@Controller
@Log4j
@RequestMapping("/product/*")
public class CartController {
	
	@Autowired
	private CartService cartService;
	
	// 장바구니 담기
	@RequestMapping(value= "/addCart", method = RequestMethod.POST)
	@ResponseBody
	public int addCart(HttpServletRequest request, CartDTO dto) {
		
		log.info("장바구니에 담은 상품 수량!!!! : " + dto.getAmount());
		
		Long pno = dto.getPno();
		String userid = dto.getUserid();
		
		int add = cartService.addCart(dto);
		
		if(add == 1) {
			return 1;
		}else {
			return 0;
		}
	}

	// 장바구니 목록
	@GetMapping("/cartlist")
	public void cartlist(Principal principal, Model model) {
		
		// 장바구니 목록 읽기
		List<CartDTO> cartList = cartService.getAllCartList(principal.getName());
		
		model.addAttribute("cartList", cartList);
	}
	
	
	// 장바구니 해제
	@RequestMapping(value= "/removeCart", method = RequestMethod.POST)
	public String removeCart(HttpServletRequest request, int cartpno) {
		
		log.info("여기까지는 오는가 : " + cartpno);
		
		int remove = cartService.removeCart(cartpno);
		
		return "redirect:/product/cartlist";
	}
	
	
}
