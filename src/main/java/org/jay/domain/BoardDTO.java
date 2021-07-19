package org.jay.domain;

import java.sql.Date;
import java.util.List;

import lombok.Data;

@Data
public class BoardDTO {
	private Long bno;
	private String title;
	private String content;
	private String writer;
	private Date regdate;
	private Date updatedate;
	
	private int replycnt;
	
	
	// 게시글 등록 시 한번에 BoardAttachVO 같이 처리할 수 있도록
	private List<BoardAttachDTO> attachList;
}
