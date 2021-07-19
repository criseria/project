package org.jay.domain;

import java.util.List;

import lombok.Data;

@Data
public class TourInfoDTO {
	
	private Long tou_no;
	private int loc_no;
	private String tou_title;
	private String tou_name;
	private String tou_addr;
	private String tou_content;
	private double tou_lat;
	private double tou_lng;
	private int read_cnt;
	private String tou_image;
	private String tou_time;
	private String tou_homepage;
	private String tou_inter;
	private String loc_name;
	private String tou_image2;
	private String tou_image3;
	
	private List<TourAttachDTO> tourAttachList;
}
