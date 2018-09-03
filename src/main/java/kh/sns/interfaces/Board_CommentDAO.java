package kh.sns.interfaces;

import java.util.List;

import kh.sns.dto.Board_CommentDTO;

public interface Board_CommentDAO {
	
	public int insertComment(Board_CommentDTO dto) throws Exception;
	public List<Board_CommentDTO> getFeedComment(String id) throws Exception;
	public int delComment(int comment_seq) throws Exception;
	public int getCommentSeq() throws Exception;
	public int modComment(Board_CommentDTO dto) throws Exception;
	public int commentCount(int board_seq) throws Exception;
	public List<int[]> selectCommentCount() throws Exception;
	public List<Board_CommentDTO> getCommentList(int board_seq) throws Exception;
	
	// 추가
	public Board_CommentDTO getOneComment(int comment_seq) throws Exception;
	
	public int getBoard_seq(int comment_seq) throws Exception;
	public List<Board_CommentDTO> simpleGetComments(String id);
	

}
