package kh.sns.impl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import kh.sns.dto.BoardDTO;
import kh.sns.interfaces.BoardDAO;

@Repository
public class IBoardDAO implements BoardDAO  {
	
	@Autowired
	private JdbcTemplate template;
	
	@Override
	public List<BoardDTO> getBoard(String id) {		 
		String sql = "select * from board where id = ?";
		return template.query(sql, new Object[] {id}, new RowMapper<BoardDTO>() {
			
			@Override
			public BoardDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
				BoardDTO tmp = new BoardDTO();
				tmp.setBoard_seq(rs.getInt(1));
				tmp.setContents(rs.getString(2));
				tmp.setId(rs.getString(3));
				tmp.setWritedate(rs.getString(4));
				tmp.setRead_count(rs.getString(5));
				tmp.setIs_allow_comments(rs.getString(6));
				return tmp;
			}
		});
	}

	@Override
	public List<BoardDTO> search(String keyword) {
		String sql = "select * from board where contents like '%'||?||'%'";
		return template.query(sql, new Object[] {keyword}, new RowMapper<BoardDTO>() {

			@Override
			public BoardDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
				BoardDTO tmp = new BoardDTO();
				tmp.setBoard_seq(rs.getInt(1));
				tmp.setContents(rs.getString(2));
				tmp.setId(rs.getString(3));
				tmp.setWritedate(rs.getString(4));
				tmp.setRead_count(rs.getString(5));
				tmp.setIs_allow_comments(rs.getString(6));
				return tmp;
			}
		});
	}

	@Override
	public List<BoardDTO> getFeed(String id) throws Exception {
		String sql = "select * from board where id=? order by board_seq desc";
		return template.query(sql, new String[] {id}, new RowMapper<BoardDTO>() {

			@Override
			public BoardDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
				 BoardDTO dto = new  BoardDTO();
				dto.setBoard_seq(rs.getInt("board_seq"));
				dto.setContents(rs.getString("contents"));
				dto.setId(rs.getString("id"));
				dto.setWritedate(rs.getString("writedate"));
				dto.setRead_count(rs.getString("read_count"));
				dto.setIs_allow_comments(rs.getString("is_allow_comments"));
				return dto;
			}
		});
	}

}
