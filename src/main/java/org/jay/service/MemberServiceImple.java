package org.jay.service;

import javax.inject.Inject;

import org.apache.ibatis.jdbc.SQL;
import org.jay.domain.UserDTO;
import org.jay.mapper.BoardAttachMapper;
import org.jay.mapper.MemberMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Setter;

@Service
public class MemberServiceImple implements MemberService {

	@Setter(onMethod_ = @Autowired)
	private MemberMapper memberMapper;
	
	@Override
	public UserDTO loginMember(UserDTO dto) {
		return null;
	}
	
	//회원가입
	@Override
	public void insertMember(UserDTO dto) {
		//컨트롤러 -> 서비스 호출 -> DAO 호출 -> Mapper -> DB
		System.out.println("S : 회원가입동작");
		if(dto == null) {
			//처리
			return;
		}
		memberMapper.insertMember(dto);
	}

	//아이디 중복확인
	@Override
	public int idChk(UserDTO dto) {
		int result = memberMapper.idChk(dto);
		return result;
	}

	// 회원정보 불러오기
	@Override
	public UserDTO readMember(String userid) {
		return memberMapper.readMember(userid);
	}
	
	//회원정보수정 (비번 외)
	@Override
	public void usermodify(UserDTO dto) {
		try {
			memberMapper.usermodify(dto);
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	//회원정보수정 (비번)
	@Override
	public void pwmodify(UserDTO dto) {
		try {
			memberMapper.pwmodify(dto);
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// 회원탈퇴 시 권한 테이블에 해당 유저 삭제
	@Override
	public int deleteAuth(String userid) {
		return memberMapper.deleteAuth(userid);
	}
	
	//회원정보삭제
	@Override
	public void deleteMember(UserDTO dto) {
		try {
			memberMapper.deleteMember(dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// 비밀번호 확인
	@Override
	public int pwChk(UserDTO dto) {
		int result = memberMapper.pwChk(dto);
		return result;
	}
	
}