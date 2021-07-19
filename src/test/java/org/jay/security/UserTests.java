package org.jay.security;

import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.sql.DataSource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml",
						"file:src/main/webapp/WEB-INF/spring/security-context.xml"})
public class UserTests {
	
	@Setter(onMethod_ = @Autowired)
	private PasswordEncoder pwencoder;
	
	@Setter(onMethod_ = @Autowired)
	private DataSource ds;
	
//	@Test
//	public void testInsertUser() {
//		String sql = "insert into user_tbl(userid, userpw, username, email, addr, addr_detail, phone, interest) values(?,?,?,?,?,?,?,?)";
//		
//		Connection con = null;
//		PreparedStatement pstmt = null;
//		try {
//			con = ds.getConnection();
//			pstmt = con.prepareStatement(sql);
//			
//			pstmt.setString(1, "user02");
//			pstmt.setString(2, pwencoder.encode("upw02"));
//			pstmt.setString(3, "테스트");
//			pstmt.setString(4, "testforfindpw@gmail.com");
//			pstmt.setString(5, "서울시");
//			pstmt.setString(6, "강서구");
//			pstmt.setString(7, "010-1234-5698");
//			pstmt.setString(8, "여행");
//			
//			pstmt.executeUpdate();
//		} catch (Exception e) {
//			e.printStackTrace();
//		} finally {
//			try {
//				if(pstmt != null) {pstmt.close();}
//				if(con != null) {con.close();}
//			} catch (Exception e2) {
//				e2.printStackTrace();
//			}
//		}
//	} //end testInsertUser() method
	
//	@Test
//	public void testInsertAuth() {
//		String sql = "insert into auth_tbl(userid, auth) values(?,?)";
//		
//		Connection con = null;
//		PreparedStatement pstmt = null;
//		try {
//			con = ds.getConnection();
//			pstmt = con.prepareStatement(sql);
//				
//			pstmt.setString(1, "user02");
//			pstmt.setString(2, "role_user");
//				
//			pstmt.executeUpdate();
//		} catch (Exception e) {
//			e.printStackTrace();
//		} finally {
//			try {
//				if(pstmt != null) {pstmt.close();}
//				if(con != null) {con.close();}
//			} catch (Exception e2) {
//				e2.printStackTrace();
//			}
//		}
//	}
}
