package kh.sns.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kh.sns.dto.BoardDTO;
import kh.sns.interfaces.BoardDAO;
import kh.sns.dto.Board_MediaDTO;
import kh.sns.dto.MemberDTO;
import kh.sns.interfaces.BoardService;

@Service
public class IBoardService implements BoardService {

	@Autowired
	private BoardDAO dao;
	
	@Override
	public List<BoardDTO> getFeed(String id) throws Exception {
		return dao.getFeed(id);
	}

	public List<BoardDTO> getBoard(String id) {
		return this.dao.getBoard(id);
	}


	@Override
	public List<BoardDTO> search(String keyword) {
		return this.dao.search(keyword);
	}
	
	
	
		
	
	@Override	
	// @Transactional("txManager")
	public int insertNewArticle(BoardDTO boardContent, List<Board_MediaDTO> boardMediaList) throws Exception {
		
		// 글 삽입
		int contentResult = dao.insertNewBoardContent(boardContent);
		int mediaResult = 1;
		
		// 그림 등 삽입
		if(contentResult == 1) {
			int boardCurrVal = dao.selectBoardSeqRecentCurrVal();
			System.out.println("boardCurrVal" + boardCurrVal);
			
			for(Board_MediaDTO media : boardMediaList) {
				media.setBoard_seq(boardCurrVal);
				mediaResult *= dao.insertNewMedia(media);
			}	
			
			// 태그 삽입
			boardContent.setBoard_seq(boardCurrVal);
			int[] hashTagResult = dao.insertHashTags(boardContent);
			
			for(int i : hashTagResult) {
				System.out.print(i);
			}
		} 	
		
		
		
		return contentResult * mediaResult;
	}
}
