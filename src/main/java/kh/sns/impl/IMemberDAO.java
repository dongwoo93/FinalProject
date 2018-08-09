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
	public List<MemberDTO> selectfriendlist(String id,String searchtext) throws Exception{
		String sql = "select nickname from member where id in(select id from member_follow where target_id=? and id in(select target_id from member_follow where id=?)) and nickname like '%'||?||'%'";
		
		return template.query(sql, new String[] {id,id,searchtext}, new RowMapper<MemberDTO>() {

			@Override
			public MemberDTO mapRow(ResultSet rs, int arg1) throws SQLException {
				MemberDTO dto = new MemberDTO("","",rs.getString(1),"","","","");   
				return dto;
			}

			
		});
	}
	
//	@Override
//	public boolean isIdExist(String id) throws Exception{
//		
//		String sql = "SELECT * FROM MEMBER WHERE ID =?";
//		return template.update(new Object[] {id});		
//
//	}
}