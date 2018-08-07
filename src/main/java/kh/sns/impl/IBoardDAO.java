package kh.sns.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import kh.sns.dto.BoardDTO;
import kh.sns.dto.Board_MediaDTO;
import kh.sns.interfaces.BoardDAO;

@Repository
public class IBoardDAO implements BoardDAO  {

	@Autowired
	private JdbcTemplate template;

	@Override
	public int insertNewBoardContent(BoardDTO board) {

		String sql = "insert into board values(board_seq.nextval, ?, ?, sysdate, default, default)";
		return template.update(sql, board.getContents(), board.getId());
	}
	
	@Override
	public int insertNewMedia(Board_MediaDTO media) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

}
