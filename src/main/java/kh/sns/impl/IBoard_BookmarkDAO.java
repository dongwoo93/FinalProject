package kh.sns.impl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import kh.sns.dto.Board_BookmarkDTO;
import kh.sns.dto.Board_LikeDTO;
import kh.sns.interfaces.Board_BookmarkDAO;

@Repository	
public class IBoard_BookmarkDAO implements Board_BookmarkDAO {
	
	@Autowired
	private JdbcTemplate template;

	@Override
	public int selectBookmark(Board_BookmarkDTO dto) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int insertBookmark(Board_BookmarkDTO dto) throws Exception {
		String sql = "insert into board_bookmark values(?,?,?)";
		return template.update(sql,dto.getBoard_seq(), dto.getId(),dto.getIs_marked());
	}

	@Override
	public int deleteBookmark(Board_BookmarkDTO dto) throws Exception {
		String sql = "delete from board_bookmark where board_seq=? and id=?";
		return template.update(sql,dto.getBoard_seq(), dto.getId());
	}

	@Override
	public List<Integer> searchMark(String id) throws Exception {
		String sql = "select board_seq from board_bookmark where id=?";
		return template.query(sql, new Object[] {id},new RowMapper<Integer>() {

			@Override
			public Integer mapRow(ResultSet rs, int rowNum) throws SQLException {
				
				return rs.getInt("board_seq");
			}
	});
	}
	
	@Override
	public Board_BookmarkDTO isBookmarked(String id, int board_seq) throws Exception {
		
				Board_BookmarkDTO result = null;
				
				String sql = "select * from board_bookmark where id=? and board_seq=?";
				List<Board_BookmarkDTO> an = template.query(sql, new Object[] {id , board_seq}, new RowMapper<Board_BookmarkDTO>() {

					@Override
					public Board_BookmarkDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
						// TODO Auto-generated method stub
						Board_BookmarkDTO isBookmarked= new Board_BookmarkDTO();
					
						isBookmarked.setBoard_seq(rs.getInt("board_seq"));
						isBookmarked.setId(rs.getString("id"));
						isBookmarked.setIs_marked(rs.getString("is_marked"));
						return isBookmarked;
					}} );	
				
				if(an.size()>0) { 
					return an.get(0);
				}
				return result;
			}
	}


