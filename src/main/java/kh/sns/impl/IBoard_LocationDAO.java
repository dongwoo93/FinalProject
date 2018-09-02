package kh.sns.impl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import kh.sns.dto.BoardDTO;
import kh.sns.dto.Board_LocationDTO;
import kh.sns.dto.MyMapDTO;
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
		String sql = "select * from board_location where board_seq in(select max(board_seq) from board_location where board_seq in( select board_seq from board where id=?) group by location_latitude, location_longitude)";
		
		return  template.query(sql, new Object[] {id}, new RowMapper<Board_LocationDTO>() {

			@Override
			public Board_LocationDTO mapRow(ResultSet rs, int arg1) throws SQLException {
				Board_LocationDTO dto = new Board_LocationDTO(rs.getInt(1),rs.getString(2),rs.getString(3),rs.getString(4));   
				return dto;
			}
		
		});
	}
	
	@Override
	public List<BoardDTO> getBoard(String id,String lat,String lng) throws Exception{
		String sql = "select * from board where id =? and board_seq in(select board_seq from board_location where location_latitude=? and location_longitude=?)";
		
		return  template.query(sql, new Object[] {id,lat,lng}, new RowMapper<BoardDTO>() {

			@Override
			public BoardDTO mapRow(ResultSet rs, int arg1) throws SQLException {
				BoardDTO dto = new BoardDTO(rs.getInt(1),rs.getString(2),rs.getString(3),rs.getString(4),rs.getString(5),rs.getString(6));   
				return dto;
			}
		
		});
	}
	
	@Override
	public int setMyMap(String id,String cluster,String pin) throws Exception {
		String sql = "update mymap set pinimg = ? , clusterimg = ? where id=?";
		return template.update(sql,pin,cluster,id);
	}
	
	@Override
	public int insertMyMap(String id) throws Exception {
		String sql = "insert into mymap values(?,default,default)";
		return template.update(sql,id);
	}
	
	@Override
	public MyMapDTO selectMyMap(String id) throws Exception {
		
		String sql = "select * from mymap where id = ?";
		List<MyMapDTO> result =  template.query(sql, new String[] {id}, new RowMapper<MyMapDTO>() {

			@Override   
			public MyMapDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
				// TODO Auto-generated method stub
				MyMapDTO mymap = new MyMapDTO();
				mymap.setId(rs.getString(1));
				mymap.setPinimg(rs.getString(2));
				mymap.setClusterimg(rs.getString(3));
				return mymap;
			}
		});
		
		return result.get(0);
		}
}
