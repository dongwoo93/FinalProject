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
	
	
//	@Override
//	public boolean isIdExist(String id) throws Exception{
//		
//		String sql = "SELECT * FROM MEMBER WHERE ID =?";
//		return template.update(new Object[] {id});		
//
//	}
}