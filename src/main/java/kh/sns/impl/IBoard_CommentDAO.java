package kh.sns.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import kh.sns.dto.Board_CommentDTO;
import kh.sns.interfaces.Board_CommentDAO;

@Repository
public class IBoard_CommentDAO implements Board_CommentDAO {
	
	@Autowired
	private JdbcTemplate template;

	@Override
	public int insertComment(Board_CommentDTO dto) throws Exception {
		String sql = "insert into board_comment values(board_comment_seq.nextval,?,?,?,default)";
System.out.println(dto.getComment_contents() + " : " + dto.getId() + " : " + dto.getBoard_seq()); 
		return template.update(sql, dto.getBoard_seq(),dto.getId(),dto.getComment_contents());
	}
}
