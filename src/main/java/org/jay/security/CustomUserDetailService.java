package org.jay.security;

import org.jay.domain.UserDTO;
import org.jay.mapper.UserMapper;
import org.jay.security.domain.CustomUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import lombok.extern.log4j.Log4j;

@Log4j
public class CustomUserDetailService implements UserDetailsService{
	
	@Autowired
	private UserMapper mapper;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		
		log.warn("load user by userName : " + username);
		
		UserDTO dto = mapper.read(username);
		
		log.warn("member mapper : " + dto);		
		
		return dto == null ? null : new CustomUser(dto);
	}
}
