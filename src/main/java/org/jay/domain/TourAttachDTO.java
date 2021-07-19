package org.jay.domain;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class TourAttachDTO {
	private String tou_image;
	private String uploadPath;
	private String uuid;
	private boolean fileType;
	private Long tou_no;
	
}
