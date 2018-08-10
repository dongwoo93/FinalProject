package kh.sns.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import kh.sns.dto.Board_BookmarkDTO;
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
		String sql = "delete from board_bookmark where board_seq=?, id=?";
		return template.update(sql,dto.getBoard_seq(), dto.getId());
	}

}
