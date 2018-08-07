package kh.sns.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kh.sns.dto.BoardDTO;
import kh.sns.dto.Board_MediaDTO;
import kh.sns.interfaces.BoardDAO;
import kh.sns.interfaces.BoardService;

@Service
public class IBoardService implements BoardService {
	
	@Autowired
	BoardDAO bdao;
	
	@Override
	// @Transactional("txManager")
	public int insertNewArticle(BoardDTO boardContent, Board_MediaDTO boardMedia) throws Exception {
		
		int contentResult = bdao.insertNewBoardContent(boardContent);
		int mediaResult = bdao.insertNewMedia(boardMedia);
		
		return contentResult * mediaResult;
	}
}
