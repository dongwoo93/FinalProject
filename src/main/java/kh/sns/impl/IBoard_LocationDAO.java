package kh.sns.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import kh.sns.dto.Board_LocationDTO;
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
}
