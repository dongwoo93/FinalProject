package kh.sns.impl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import kh.sns.dto.Member_BlockDTO;
import kh.sns.interfaces.Member_BlockDAO;

@Repository
public class IMember_BlockDAO implements Member_BlockDAO {
	
	@Autowired
	private JdbcTemplate template;

	@Override
	public int insertBlock(Member_BlockDTO dto) throws Exception {
		String sql = "insert into member_block values(?, ?, sysdate)";
		return template.update(sql, dto.getId(), dto.getTarget_id());
	}

	@Override
	public int deleteBlock(Member_BlockDTO dto) throws Exception {
		String sql = "delete member_block where id=? and target_id=?";
		return template.update(sql, dto.getId(), dto.getTarget_id());
	}

	@Override
	public List<Member_BlockDTO> selectBlock(String id) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}
	
	public boolean isBlock(String sessionid, String id) throws Exception {
		String sql = "select * from member_block where id=? and target_id=?";
		boolean result = false;
		List<Member_BlockDTO> list = template.query(sql, new String[] {id,sessionid}, new RowMapper<Member_BlockDTO>() {

			@Override
			public Member_BlockDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
				return new Member_BlockDTO(rs.getString("id"), rs.getString("target_id"),rs.getString("block_date"));
			}
			
		});
		
		if(list.size() ==1) {
			result=true;
		}
		return result;
	}

}
