package kh.sns.impl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import kh.sns.dto.MemberDTO;
import kh.sns.interfaces.MemberDAO;

@Component
public class IMemberDAO implements MemberDAO {
	@Autowired

	private JdbcTemplate template;


	@Override
	public int loginMem(MemberDTO dto) {		
		String sql = "select * from member where id=? and pw=?";
		return template.update(sql, dto.getId(), dto.getPw());
	}


	@Override
	public int signUp(MemberDTO dto) {
		// TODO Auto-generated method stub
		String sql = "insert into member values(?,?,?,?,?,?,?) ";
		return template.update(sql,dto.getId(),dto.getPw(),dto.getNickname(),dto.getEmail(),dto.getPhone(),dto.getGender(),dto.getName());
				
	}


	@Override
	public int isIdExist(String id) {
		// TODO Auto-generated method stub

		String sql = "SELECT * FROM MEMBER WHERE ID =?";
		return template.update(sql,new Object[] {id});		

	}
	
	
//	@Override
//	public boolean isIdExist(String id) throws Exception{
//		
//		String sql = "SELECT * FROM MEMBER WHERE ID =?";
//		return template.update(new Object[] {id});		
//
//	}
}