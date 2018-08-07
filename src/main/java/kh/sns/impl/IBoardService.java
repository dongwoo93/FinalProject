package kh.sns.impl;

import org.springframework.stereotype.Service;

import kh.sns.dto.BoardDTO;
import kh.sns.dto.Board_MediaDTO;
import kh.sns.interfaces.BoardService;

@Service
public class IBoardService implements BoardService {
	
	@Override
	public int insertNewArticle(BoardDTO boardContent, Board_MediaDTO boardMedia) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}
}
