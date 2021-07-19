package org.jay.mapper;

import org.jay.domain.UserDTO;

public interface LoginMapper {
	
	public String findID(UserDTO userdto);
	public int updatePW(UserDTO userdto) throws Exception;
}
