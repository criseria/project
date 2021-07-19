package org.jay.domain;

import lombok.Data;

@Data
public class ProductPageDTO {
	private int startPage;			
	private int endPage;			
	private boolean prev, next;		
	private int total;				
	private ProductCriteria cri;
	
	// 페이지 번호를 10개씩 본다는 가정하에~
	public ProductPageDTO(ProductCriteria cri, int total) {
		this.total = total;
		this.cri = cri;
		
		this.endPage = (int)(Math.ceil(cri.getPageNum() / 10.0)) * 10;
		// 1 페이지 : Math.ceil(0.1) * 10 = 10
		// 10 페이지 : Math.ceil(1) * 10 = 10
		// 11 페이지 : Math.ceil(1.1) * 10 = 20
		
		this.startPage = this.endPage - 9;
		// 만약 10개씩 보여준다면 시작 번호는 무조건 끝 번호에서 9만큼 빼면 된다.
		// ex) 2 3 4 5 6 7 8 9 10 11
		
		
		int realEnd = (int)(Math.ceil((total * 1.0) / cri.getAmount()));
		
		if(realEnd < this.endPage) {
			this.endPage = realEnd;
		}
		// 전체 데이터 수(total)가 80이면 끝 번호(endPage)는 8이 되어야 한다.
		// 만약 끝 번호(endPage)와 한 페이지당 출력되는 데이터 수(amount)의 곱이
		// 전체 데이터 수(total)보다 크면 ex) 11 * 10 > 80
		// 다시 total을 이용해서 계산해야 한다.
		
		this.prev = this.startPage > 1;	// 1보다 크면 무조건 true
		this.next = this.endPage < realEnd;	// 현재 끝 번호보다 실제 끝 페이지가 더 크면
	}
}
