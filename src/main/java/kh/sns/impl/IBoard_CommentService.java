package kh.sns.impl;

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

}
