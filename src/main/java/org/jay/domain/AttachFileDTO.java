package org.jay.domain;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class AttachFileDTO {
	private String fileName;
	private String uploadPath;
	private String uuid;
	private Boolean image;
	private Long bno;
	
}
