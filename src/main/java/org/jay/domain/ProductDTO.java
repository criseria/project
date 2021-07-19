package org.jay.domain;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ProductDTO {
	private Long pno;
	private int catenum;
	private String pname;
	private String price;
	private String pcontent;
	private Date regdate;
	private String image;
	
	private int replyCnt;
	
	private String p_Img;
	
	private String PThumbImg;
}
