package org.jay.domain;

import java.util.List;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
@Getter
@Setter
public class UserDTO {
	private String userid;
	private String userpw;
	// 비밀번호 변경용
	private String userpw1;
	private String username;
	private String email;
	private String addr;
	private String addr_detail;
	private String phone;
	private String interest;
	private boolean enabled;
	private String postcode;
	
	private List<AuthDTO> authList;
}
