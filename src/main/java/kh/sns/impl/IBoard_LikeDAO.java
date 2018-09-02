package kh.sns.impl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import kh.sns.dto.Board_LikeDTO;
import kh.sns.interfaces.Board_LikeDAO;

@Repository
public class IBoard_LikeDAO implements Board_LikeDAO {
	
	@Autowired
	private JdbcTemplate template;
	
	@Override
	public int selectLike(Board_LikeDTO dto) throws Exception {
		String sql = "select count(*) from board_like where board_seq=?";
		List<Integer> list = template.query(sql, new Object[] {dto.getBoard_seq()}, new RowMapper<Integer>() {
			@Override
			public Integer mapRow(ResultSet rs, int rowNum) throws SQLException {
				return rs.getInt("count(*)");
			}
		}); 
		System.out.println(list.get(0));
		return list.get(0);
	}
	
	@Override
	public int insertLike(Board_LikeDTO dto) throws Exception {
		String sql = "insert into board_like values(?,?,?,default)";  
		return template.update(sql,dto.getBoard_seq(), dto.getId(),dto.getIs_liked());
	}

	@Override  
	public int deleteLike(Board_LikeDTO dto) throws Exception {
		String sql = "delete from board_like where board_seq=? and id=?";
		return template.update(sql,dto.getBoard_seq(), dto.getId());
	}

	@Override
	public List<Integer> searchLike(String id) throws Exception {
		String sql = "select board_seq from board_like where id=?";
		return template.query(sql, new Object[] {id},new RowMapper<Integer>() {

			@Override
			public Integer mapRow(ResultSet rs, int rowNum) throws SQLException {
				
				return rs.getInt("board_seq");
			}
	});
	}

	@Override
	public List<int[]> selectLikeCount() throws Exception {
		String sql = "select board_seq, count(*) from board_like GROUP by board_seq";
		
		return template.query(sql,new RowMapper<int[]>() {

			@Override
			public int[] mapRow(ResultSet rs, int rowNum) throws SQLException {
				int[] list = {rs.getInt("board_seq"), rs.getInt("count(*)")};
				return list;
			}
			
		});
		
	
	}

	@Override
	public int insertLiko(Board_LikeDTO dto) throws Exception {
		// TODO Auto-generated method stub
		int result = 0;
		
		String sql = "insert into board_like values(?,?,?,default)";
		result =template.update(sql, dto.getBoard_seq(), dto.getId() , dto.getIs_liked());
		return result;
	}

	@Override
	public Board_LikeDTO isLiked(String id, int board_seq) throws Exception {
		// TODO Auto-generated method stub
		Board_LikeDTO result = null;
		
		String sql = "select * from board_like where id=? and board_seq=?";
		List<Board_LikeDTO> an = template.query(sql, new Object[] {id , board_seq}, new RowMapper<Board_LikeDTO>() {

			@Override
			public Board_LikeDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
				// TODO Auto-generated method stub
				Board_LikeDTO isLiked = new Board_LikeDTO();
			
				isLiked.setBoard_seq(rs.getInt("board_seq"));
				isLiked.setId(rs.getString("id"));
				isLiked.setIs_liked(rs.getString("is_liked"));
				isLiked.setApply_date(rs.getString("apply_date"));
				return isLiked;
			}} );	
		  
		if(an.size()>0) {
			return an.get(0);
		}
		return result; 
	}
	
	//BestLike
	@Override
	public List<int[]> bestLike() throws Exception {
		String sql = "SELECT BOARD_SEQ, COUNT(*) FROM BOARD_LIKE GROUP BY BOARD_SEQ ORDER BY 2 DESC";
		
		return template.query(sql,new RowMapper<int[]>() {

			@Override
			public int[] mapRow(ResultSet rs, int rowNum) throws SQLException {
				int[] list = {rs.getInt("board_seq"), rs.getInt("count(*)")};
				return list;
			}
			
		});
	}
	
	// BestLike by Range
	@Override
	public List<int[]> bestLike(int start, int end) throws Exception {
		String sql = "select mid.* from (select inner.*, rownum rn from (SELECT BOARD_SEQ, COUNT(*) "
				+ "FROM BOARD_LIKE GROUP BY BOARD_SEQ ORDER BY 2 DESC) inner) mid where rn between ? and ?";
		
		return template.query(sql, new Object[] {start, end}, new RowMapper<int[]>() {

			@Override
			public int[] mapRow(ResultSet rs, int rowNum) throws SQLException {
				int[] list = {rs.getInt(1), rs.getInt(2)};
				return list;
			}
			
		});
	}
}
