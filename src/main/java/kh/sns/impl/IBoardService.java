package kh.sns.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
	public int insertNewArticle(BoardDTO boardContent, List<Board_MediaDTO> boardMediaList) throws Exception {
		
		int contentResult = bdao.insertNewBoardContent(boardContent);
		int mediaResult = 1;
		
		if(contentResult == 1) {
			int boardCurrVal = bdao.selectBoardSeqRecentCurrVal();
			System.out.println("boardCurrVal" + boardCurrVal);
			
			for(Board_MediaDTO media : boardMediaList) {
				media.setBoard_seq(boardCurrVal);
				mediaResult *= bdao.insertNewMedia(media);
			}	
		} 		
		
		return contentResult * mediaResult;
	}
	
	@Override
	public List<BoardDTO> getFeed(String id) throws Exception {
		return bdao.getFeed(id);
	}

	public List<BoardDTO> getBoard(String id) {
		return this.bdao.getBoard(id);
	}
}
