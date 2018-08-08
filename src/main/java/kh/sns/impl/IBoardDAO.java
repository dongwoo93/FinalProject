package kh.sns.impl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import kh.sns.dto.BoardDTO;
import kh.sns.dto.Board_TagsDTO;
import kh.sns.dto.Board_MediaDTO;
import kh.sns.interfaces.BoardDAO;

@Repository
public class IBoardDAO implements BoardDAO  {
	
	private static final String SAVE_PATH = "/upload";
	private static final String PREFIX_URL = "/upload/";

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
	
	// Search 
	@Override
	public List<Board_TagsDTO> search(String keyword) {
		String sql = "select sep from board_tags where tags like '%'||?||'%'";
		return template.query(sql, new Object[] {keyword}, new RowMapper<Board_TagsDTO>() {

			@Override
			public Board_TagsDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
				Board_TagsDTO tags = new Board_TagsDTO();
				tags.setBoard_seq(rs.getInt(1));
				tags.setTags(rs.getString(2));
				return tags;
			}

		});
	}
	
	@Override
	public List<Board_MediaDTO> search2(String media) throws Exception {
		String sql = "select seq from board_media where system_file_name=?";
		return template.query(sql, new Object[] {media}, new RowMapper<Board_MediaDTO>() {

			@Override
			public Board_MediaDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
				Board_MediaDTO media = new Board_MediaDTO();
				media.setMedia_seq(rs.getInt(1));
				media.setMedia_type(rs.getString(2));
				media.setSystem_file_name(rs.getString(3));
				return media;
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

	@Override
	public int insertNewBoardContent(BoardDTO board) {

		String sql = "insert into board values(board_seq.nextval, ?, ?, sysdate, default, default)";
		return template.update(sql, board.getContents(), board.getId());
	}
	
	/*
	 * (non-Javadoc)
	 * @see kh.sns.interfaces.BoardDAO#insertNewMedia(kh.sns.dto.Board_MediaDTO)
	 * 
	 * 편의상 여기다 일단 만들고 나중에 필요하면 별도 클래스로 분리합니다.
	 */
	
	@Override
	public int insertNewMedia(Board_MediaDTO media) throws Exception {
		
		String sql = "insert into board_media values(board_media_seq.nextval, ?, ?, ?, ?)";
		return template.update(sql, media.getBoard_seq(), media.getMedia_type(), media.getOriginal_file_name(), media.getSystem_file_name());
	}
	
	public int selectBoardSeqRecentCurrVal() throws Exception {
		
		String sql = "select board_seq.currval from dual";
		
		List<Integer> list = template.query(sql, (rs, rowNum) -> {
			return rs.getInt(1);	
		});
		
		return list.get(0);
	}

}
