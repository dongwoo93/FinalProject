package kh.sns.impl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import kh.sns.dto.Board_LocationDTO;
import kh.sns.dto.MemberDTO;
import kh.sns.interfaces.Board_LocationDAO;

@Repository
public class IBoard_LocationDAO implements Board_LocationDAO{
	
	@Autowired
	private JdbcTemplate template;
	
	@Override
	public int insertLocation(Board_LocationDTO dto) throws Exception {
		String sql = "insert into board_location values(?,?,?,?)";
		return template.update(sql,dto.getBoard_seq(), dto.getLocation_name(),dto.getLocation_latitude(),dto.getLocation_longitude());
	}

	@Override
	public List<Board_LocationDTO> selectLocation(String id) throws Exception{
		String sql = "select * from board_location where board_seq in( select board_seq from board where id=?)";
		
		return  template.query(sql, new Object[] {id}, new RowMapper<Board_LocationDTO>() {

			@Override
			public Board_LocationDTO mapRow(ResultSet rs, int arg1) throws SQLException {
				Board_LocationDTO dto = new Board_LocationDTO(rs.getInt(1),rs.getString(2),rs.getString(3),rs.getString(4));   
				return dto;
			}
		
		});
	}
}
