package kh.sns.impl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;


import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import kh.sns.dto.BoardDTO;
import kh.sns.dto.Board_CommentDTO;
import kh.sns.interfaces.Board_CommentDAO;

@Repository
public class IBoard_CommentDAO implements Board_CommentDAO {

	@Autowired
	private JdbcTemplate template;

	@Autowired
	private SqlSessionTemplate sqltemplate;

	@Override
	public int insertComment(Board_CommentDTO dto) throws Exception {
		String sql = "insert into board_comment values(?,?,?,?,default)";
		System.out.println(dto.getComment_contents() + " : " + dto.getId() + " : " + dto.getBoard_seq()); 
		return template.update(sql, dto.getComment_seq(),dto.getBoard_seq(),dto.getId(),dto.getComment_contents()); 
	}

	@Override
	public List<Board_CommentDTO> getFeedComment(String id) throws Exception {
		return sqltemplate.selectList("Board.getFeedComment", id);
	}

	@Override
	public int delComment(int comment_seq) throws Exception {
		System.out.println(comment_seq);
		String sql = "delete from board_comment where comment_seq=?";
		return template.update(sql,comment_seq);
	}
 
	@Override
	public int getCommentSeq() throws Exception {
		String sql = "select BOARD_COMMENT_SEQ.nextval from dual";
		List<Integer> list = template.query(sql, new RowMapper<Integer>() {

			@Override
			public Integer mapRow(ResultSet rs, int rowNum) throws SQLException {
				return rs.getInt("nextval");
			}
		});
 
		System.out.println(list.get(0));
		return list.get(0);
	}

	@Override
	public int modComment(Board_CommentDTO dto) {   
		
		String sql = "update board_comment set comment_contents = ? where comment_seq=?";
		return template.update(sql,dto.getComment_contents(), dto.getComment_seq());
	}
	
	public int commentCount(int board_seq) throws Exception {
		String sql = "select count(*) from board_comment where board_seq = ?";
		List<Integer> list = template.query(sql, new Object[] {board_seq}, new RowMapper<Integer>() {

			@Override
			public Integer mapRow(ResultSet rs, int rowNum) throws SQLException {
				return rs.getInt("count(*)");
			}
		});
		
		return list.get(0);
	}
	
	@Override
	public List<int[]> selectCommentCount() throws Exception {
			String sql = "select board_seq, count(*) from board_comment GROUP by board_seq";
		
		return template.query(sql,new RowMapper<int[]>() {

			@Override
			public int[] mapRow(ResultSet rs, int rowNum) throws SQLException {
				int[] list = {rs.getInt("board_seq"), rs.getInt("count(*)")};
				return list;
			}
			
		});
		
	}

	@Override 
	public List<Board_CommentDTO> getCommentList(int board_seq) throws Exception {    
		// TODO Auto-generated method stub
		String sql = "select * from board_comment where board_seq=? order by comment_seq";
		  
		return template.query(sql, new Object[] {board_seq}, new RowMapper<Board_CommentDTO>() {

			@Override
			public Board_CommentDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
				
				Board_CommentDTO result = new Board_CommentDTO();
				result.setComment_seq(rs.getInt("comment_seq"));
				result.setId(rs.getString("id"));
				result.setComment_contents(rs.getString("comment_contents"));
				result.setBoard_seq(rs.getInt("board_seq"));
				result.setWritedate(rs.getString("writedate"));
				return result;
			}
	
		});
	}
		
	@Override
	public Board_CommentDTO getOneComment(int comment_seq) throws Exception {
		String sql = "select * from board_comment where comment_seq=?";
		List<Board_CommentDTO> temp = template.query(sql, new Object[] {comment_seq}, (rs, rowNum) -> {
			Board_CommentDTO c = new Board_CommentDTO();
			c.setBoard_seq(rs.getInt("board_seq"));
			c.setComment_contents(rs.getString("comment_contents"));
			c.setComment_seq(rs.getInt("comment_seq"));
			c.setId(rs.getString("id"));
			c.setWritedate(rs.getString("writedate"));
			return c;
		});
		return temp.get(0);
	}
	
	public int getBoard_seq(int comment_seq) throws Exception {
		String sql = "select board_seq from board_comment where comment_seq = ?";
		return template.query(sql, new Integer[] {comment_seq},new RowMapper<Integer>() {

			@Override
			public Integer mapRow(ResultSet rs, int rowNum) throws SQLException {
				return rs.getInt(1);
			}
		
		}).get(0);
		}  
	
	
	
}  

