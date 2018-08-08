package kh.sns.interfaces;

import kh.sns.dto.Board_CommentDTO;

public interface Board_CommentDAO {
	
	public int insertComment(Board_CommentDTO dto) throws Exception;

}
