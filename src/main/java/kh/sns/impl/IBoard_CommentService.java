package kh.sns.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kh.sns.dto.Board_CommentDTO;
import kh.sns.interfaces.Board_CommentDAO;
import kh.sns.interfaces.Board_CommentService;

@Service
public class IBoard_CommentService implements Board_CommentService {
	
	@Autowired
	private Board_CommentDAO board_commentdao;

	@Override
	public int insertComment(Board_CommentDTO dto) throws Exception {
		return board_commentdao.insertComment(dto);
	}
	
	public List<Board_CommentDTO> getFeedComment(String id) throws Exception {
		return board_commentdao.getFeedComment(id);
	}
	
	public int delComment(int comment_seq) throws Exception {
		return board_commentdao.delComment(comment_seq);
	}

	
	public int getCommentSeq() throws Exception {
		return board_commentdao.getCommentSeq();
	}
	
	public int modComment(Board_CommentDTO dto) throws Exception {
		return board_commentdao.modComment(dto);
	}
	
	public int commentCount(int board_seq) throws Exception {
		return board_commentdao.commentCount(board_seq);
	}

	@Override
	public List<int[]> selectCommentCount() throws Exception {
		return board_commentdao.selectCommentCount();
	}

	@Override
	public List<Board_CommentDTO> getCommentList(int board_seq) throws Exception {
		// TODO Auto-generated method stub
		return board_commentdao.getCommentList(board_seq);
	}
	
	@Override
	public Board_CommentDTO getOneComment(int comment_seq) throws Exception {
		return board_commentdao.getOneComment(comment_seq);
	}
}
