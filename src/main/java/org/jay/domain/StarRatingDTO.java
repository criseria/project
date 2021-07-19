package org.jay.domain;

import lombok.Data;

@Data
public class StarRatingDTO {
	private Long pno;
	private int score;
	private String userid;
}
