package kh.sns.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import kh.sns.dto.BoardDTO;
import kh.sns.dto.Board_MediaDTO;
import kh.sns.interfaces.BoardDAO;

@Repository
public class IBoardDAO implements BoardDAO  {
	
	private static final String SAVE_PATH = "/upload";
	private static final String PREFIX_URL = "/upload/";

	@Autowired
	private JdbcTemplate template;

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
		
		String sql = "insert into board_media values(board_media_seq.nextval, 2, ?, ?, ?)";
		return template.update(sql, media.getMedia_type(), media.getOriginal_file_name(), media.getSystem_file_name());
	}

}
