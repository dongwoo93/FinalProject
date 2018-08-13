package kh.sns.impl;

import java.util.List;


import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

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
		String sql = "insert into board_comment values(board_comment_seq.nextval,?,?,?,default)";
System.out.println(dto.getComment_contents() + " : " + dto.getId() + " : " + dto.getBoard_seq()); 
		return template.update(sql, dto.getBoard_seq(),dto.getId(),dto.getComment_contents());
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
	
	
	


}
